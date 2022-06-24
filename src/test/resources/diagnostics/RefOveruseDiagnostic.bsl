Процедура Тест()

    Запрос = Новый Запрос;
    Запрос.Текст = "ВЫБРАТЬ Файлы.Файл.Ссылка, // ошибка
                    | Файлы.Файл
                    | ИЗ
                    | СлужебныеФайлы КАК Файлы";
КонецПроцедуры

Процедура Тест2()
    Запрос = Новый Запрос;
    Запрос.Текст =
    "ВЫБРАТЬ РАЗРЕШЕННЫЕ
    |   СлужебныеФайлы.Файл.Ссылка КАК Ссылка, // ошибка
    |   СлужебныеФайлы.Владелец.Ссылка КАК Владелец // ошибка
    |ИЗ
    |   РегистрСведений.СлужебныеФайлы КАК СлужебныеФайлы
    |ГДЕ
    |   СлужебныеФайлы.Отношение = ЗНАЧЕНИЕ(Перечисление.ОтношенияСлужебныхФайлов.ВизуализацияЭП)";
КонецПроцедуры

Процедура Тест3()
    Запрос = Новый Запрос;
    Запрос.Текст =
    "ВЫБРАТЬ РАЗРЕШЕННЫЕ
    |   Ссылка.Ссылка КАК Ссылка, // ошибка
    |   СлужебныеФайлы.Владелец КАК Владелец
    |ИЗ
    |   РегистрСведений.СлужебныеФайлы КАК СлужебныеФайлы
    |ГДЕ
    |   СлужебныеФайлы.Отношение = ЗНАЧЕНИЕ(Перечисление.ОтношенияСлужебныхФайлов.ВизуализацияЭП)";
КонецПроцедуры

Процедура Тест4()
    Запрос = Новый Запрос;
    Запрос.Текст =
    "ВЫБРАТЬ
    |   Документ1.Файл.Ссылка КАК Ссылка,           // ошибка
    |   Документ2.Контрагент.Ссылка КАК Контрагент  // ошибка
    |ИЗ
    |   Документ.Документ1 КАК Документ1
    |       ЛЕВОЕ СОЕДИНЕНИЕ Документ.Документ2 КАК Документ2
    |       ПО Документ1.Ссылка = Документ2.Ссылка";
КонецПроцедуры

Процедура Тест5()
    Запрос = Новый Запрос;
    Запрос.Текст =
    "ВЫБРАТЬ *
    |ИЗ
    |   Документ.Документ1 КАК Документ1";
КонецПроцедуры

Процедура Тест6()
    Запрос = Новый Запрос;
    Запрос.Текст =
    "ВЫБРАТЬ Документ.Документ1.Файл.Ссылка как п1,        // ошибка
    |         Справочник.Справочник1.Файл.Ссылка как п2";  // ошибка
КонецПроцедуры

Процедура Тест7()
    Запрос = Новый Запрос;
    Запрос.Текст =
    "ВЫБРАТь
    |    Таблица.Ссылка
    |ИЗ
    |    &Таблица КАК Таблица"
КонецПроцедуры

Процедура Тест8()
    Запрос = Новый Запрос;
    Запрос.Текст =
    "ВЫБРАТь
    |    Таблица.Ссылка
    |ИЗ
    |    Справочник." + ИмяСправочника + " КАК Таблица"
КонецПроцедуры

Процедура Тест9()
    Запрос = Новый Запрос;
    Запрос.Текст =
    "ВЫБРАТь
    |    Таблица.Ссылка.Ссылка
    |ИЗ
    |    %1 КАК Таблица"
КонецПроцедуры

Процедура Тест10()
    Запрос = Новый Запрос;
    Запрос.Текст =
    "ВЫБРАТь
    |   Таблица.Ссылка,
    |   Таблица.Ссылка.Ссылка // ошибка
    |ПОМЕСТИТЬ ВТ
    |ИЗ
    |    &Таблица КАК Таблица"
КонецПроцедуры

Процедура Тест11()
    Запрос = Новый Запрос;
