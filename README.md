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

### Примеры использования

#### Отдельный пример платного предмета

```jsonc
{
    "Type": "MWallet-Buy",
    "Currency": "GameMoney",
    "Cost": 500,
    "Items": {
        "Type": "Weapon",
        "Name": "weapon_deagle"
    }
}
```

#### Покупка оружия в меню

Покупка AK-47 и M4A1 через оружейное меню за игровые деньги.

```jsonc
{
    "Name": "Название меню",
    "Title": "Заголовок меню",
    
    "Items": [
        {
            "Title": "AK-47 [1500$]",
            "Items": {
                "Type": "MWallet-Buy",
                "Currency": "GameMoney",
                "Cost": 1500,
                "Items": {
                    "Type": "Weapon",
                    "Name": "weapon_ak47"
                }
            }
        },
        {
            "Title": "M4A1 [1600$]",
            "Items": {
                "Type": "MWallet-Buy",
                "Currency": "GameMoney",
                "Cost": 1600,
                "Items": {
                    "Type": "Weapon",
                    "Name": "weapon_m4a1"
                }
            }
        }
    ]
}
```

#### Покупка случайного оружия

Покупка случайного оружия в меню

```jsonc
{
    "Name": "Случайное меню",
    
    "Items": [
        {
            "Title": "Случайный пистолет [400$]",
            "Items": {
                "Type": "MWallet-Buy",
                "Currency": "GameMoney",
                "Cost": 400,
                "Items": {
                    "Type": "Random",
                    "Items": [
                        {
                            "Type": "Weapon",
                            "Name": "weapon_deagle"
                        },
                        {
                            "Type": "Weapon",
                            "Name": "weapon_usp"
                        },
                        {
                            "Type": "Weapon",
                            "Name": "weapon_elite"
                        },
                        {
                            "Type": "Weapon",
                            "Name": "weapon_fiveseven"
                        },
                        {
                            "Type": "Weapon",
                            "Name": "weapon_p228"
                        }
                    ]
                }
            }
        },
        {
            "Title": "Случайная винтовка [2000$]",
            "Items": {
                "Type": "MWallet-Buy",
                "Currency": "GameMoney",
                "Cost": 2000,
                "Items": {
                    "Type": "Random",
                    "Items": [
                        {
                            "Type": "Weapon",
                            "Name": "weapon_m4a1"
                        },
                        {
                            "Type": "Weapon",
                            "Name": "weapon_ak47"
                        },
                        {
                            "Type": "Weapon",
                            "Name": "weapon_galil"
                        },
                        {
                            "Type": "Weapon",
                            "Name": "weapon_famas"
                        },
                        {
                            "Type": "Weapon",
                            "Name": "weapon_aug"
                        }
                    ]
                }
            }
        }
    ]
}
```
