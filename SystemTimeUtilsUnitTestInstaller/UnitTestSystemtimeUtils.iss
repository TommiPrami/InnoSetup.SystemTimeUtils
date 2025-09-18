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

procedure CheckCompareResult(const ATestIndex: Integer; const ASystemTime1, ASystemTime2: SYSTEMTIME; const AExpectedResult: TExpectedCompareResult);
var
  LResult: Integer;
  LExpectedResultInteger: Integer;
begin
  LExpectedResultInteger := CompareResultToInteger(AExpectedResult);
  LResult := CompareSystemTime(ASystemTime1, ASystemTime2);

  if LResult <> LExpectedResultInteger then
    RaiseException('Test ' + IntToStr(ATestIndex) + ' failed - Compare result got: ' + IntToStr(LResult) + ' Expected: ' 
      + IntToStr(LExpectedResultInteger) + 'wite System times: "' + GetSortableTimeStampStr(ASystemTime1) + '" and "' 
      + GetSortableTimeStampStr(ASystemTime2) + '"'); 
end;

procedure TestCompareSystemTime;
begin
  // CheckCompareResult(1, InitSystemDate(2025, 1, 1, True), InitSystemDate(2025, 1, 1, True), ecrSmaller); // uncomment to test raising
  CheckCompareResult(1, InitSystemDate(2025, 1, 1, True), InitSystemDate(2025, 1, 1, True), ecrEqual);
  CheckCompareResult(2, InitSystemDate(2025, 1, 1, False), InitSystemDate(2025, 1, 1, False), ecrEqual);
  CheckCompareResult(3, InitSystemDate(2025, 1, 1, False), InitSystemDate(2025, 1, 1, True), ecrSmaller);
  CheckCompareResult(4, InitSystemDate(2025, 1, 1, True), InitSystemDate(2025, 1, 1, False), ecrLarger);
    // 
  CheckCompareResult(5, InitSystemDate(2025, 1, 2, False), InitSystemDate(2025, 1, 1, False), ecrLarger);
  CheckCompareResult(6, InitSystemDate(2025, 2, 1, False), InitSystemDate(2025, 1, 1, False), ecrLarger);
  CheckCompareResult(7, InitSystemDate(2026, 1, 1, False), InitSystemDate(2025, 1, 1, False), ecrLarger);
  CheckCompareResult(8, InitSystemDate(2026, 2, 1, False), InitSystemDate(2025, 1, 1, False), ecrLarger);
  CheckCompareResult(9, InitSystemDate(2026, 1, 2, False), InitSystemDate(2025, 1, 1, False), ecrLarger);
  CheckCompareResult(10, InitSystemDate(2025, 1, 2, True), InitSystemDate(2025, 1, 1, True), ecrLarger);
  CheckCompareResult(11, InitSystemDate(2025, 2, 1, True), InitSystemDate(2025, 1, 1, True), ecrLarger);
  CheckCompareResult(12, InitSystemDate(2026, 1, 1, True), InitSystemDate(2025, 1, 1, True), ecrLarger);
  CheckCompareResult(13, InitSystemDate(2026, 2, 1, True), InitSystemDate(2025, 1, 1, True), ecrLarger);
  CheckCompareResult(14, InitSystemDate(2026, 1, 2, True), InitSystemDate(2025, 1, 1, True), ecrLarger);
  // 
  CheckCompareResult(15, InitSystemDate(2025, 1, 1, False), InitSystemDate(2025, 1, 2, False), ecrSmaller);
  CheckCompareResult(16, InitSystemDate(2025, 1, 1, False), InitSystemDate(2025, 3, 1, False), ecrSmaller);
  CheckCompareResult(17, InitSystemDate(2025, 1, 1, False), InitSystemDate(2026, 1, 1, False), ecrSmaller);
  CheckCompareResult(18, InitSystemDate(2025, 1, 1, False), InitSystemDate(2026, 2, 1, False), ecrSmaller);
  CheckCompareResult(19, InitSystemDate(2025, 1, 1, False), InitSystemDate(2026, 1, 2, False), ecrSmaller);
  CheckCompareResult(20, InitSystemDate(2025, 1, 1, False), InitSystemDate(2026, 2, 1, False), ecrSmaller);
  CheckCompareResult(21, InitSystemDate(2025, 1, 1, True), InitSystemDate(2025, 1, 2, True), ecrSmaller);
  CheckCompareResult(22, InitSystemDate(2025, 1, 1, True), InitSystemDate(2025, 3, 1, True), ecrSmaller);
  CheckCompareResult(23, InitSystemDate(2025, 1, 1, True), InitSystemDate(2026, 1, 1, True), ecrSmaller);
  CheckCompareResult(24, InitSystemDate(2025, 1, 1, True), InitSystemDate(2026, 2, 1, True), ecrSmaller);
  CheckCompareResult(25, InitSystemDate(2025, 1, 1, True), InitSystemDate(2026, 1, 2, True), ecrSmaller);
  CheckCompareResult(26, InitSystemDate(2025, 1, 1, True), InitSystemDate(2026, 2, 1, True), ecrSmaller);
  // 
  CheckCompareResult(27, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrEqual);
  CheckCompareResult(28, InitSystemTime(2025, 1, 1, 1, 1, 1, 1), InitSystemTime(2025, 1, 1, 1, 1, 1, 1), ecrEqual);
  // 
  CheckCompareResult(29, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2026, 1, 1, 0, 0, 0, 0), ecrSmaller);
  CheckCompareResult(30, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 2, 1, 0, 0, 0, 0), ecrSmaller);
  CheckCompareResult(31, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 2, 0, 0, 0, 0), ecrSmaller);
  CheckCompareResult(32, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 1, 0, 0, 0), ecrSmaller);
  CheckCompareResult(33, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 1, 0, 0), ecrSmaller);
  CheckCompareResult(34, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 1, 0), ecrSmaller);
  CheckCompareResult(35, InitSystemTime(2025, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 1), ecrSmaller);
  // 
  CheckCompareResult(36, InitSystemTime(2026, 1, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
  CheckCompareResult(37, InitSystemTime(2025, 2, 1, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
  CheckCompareResult(38, InitSystemTime(2025, 1, 2, 0, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
  CheckCompareResult(39, InitSystemTime(2025, 1, 1, 1, 0, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
  CheckCompareResult(40, InitSystemTime(2025, 1, 1, 0, 1, 0, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
  CheckCompareResult(41, InitSystemTime(2025, 1, 1, 0, 0, 1, 0), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
  CheckCompareResult(42, InitSystemTime(2025, 1, 1, 0, 0, 0, 1), InitSystemTime(2025, 1, 1, 0, 0, 0, 0), ecrLarger);
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  case CurStep of
    ssInstall:
      begin
        Log('CurStepChanged.CurStep = ssInstall');

        TestCompareSystemTime;
        // TODO: rest of the tests
      end;
  end;
end;