ТекстЗапроса =
    "ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
    |  ТаблицаКонтактнаяИнформация.АдресЭП КАК Адрес,
    |  ТаблицаКонтакт.Ссылка КАК Контакт
    |ПОМЕСТИТЬ КонтактыАдреса
    |ИЗ
    |  Справочник.Пользователи КАК ТаблицаКонтакт
    |    ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Пользователи.КонтактнаяИнформация КАК ТаблицаКонтактнаяИнформация
    |    ПО (ТаблицаКонтактнаяИнформация.Ссылка = ТаблицаКонтакт.Ссылка)
    |      И (ТаблицаКонтактнаяИнформация.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.АдресЭлектроннойПочты))
    |ГДЕ
    |  ТаблицаКонтакт.Ссылка В(&МассивКонтактов)
    |  И НЕ ТаблицаКонтакт.Служебный
    |  И НЕ ТаблицаКонтакт.Недействителен
    |  И НЕ ТаблицаКонтакт.ПометкаУдаления
    |
    |ОБЪЕДИНИТЬ ВСЕ
    |
    |ВЫБРАТЬ
    |  ТаблицаКонтактнаяИнформация.АдресЭП,
    |  ТаблицаКонтакт.Ссылка
    |ИЗ
    |  Справочник.Пользователи КАК ТаблицаКонтакт
    |    ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Пользователи.КонтактнаяИнформация КАК ТаблицаКонтактнаяИнформация
    |    ПО (ТаблицаКонтактнаяИнформация.Ссылка = ТаблицаКонтакт.Ссылка)
    |      И (ТаблицаКонтактнаяИнформация.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.АдресЭлектроннойПочты))
    |ГДЕ
    |  НЕ ТаблицаКонтакт.Служебный
    |  И НЕ ТаблицаКонтакт.Недействителен
    |  И НЕ ТаблицаКонтакт.ПометкаУдаления
    |  И ИСТИНА В
    |      (ВЫБРАТЬ
    |        ИСТИНА
    |      ИЗ
    |        РегистрСведений.СоставыГруппПользователей КАК СоставыГруппПользователей
    |      ГДЕ
    |        СоставыГруппПользователей.Пользователь = ТаблицаКонтакт.Ссылка
    |        И СоставыГруппПользователей.ГруппаПользователей В (&МассивКонтактов))";
КонецПроцедуры

Процедура Тест12()
        Запрос = Новый Запрос;
        Запрос.Текст =
        "ВЫБРАТЬ
            |  Контрагенты.Ссылка КАК Контрагент,
            |ИЗ
            |  Справочник.Контрагенты КАК ТаблицаКонтакт";
КонецПроцедуры

Процедура Тест13()
        ТекстЗапроса =
        "ВЫБРАТЬ
        |    Контрагенты.Ссылка КАК Контрагент,
        |    Контрагенты.Ссылка.ЮрФизЛицо КАК ЮрФизЛицо // ошибка
        |ИЗ
        |    Справочник.Контрагенты КАК Контрагенты
        |ГДЕ
        |    Контрагенты.ИНН = &ИНН";
КонецПроцедуры

Процедура Тест14()
        ТекстЗапроса =
        "ВЫБРАТЬ
        |    Контрагенты.Ссылка КАК Контрагент,
        |    Контрагенты.Менеджер.Ссылка.Наименование КАК Менеджер // ошибка
        |ИЗ
        |    Справочник.Контрагенты КАК Контрагенты
        |ГДЕ
        |    Контрагенты.ИНН = &ИНН";
КонецПроцедуры

Процедура Тест15()
        ТекстЗапроса =
        "ВЫБРАТЬ
        |    Контрагенты.Ссылка КАК Контрагент
        |ИЗ
        |    Справочник.Контрагенты КАК Контрагенты
        |ГДЕ
        |    Контрагенты.Ссылка.ИНН = &ИНН"; // ошибка
КонецПроцедуры

Процедура Тест16()
        ТекстЗапроса =
        "ВЫБРАТЬ
        |    Артикул КАК Артикул // не задано имя таблицы
        |ИЗ
        |   Справочник.Номенклатура КАК Номенклатура";
КонецПроцедуры

Процедура Тест17()
        ТекстЗапроса =
        "ВЫБРАТЬ
        |    Таблица.Ссылка КАК Ссылка
        |ИЗ
        |    Документ.Документ1.ТабличнаяЧасть1 КАК Таблица
        |ГДЕ
        |    Таблица.Ссылка.Реквизит1 = &ИНН"; // не ошибка
КонецПроцедуры

Процедура Тест18()
        ТекстЗапроса =
        "ВЫБРАТЬ
        |    Таблица.Ссылка КАК Ссылка
        |ИЗ
        |    РегистрСведений.РегистрСведений1.СрезПоследних КАК Таблица
        |ГДЕ
        |    Таблица.Ссылка.Реквизит1 = &ИНН"; // не ошибка
КонецПроцедуры

Процедура Тест19()
        ТекстЗапроса =
        "ВЫБРАТЬ
        |    Таблица.Ссылка КАК Ссылка
        |ИЗ
        |    (ВЫБРАТЬ Таблица.Ссылка ИЗ Таблица КАК Таблица) КАК Таблица // было падение анализа
        |ГДЕ
        |    Таблица.Ссылка.Реквизит1 = &ИНН"; // ошибка
