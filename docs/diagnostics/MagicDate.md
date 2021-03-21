# Магические даты (MagicDate)

 Тип | Поддерживаются<br>языки | Важность | Включена<br>по умолчанию | Время на<br>исправление (мин) | Тэги 
 :-: | :-: | :-: | :-: | :-: | :-: 
 `Дефект кода` | `BSL`<br>`OS` | `Незначительный` | `Да` | `5` | `badpractice`<br>`brainoverload` 

## Параметры 

 Имя | Тип | Описание | Значение по умолчанию 
 :-: | :-: | :-- | :-: 
 `authorizedDates` | `Строка` | ```Разрешенные даты, через запятую. Например: 00010101,00010101000000,000101010000``` | ```00010101,00010101000000,000101010000``` 

<!-- Блоки выше заполняются автоматически, не трогать -->
## Описание диагностики
Магическая дата - это любая дата в вашем коде, которая не очевидна без погружения в контекст.

## Примеры

Плохо

```bsl
Если текДата < '20151021' Тогда
    ХоверБордБудетИзобретен = Неопределено;
КонецЕсли;
``` 

Хорошо

```bsl
ПредсказаннаяДата = '20151021'; 
Если текДата < ПредсказаннаяДата Тогда
    ХоверБордБудетИзобретен = Неопределено;
КонецЕсли;
```

## Сниппеты

<!-- Блоки ниже заполняются автоматически, не трогать -->
### Экранирование кода

```bsl
// BSLLS:MagicDate-off
// BSLLS:MagicDate-on
```

### Параметр конфигурационного файла

```json
"MagicDate": {
    "authorizedDates": "00010101,00010101000000,000101010000"
}
```