 [Code]
// UnitTestSystemtimeUtils.iss

type 
  TExpectedCompareResult = (ecrSmaller, ecrEqual, ecrLarger);

function  CompareResultToInteger(const ACompareResult: TExpectedCompareResult): Integer;
begin
  case ACompareResult of
    ecrSmaller: Result := -1; 
    ecrEqual: Result := 0;
    ecrLarger: Result := 1;
  end;
end;

procedure CheckCompareResult(const ATestName: string; const ATestIndex: Integer; const ASystemTime1, ASystemTime2: SYSTEMTIME; const AExpectedResult: TExpectedCompareResult);
var
  LResult: Integer;
  LExpectedResultInteger: Integer;
begin
  LExpectedResultInteger := CompareResultToInteger(AExpectedResult);
  LResult := CompareSystemTime(ASystemTime1, ASystemTime2);

  if LResult <> LExpectedResultInteger then
    RaiseException('Test "' + ATestName + '" - Index: ' + IntToStr(ATestIndex) + ' failed - Compare result got: ' + IntToStr(LResult) + ' Expected: ' 
      + IntToStr(LExpectedResultInteger) + 'while System times: "' + GetSortableTimeStampStr(ASystemTime1) + '" and "' 
      + GetSortableTimeStampStr(ASystemTime2) + '"'); 
end;


const 
  CST_NAME = 'TestCompareSystemTime';