КонецПроцедуры

Процедура Тест20()
        ТекстЗапроса =
        "ВЫБРАТЬ
        |    Таблица.Ссылка КАК Ссылка
        |ИЗ
        |    (ВЫБРАТЬ Таблица.Ссылка ИЗ Таблица) КАК Таблица // было падение анализа
        |ГДЕ
        |    Таблица.Ссылка.Реквизит1 = &ИНН"; // ошибка
КонецПроцедуры

Процедура Тест21()
        ТекстЗапроса =
        "ВЫБРАТЬ
        |    Таблица.Ссылка КАК Ссылка
        |ИЗ
        |    Таблица КАК Таблица
        |    ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ Таблица.Ссылка ИЗ Таблица) // было падение анализа
        |    КАК Таблица2 ПО Истина
        |ГДЕ
        |    Таблица2.Ссылка.Реквизит1 = &ИНН"; // ошибка
КонецПроцедуры

Процедура Тест22()
        ТекстЗапроса =
        "ВЫБРАТЬ
        |    УпаковкиНоменклатуры.Ссылка КАК Упаковка
        |ИЗ
        |    ТоварыКОтгрузке КАК ТоварыКОтгрузке
        |    ЛЕВОЕ СОЕДИНЕНИЕ Справочник.УпаковкиНоменклатуры КАК УпаковкиНоменклатуры
        |    ПО Истина
        |    ЛЕВОЕ СОЕДИНЕНИЕ Справочник.УпаковкиНоменклатуры КАК УпаковкиНоменклатуры // спец.дубль имени, было падение анализа
        |    ПО Истина"; // не ошибка
КонецПроцедуры

Процедура Тест23()
    ТекстЗапроса =
    "ВЫБРАТЬ
    |    СкладскиеЯчейки.Ссылка КАК Ячейка,
    |    СкладскиеЯчейки.Контейнер КАК Контейнер
    |ИЗ
    |    РегистрСведений.ПериодичностьИнвентаризацииЗон КАК ПериодичностьИнвентаризацииЗон
    |        ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.СкладскиеЯчейки КАК СкладскиеЯчейки
    |            ЛЕВОЕ СОЕДИНЕНИЕ Документ.ЗадачаПересчет КАК ЗадачаПересчет
    |            ПО СкладскиеЯчейки.Ссылка = ЗадачаПересчет.Ячейка
    |        ПО ПериодичностьИнвентаризацииЗон.Зона = СкладскиеЯчейки.СкладскаяЗона
    |ГДЕ
    |    ЗадачаПересчет.Ссылка ЕСТЬ NULL";
КонецПроцедуры

Процедура Тест24()
    Запрос.Текст =
        "ВЫБРАТЬ
        |    КОЛИЧЕСТВО(РАЗЛИЧНЫЕ усОстаткиТоваровОстатки.Контейнер) КАК Контейнер
        |ИЗ
        |    РегистрНакопления.усОстаткиТоваров.Остатки(
        |            ,
        |                Контейнер В
        |                    (ВЫБРАТЬ РАЗЛИЧНЫЕ
        |                        ЗадачаПеремещениеТовара.ТекущийКонтейнер КАК ТекущийКонтейнер
        |                    ИЗ
        |                        Документ.ЗадачаПеремещениеТовара КАК ЗадачаПеремещениеТовара
        |                    ГДЕ
        |                        ЗадачаПеремещениеТовара.Ссылка В (&МассивЗадач) // не ошибка
        |                    )
        |    ) КАК усОстаткиТоваровОстатки
        |";
КонецПроцедуры

Процедура Тест25()
    Запрос.Текст =
        "ВЫБРАТЬ
        |    КОЛИЧЕСТВО(РАЗЛИЧНЫЕ усОстаткиТоваровОстатки.Контейнер) КАК Контейнер
        |ИЗ
        |    РегистрНакопления.усОстаткиТоваров.Остатки(
        |            ,
        |                Контейнер В
        |                    (ВЫБРАТЬ РАЗЛИЧНЫЕ
        |                        ЗадачаПеремещениеТовара.ТекущийКонтейнер.Ссылка КАК ТекущийКонтейнер // ошибка
        |                    ИЗ
        |                        Документ.ЗадачаПеремещениеТовара КАК ЗадачаПеремещениеТовара
        |                    ГДЕ
        |                        ЗадачаПеремещениеТовара.Ссылка.Ссылка В (&МассивЗадач) // ошибка
        |                    )
        |    ) КАК усОстаткиТоваровОстатки
        |";
КонецПроцедуры
