# [VipM-I] MWallet

Расширение для контроллера предметов, добавляющее предметы, связанные с [ModularWallet](https://github.com/ArKaNeMaN/amxx-ModularWallet).

## `MWallet-Buy`

Покупка предмета(ов) за указанное количество указанной валюты.

### Параметры

| Параметр   | Тип     | Обязательный | Описание
| :---       | :---    |    :---:     | :---
| `Currency` | Строка  |      +       | Название валюты, зарегистрированной в ModularWallet.
| `Cost`     | Ц.Число |      +       | Стоимость.
| `Items`    | Массив  |      +       | Список предметов, которые будут выданы при успешной оплате.

### Пример

```jsonc
{
    "Type": "MWallet-Buy",
    "Currency": "GameMoney",
    "Cost": 5000,
    "Items": {
        "Type": "HealthNade",
        "ThrowHealingAmount": 100,
        "DrinkHealingAmount": 100
    }
}
```

_Покупка ультимативной [лечащей гранаты](https://github.com/ArKaNeMaN/VipM-I-HealthNade) за $5000_