procedure TestCompareSystemTime;
begin
  // CheckCompareResult(1, InitSystemDate(2025, 1, 1, True), InitSystemDate(2025, 1, 1, True), ecrSmaller); // uncomment to test raising
  CheckCompareResult(CST_NAME, 01, InitSystemDate(2025, 1, 1, True), InitSystemDate(2025, 1, 1, True), ecrEqual);
  CheckCompareResult(CST_NAME, 02, InitSystemDate(2025, 1, 1, False), InitSystemDate(2025, 1, 1, False), ecrEqual);
  CheckCompareResult(CST_NAME, 03, InitSystemDate(2025, 1, 1, False), InitSystemDate(2025, 1, 1, True), ecrSmaller);
  CheckCompareResult(CST_NAME, 04, InitSystemDate(2025, 1, 1, True), InitSystemDate(2025, 1, 1, False), ecrLarger);
    // 
  CheckCompareResult(CST_NAME, 05, InitSystemDate(2025, 1, 2, False), InitSystemDate(2025, 1, 1, False), ecrLarger);
  CheckCompareResult(CST_NAME, 06, InitSystemDate(2025, 2, 1, False), InitSystemDate(2025, 1, 1, False), ecrLarger);
  CheckCompareResult(CST_NAME, 07, InitSystemDate(2026, 1, 1, False), InitSystemDate(2025, 1, 1, False), ecrLarger);
  CheckCompareResult(CST_NAME, 08, InitSystemDate(2026, 2, 1, False), InitSystemDate(2025, 1, 1, False), ecrLarger);
  CheckCompareResult(CST_NAME, 09, InitSystemDate(2026, 1, 2, False), InitSystemDate(2025, 1, 1, False), ecrLarger);
  CheckCompareResult(CST_NAME, 10, InitSystemDate(2025, 1, 2, True), InitSystemDate(2025, 1, 1, True), ecrLarger);
  CheckCompareResult(CST_NAME, 11, InitSystemDate(2025, 2, 1, True), InitSystemDate(2025, 1, 1, True), ecrLarger);
  CheckCompareResult(CST_NAME, 12, InitSystemDate(2026, 1, 1, True), InitSystemDate(2025, 1, 1, True), ecrLarger);
  CheckCompareResult(CST_NAME, 13, InitSystemDate(2026, 2, 1, True), InitSystemDate(2025, 1, 1, True), ecrLarger);
  CheckCompareResult(CST_NAME, 14, InitSystemDate(2026, 1, 2, True), InitSystemDate(2025, 1, 1, True), ecrLarger);
  // 
  CheckCompareResult(CST_NAME, 15, InitSystemDate(2025, 1, 1, False), InitSystemDate(2025, 1, 2, False), ecrSmaller);
  CheckCompareResult(CST_NAME, 16, InitSystemDate(2025, 1, 1, False), InitSystemDate(2025, 3, 1, False), ecrSmaller);
  CheckCompareResult(CST_NAME, 17, InitSystemDate(2025, 1, 1, False), InitSystemDate(2026, 1, 1, False), ecrSmaller);
  CheckCompareResult(CST_NAME, 18, InitSystemDate(2025, 1, 1, False), InitSystemDate(2026, 2, 1, False), ecrSmaller);
  CheckCompareResult(CST_NAME, 19, InitSystemDate(2025, 1, 1, False), InitSystemDate(2026, 1, 2, False), ecrSmaller);
  CheckCompareResult(CST_NAME, 20, InitSystemDate(2025, 1, 1, False), InitSystemDate(2026, 2, 1, False), ecrSmaller);
  CheckCompareResult(CST_NAME, 21, InitSystemDate(2025, 1, 1, True), InitSystemDate(2025, 1, 2, True), ecrSmaller);
  CheckCompareResult(CST_NAME, 22, InitSystemDate(2025, 1, 1, True), InitSystemDate(2025, 3, 1, True), ecrSmaller);
  CheckCompareResult(CST_NAME, 23, InitSystemDate(2025, 1, 1, True), InitSystemDate(2026, 1, 1, True), ecrSmaller);
  CheckCompareResult(CST_NAME, 24, InitSystemDate(2025, 1, 1, True), InitSystemDate(2026, 2, 1, True), ecrSmaller);
  CheckCompareResult(CST_NAME, 25, InitSystemDate(2025, 1, 1, True), InitSystemDate(2026, 1, 2, True), ecrSmaller);
  CheckCompareResult(CST_NAME, 26, InitSystemDate(2025, 1, 1, True), InitSystemDate(2026, 2, 1, True), ecrSmaller);
  // 
  CheckCompareResult(CST_NAME, 27, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrEqual);
  CheckCompareResult(CST_NAME, 28, InitSystemTime(2025, 1, 1, 1, 1, 1, 1), InitSystemTime(2025, 1, 1, 1, 1, 1, 1), ecrEqual);
  // 
  CheckCompareResult(CST_NAME, 29, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2026, 1, 1, 0, 0, 0, 0), ecrSmaller);
  CheckCompareResult(CST_NAME, 30, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 2, 1, 0, 0, 0, 0), ecrSmaller);
  CheckCompareResult(CST_NAME, 31, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 2, 0, 0, 0, 0), ecrSmaller);
  CheckCompareResult(CST_NAME, 32, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 1, 0, 0, 0), ecrSmaller);
  CheckCompareResult(CST_NAME, 33, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 1, 0, 0), ecrSmaller);
  CheckCompareResult(CST_NAME, 34, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 1, 0), ecrSmaller);
  CheckCompareResult(CST_NAME, 35, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 1), ecrSmaller);
  // 
  CheckCompareResult(CST_NAME, 36, InitSystemTime(2026, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
  CheckCompareResult(CST_NAME, 37, InitSystemTime(2025, 2, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
  CheckCompareResult(CST_NAME, 38, InitSystemTime(2025, 1, 2, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
  CheckCompareResult(CST_NAME, 39, InitSystemTime(2025, 1, 1, 1, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
  CheckCompareResult(CST_NAME, 40, InitSystemTime(2025, 1, 1, 0, 1, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
  CheckCompareResult(CST_NAME, 41, InitSystemTime(2025, 1, 1, 0, 0, 1, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
  CheckCompareResult(CST_NAME, 42, InitSystemTime(2025, 1, 1, 0, 0, 0, 1), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
end;

const 
  USTV_NAME = 'TestUpdateSystemTimeValue';
procedure TestUpdateSystemTimeValue;
var
  LLocalTime: SYSTEMTIME;
begin
  LLocalTime := InitSystemDate(2025, 01, 01, False);
  
  CheckCompareResult(USTV_NAME, 01, UpdateSystemTimeValue(LLocalTime, 1, 1, 1, 1), InitSystemTime(2025, 1, 1, 1, 1, 1, 1), ecrEqual);
  // LUpdatedLocalTime := UpdateSystemTimeValue(LLocalTime, 0);
end;

const 
  DM_NAME = 'TestDecMonth';
procedure TestDecMonth;
var
  LTestTime: SYSTEMTIME;
begin
  // function DecMonth(const ATime: SYSTEMTIME; const AMonthsToDec: Integer): SYSTEMTIME;

  LTestTime := InitSystemDate(2000, 01, 01, False);
  
  CheckCompareResult(DM_NAME, 01, DecMonth(LTestTime, 01), InitSystemDate(1999, 12, 01, False), ecrEqual); 
  CheckCompareResult(DM_NAME, 02, DecMonth(LTestTime, 12), InitSystemDate(1999, 01, 01, False), ecrEqual); 
  CheckCompareResult(DM_NAME, 03, DecMonth(LTestTime, 24), InitSystemDate(1998, 01, 01, False), ecrEqual); 
  CheckCompareResult(DM_NAME, 04, DecMonth(LTestTime, 120), InitSystemDate(1990, 01, 01, False), ecrEqual); 
  CheckCompareResult(DM_NAME, 05, DecMonth(LTestTime, 240), InitSystemDate(1980, 01, 01, False), ecrEqual); 
  // TODO: Corner cases, these are quote easy
end;

const 
  IM_NAME = 'TestIncMonth';
procedure TestIncMonth;
var
  LTestTime: SYSTEMTIME;
begin
  // function IncMonth(const ATime: SYSTEMTIME; const AMonthsToInc: Integer): SYSTEMTIME;

  LTestTime := InitSystemDate(2000, 01, 01, False);
  
  CheckCompareResult(IM_NAME, 01, IncMonth(LTestTime, 01), InitSystemDate(2000, 02, 01, False), ecrEqual); 
  CheckCompareResult(IM_NAME, 02, IncMonth(LTestTime, 12), InitSystemDate(2001, 01, 01, False), ecrEqual); 
  CheckCompareResult(IM_NAME, 03, IncMonth(LTestTime, 24), InitSystemDate(2002, 01, 01, False), ecrEqual); 
  CheckCompareResult(IM_NAME, 04, IncMonth(LTestTime, 120), InitSystemDate(2010, 01, 01, False), ecrEqual); 
  CheckCompareResult(IM_NAME, 05, IncMonth(LTestTime, 240), InitSystemDate(2020, 01, 01, False), ecrEqual); 
  // TODO: Corner cases, these are quote easy
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  case CurStep of
    ssInstall:
      begin
        Log('CurStepChanged.CurStep = ssInstall');

        TestCompareSystemTime;
        TestUpdateSystemTimeValue;
        TestDecMonth;
        TestIncMonth;
        // TODO: rest of the tests
      end;
  end;
end;
