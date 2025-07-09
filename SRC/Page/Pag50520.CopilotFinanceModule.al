page 50520 "Copilot Finance Module"
{
    ApplicationArea = All;
    Caption = 'Copilot Finance Module';
    PageType = Card;
    SourceTable = "Copilot Finance Module";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Journal Template"; Rec."Journal Template")
                {
                    ToolTip = 'Specifies the value of the Journal Template field.', Comment = '%';
                }
                field("Journal Batch"; Rec."Journal Batch")
                {
                    Enabled = Rec."Journal Template" <> '';
                    ToolTip = 'Specifies the value of the Journal Batch field.', Comment = '%';
                }
                field("CFO Finance Report"; Rec."CFO Finance Report")
                {
                    ToolTip = 'Specifies the value of the CFO Finance Report field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Display")
            {
                ApplicationArea = All;
                Caption = 'Testing';
                trigger OnAction()
                var
                    ACcScheduleName: Record "Acc. Schedule Name";
                    AccountSchedule: Report "Account Schedule";
                    StoreValue: Text;
                    RecRef: RecordRef;
                    IStream: InStream;
                    LargeText: Text;
                    TempBlob: Codeunit "Temp Blob";
                    OStream: OutStream;
                    Base64Convert: Codeunit "Base64 Convert";
                    AccScheduleLine: Record "Acc. Schedule Line";
                    GeneralLedgerSetup: Record "General Ledger Setup";
                    UserSetting: Record "User Settings";
                    StartDate: Date;
                    EndDate: Date;
                    StartDateDay: Text;
                    StartDateMonth: Text;
                    StartDateYear: Integer;
                    EndDateDay: Text;
                    EndDateMonth: Text;
                    EndDateYear: Integer;
                begin
                    // StartDate := CalcDate('-1Y', Today - 5);
                    // EndDate := CalcDate('-1Y', Today);

                    // StartDateDay := Format(Date2DMY(Today, 1));
                    // if StrLen(StartDateDay) = 1 then
                    //     StartDateDay := '0' + StartDateDay;
                    // StartDateMonth := Format(Date2DMY(Today, 2));
                    // if StrLen(StartDateMonth) = 1 then
                    //     StartDateMonth := '0' + StartDateMonth;
                    // StartDateYear := Date2DMY(Today, 3);
                    // EndDateDay := Format(Date2DMY(Today, 1));
                    // if StrLen(EndDateDay) = 1 then
                    //     EndDateDay := '0' + EndDateDay;
                    // EndDateMonth := Format(Date2DMY(Today, 2));
                    // if StrLen(EndDateMonth) = 1 then
                    //     EndDateMonth := '0' + EndDateMonth;
                    // EndDateYear := Date2DMY(Today, 3);
                    // GeneralLedgerSetup.Get();

                    // StoreValue := '<?xml version="1.0" standalone="yes"?><ReportParameters name="Account Schedule" id="25"><Options><Field name="FinancialReportName">' + GeneralLedgerSetup."Fin. Rep. for Cash Flow Stmt" + '</Field><Field name="AccSchedName">' + GeneralLedgerSetup."Fin. Rep. for Cash Flow Stmt" + '</Field><Field name="ColumnLayoutName">M-NETCHANG</Field><Field name="StartDate">' + Format(StartDateYear) + '-' + Format(StartDateMonth) + '-' + Format(StartDateDay) + '</Field><Field name="EndDate">' + Format(EndDateYear) + '-' + Format(EndDateMonth) + '-' + Format(EndDateDay) + '</Field><Field name="GLBudgetName" /><Field name="CostBudgetFilter" /><Field name="BusinessUnitFilter" /><Field name="ShowError">0</Field><Field name="UseAmtsInAddCurr">false</Field><Field name="ShowRowNo">false</Field><Field name="ShowAlternatingShading">false</Field><Field name="SkipEmptyLines">false</Field><Field name="ShowCurrencySymbol">false</Field><Field name="ShowEmptyAmountType">0</Field><Field name="NegativeAmountFormat">0</Field><Field name="Dim1Filter" /><Field name="Dim2Filter" /><Field name="Dim3Filter" /><Field name="Dim4Filter" /><Field name="CostCenterFilter" /><Field name="CostObjectFilter" /><Field name="CashFlowFilter" /></Options><DataItems><DataItem name="AccScheduleName">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Heading">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Acc. Schedule Line">VERSION(1) SORTING(Field1,Field2)</DataItem><DataItem name="Column Layout">VERSION(1) SORTING(Field1,Field2)</DataItem><DataItem name="FixedColumns">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>';
                    // AccScheduleName.SetRange(Name, GeneralLedgerSetup."Fin. Rep. for Cash Flow Stmt");
                    // if AccScheduleName.FindFirst() then;
                    // RecRef.GetTable(AccScheduleName);
                    // TempBlob.CreateOutStream(OStream);
                    // Report.SaveAs(25, StoreValue, ReportFormat::Pdf, OStream, RecRef);
                    // TempBlob.CreateInStream(IStream);
                    // LargeText := Base64Convert.ToBase64(IStream);
                    // LargeText := Report.RunRequestPage(25);
                    // Message(LargeText);
                end;

            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
