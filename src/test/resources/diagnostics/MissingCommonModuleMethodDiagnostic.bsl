Процедура Тест1()
    ПервыйОбщийМодуль.МетодНесуществующий(1, 2); // ошибка
    А = ПервыйОбщийМодуль.ДругойМетодНесуществующий(); // ошибка
    ПервыйОбщийМодуль.ЕщеМетодНесуществующий().Добавить(); // ошибка
    ПервыйОбщийМодуль.ЕщеОдинМетодНесуществующий().Реквизит = 10; // ошибка
    Б = ПервыйОбщийМодуль.ЕщеДругойМетодНесуществующий().Добавить(); // ошибка

    НесуществующийОбщийМодульИлиПростоПеременная.МетодНесуществующий(1, 2); // не ошибка
КонецПроцедуры

Процедура Тест2_ОбращениеКПриватномуМетоду()
    ПервыйОбщийМодуль.РегистрацияИзмененийПередУдалением(Источник, Отказ); // ошибка
    А = ПервыйОбщийМодуль.Тест(); // ошибка
    ПервыйОбщийМодуль.Тест().Добавить(); // ошибка
    ПервыйОбщийМодуль.Тест().Реквизит = 10; // ошибка
    Б = ПервыйОбщийМодуль.Тест().Добавить(); // ошибка
КонецПроцедуры

Процедура Тест3()
    ПервыйОбщийМодуль.НеУстаревшаяПроцедура(); // не ошибка
    А = ПервыйОбщийМодуль.НеУстаревшаяФункция(); // не ошибка
    ПервыйОбщийМодуль.НеУстаревшаяФункция().Добавить(); // не ошибка
    ПервыйОбщийМодуль.НеУстаревшаяФункция().Реквизит = 10; // не ошибка
    Б = ПервыйОбщийМодуль.НеУстаревшаяФункция().Добавить(); // не ошибка
КонецПроцедуры

Процедура Тест4_ИмяПараметр(ПервыйОбщийМодуль)
    ПервыйОбщийМодуль.МетодНесуществующий(1, 2); // не ошибка
    А = ПервыйОбщийМодуль.ДругойМетодНесуществующий(); // не ошибка
    ПервыйОбщийМодуль.ЕщеМетодНесуществующий().Добавить(); // не ошибка
    ПервыйОбщийМодуль.ЕщеОдинМетодНесуществующий().Реквизит = 10; // не ошибка
    Б = ПервыйОбщийМодуль.ЕщеДругойМетодНесуществующий().Добавить(); // не ошибка
КонецПроцедуры

Процедура Тест5_МодулиМенеджеров()
    Справочники.Справочник1.НесуществующийМетод(); // пока не ошибка
КонецПроцедуры