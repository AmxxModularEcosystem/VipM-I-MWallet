#include <amxmodx>
#include <VipModular>
#include <ModularWallet>

#pragma semicolon 1
#pragma compress 1

public stock const PluginName[] = "[VipM-I] MWallet";
public stock const PluginVersion[] = "1.0.0";
public stock const PluginAuthor[] = "ArKaNeMaN";
public stock const PluginURL[] = "t.me/arkaneman";

new const BUY_TYPE_NAME[] = "MWallet-Buy";

public VipM_IC_OnInitTypes() {
    register_plugin(PluginName, PluginVersion, PluginAuthor);
    MWallet_Init();

    VipM_IC_RegisterType(BUY_TYPE_NAME);
    VipM_IC_RegisterTypeEvent(BUY_TYPE_NAME, ItemType_OnRead, "@OnBuyRead");
    VipM_IC_RegisterTypeEvent(BUY_TYPE_NAME, ItemType_OnGive, "@OnBuyGive");
}

@OnBuyRead(const JSON:jCfg, Trie:tParams) {
    TrieDeleteKey(tParams, "Name");

    if (!json_object_has_value(jCfg, "Currency", JSONString)) {
        VipM_Json_LogForFile(jCfg, "WARNING", "Parameter `Currency` required for `%s` item type.", BUY_TYPE_NAME);
        return VIPM_STOP;
    }

    if (!json_object_has_value(jCfg, "Cost", JSONNumber)) {
        VipM_Json_LogForFile(jCfg, "WARNING", "Parameter `Cost` required for `%s` item type.", BUY_TYPE_NAME);
        return VIPM_STOP;
    }

    if (!json_object_has_value(jCfg, "Items")) {
        VipM_Json_LogForFile(jCfg, "WARNING", "Parameter `Items` required for `%s` item type.", BUY_TYPE_NAME);
        return VIPM_STOP;
    }

    new sCurrencyName[MWALLET_CURRENCY_MAX_NAME_LEN];
    json_object_get_string(jCfg, "Currency", sCurrencyName, charsmax(sCurrencyName));
    new T_Currency:iCurrency = MWallet_Currency_Find(sCurrencyName);
    if (iCurrency == Invalid_Currency) {
        VipM_Json_LogForFile(jCfg, "WARNING", "Currency `%s` not found.", sCurrencyName);
        return VIPM_STOP;
    }
    TrieSetCell(tParams, "Currency", iCurrency);

    TrieSetCell(tParams, "Cost", json_object_get_real(jCfg, "Cost"));
    TrieSetCell(tParams, "Items", VipM_IC_JsonGetItems(json_object_get_value(jCfg, "Items")));

    return VIPM_CONTINUE;
}

@OnBuyGive(const UserId, const Trie:tParams) {
    new T_Currency:iCurrency = VipM_Params_GetCell(tParams, "Currency");
    new Float:fCost = VipM_Params_GetFloat(tParams, "Cost");
    new Array:aItems = VipM_Params_GetArr(tParams, "Items");

    if (!MWallet_Currency_IsEnough(iCurrency, UserId, fCost)) {
        return VIPM_STOP;
    }

    // Если по какой-то причине предметы не будут выданы, средства не спишутся.
    if (VipM_IC_GiveItems(UserId, aItems)) {
        MWallet_Currency_Credit(iCurrency, UserId, fCost);
        return VIPM_STOP;
    }

    return VIPM_CONTINUE;
}
