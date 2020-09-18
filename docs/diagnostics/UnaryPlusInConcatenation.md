# Унарный плюс в конкатенации строк (UnaryPlusInConcatenation)

 Тип | Поддерживаются<br>языки | Важность | Включена<br>по умолчанию | Время на<br>исправление (мин) | Тэги 
 :-: | :-: | :-: | :-: | :-: | :-: 
 `Ошибка` | `BSL`<br>`OS` | `Блокирующий` | `Да` | `1` | `suspicious`<br>`brainoverload` 

<!-- Блоки выше заполняются автоматически, не трогать -->
## Описание диагностики

При конкатенации строк разработчик может ошибочно написать код вида Строка + + Строка2, т.е. второй плюс платформа распознает как унарный и попытается выолнить преобразование к числу, что в большинстве случаев приведет к ошибке исполнения

## Сниппеты

<!-- Блоки ниже заполняются автоматически, не трогать -->
### Экранирование кода

```bsl
// BSLLS:UnaryPlusInConcatenation-off
// BSLLS:UnaryPlusInConcatenation-on
```

### Параметр конфигурационного файла

```json
"UnaryPlusInConcatenation": false
```