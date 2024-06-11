# InnoSetup.SystemTimeUtils
System Time-utils for Inno Setup

```Delphi
  function IsLeapYear(const AYear: Integer): Boolean;
  procedure ClearSystemTime(var ASystemTime: SYSTEMTIME);
  function MonthLength(const AYear, AMonth: Integer): Integer;
  function InitSystemTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond, AMillisecond: WORD): SYSTEMTIME;
  function DecMonth(const ATime: SYSTEMTIME; const AMonthsToDec: Integer): SYSTEMTIME;
  function SameSystemTime(const ASystemTime1, ASystemTime2: SYSTEMTIME): Boolean;
  function SystemTimeGreater(const ASystemTime1, ASystemTime2: SYSTEMTIME): Boolean;
  function CompareSystemTime(const ASystemTime1, ASystemTime2: SYSTEMTIME): Integer;
  function GetSortableTimeStampStr(const ATimeStamp: SYSTEMTIME): string;
```

