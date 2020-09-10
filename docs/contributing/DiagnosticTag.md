# Тэги диагностик

Каждая диагностика имеет набор тэгов, которые по сути являются признаком группы, к которой относится диагностика.  
Для того, чтобы выбрать нужный набор тэгов, ниже приведено их подробное описание.

**ВНИМАНИЕ:** у диагностики может быть от 1-го до 3-х тэгов

## Описание тэгов

- `STANDARD` - Используется при диагностировании нарушений стандартов фирмы 1С
- `LOCKINOS` - Диагностики с данным тэгом отмечают функциональность, работоспособность которой не гарантируется в других ОС
- `SQL` - Используется при диагностировании любых проблем с запросами 1С
- `PERFORMANCE` - Необходимо использовать данных тэг для диагностик, обнаруживающих проблемы производительности
- `BRAINOVERLOAD` - Стоит использовать для диагностик сложного для восприятия кода
- `BADPRACTICE` - Наиболее распространенный набор диагностик, обнаруживающих плохую практику программирования
- `CLUMSY` - Используется при обнаружении лишних алгоритмических конструкций, действий
- `DESIGN` - Необходимо использовать при обнаружении ошибок в проектировании решения, архитектурых проблем
- `SUSPICIOUS` - Используется для диагностик странного кода, на который обязательно стоит обратить внимание
- `UNPREDICTABLE` - Необходимо использовать в случае обнаружения работающего кода, но который может себя повести непредсказуемо
- `DEPRECATED` - Данным тэгом необходимо помечать диагностики, обнаруживающие использование устаревшей функциональности, методов, имен методов и т.д.
- `ERROR` - Используется при диагностировании ошибки кода, использовании несуществующих конструкций языка, методов за границей области видимости и т.д.
- `LOCALIZE` - Используется при диагностировании ошибок и возможных проблем локализации приложения на другие языки