page 50521 CopilotFinanceModuleAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'copilotFinanceModuleAPI';
    DelayedInsert = true;
    EntityName = 'CopilotFinanceModuleAPI';
    EntitySetName = 'CopilotFinanceModuleAPI';
    PageType = API;
    SourceTable = "Copilot Finance Module";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(primaryKey; Rec."Primary key")
                {
                    Caption = 'Primary key';
                }
                field(journalTemplate; Rec."Journal Template")
                {
                    Caption = 'Journal Template';
                }
                field(journalBatch; Rec."Journal Batch")
                {
                    Caption = 'Journal Batch';
                }
            }
        }
    }
    [ServiceEnabled]
    procedure GLNumberExist(No: Code[20]): Boolean;
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetRange("G/L Account No.", No);
        if GLEntry.FindFirst() then
            exit(true)
        else
            exit(false);
    end;

    [ServiceEnabled]
    procedure BankNumberExist(No: Code[20]): Boolean;
    var
        BankLedger: Record "Bank Account Ledger Entry";
    begin
        BankLedger.SetRange("Bal. Account No.", No);
        if BankLedger.FindFirst() then
            exit(true)
        else
            exit(false);
    end;

    [ServiceEnabled]
    procedure VerifyJournalTemplateandBatchExist(): Boolean
    var
        CopilotFinanceModule: Record "Copilot Finance Module";
    begin
        if CopilotFinanceModule.Get() then
            if (CopilotFinanceModule."Journal Template" <> '') and (CopilotFinanceModule."Journal Batch" <> '') then
                exit(true)
            else
                exit(false);
    end;

    [ServiceEnabled]
    procedure CreateJournalEntry(Amount: Decimal; AccountType: Text; AccountNo: Text): Boolean
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        CopilotFinanceModule: Record "Copilot Finance Module";
        NoSeries: Codeunit "No. Series";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        BankAccount: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
        Amount1: Decimal;
    begin
        AccountType := UpperCase(AccountType);
        if (AccountType = 'GL ACCOUNT') or (AccountType = 'G/L ACCOUNT') then begin
            GLAccount.SetRange("No.", AccountNo);
            GLAccount.SetRange("Account Type", GLAccount."Account Type"::Posting);
            GLAccount.SetRange(Blocked, false);
            GLAccount.SetRange("Direct Posting", true);
            if not GLAccount.FindFirst() then
                exit(false);
        end;

        if (AccountType = 'FIXED ASSET') then begin
            FixedAsset.SetRange("No.", AccountNo);
            FixedAsset.SetRange(Blocked, false);
            if not FixedAsset.FindFirst() then
                exit(false);
        end;

        if (AccountType = 'BANK ACCOUNT') then
            if not BankAccount.get(AccountNo) then
                exit(false);

        CopilotFinanceModule.Get();
        GenJournalBatch.Get(CopilotFinanceModule."Journal Template", CopilotFinanceModule."Journal Batch");
        GenJournalLine.SetRange("Journal Template Name", CopilotFinanceModule."Journal Template");
        GenJournalLine.SetRange("Journal Batch Name", CopilotFinanceModule."Journal Batch");
        if GenJournalLine.FindLast() then
            LineNo := GenJournalLine."Line No." + 10000
        else
            LineNo := 10000;

        GenJournalLine.Reset();
        GenJournalLine.Init();
        GenJournalLine.Validate("Journal Template Name", CopilotFinanceModule."Journal Template");
        GenJournalLine.Validate("Journal Batch Name", CopilotFinanceModule."Journal Batch");
        GenJournalLine.Validate("Line No.", LineNo);
        GenJournalLine.Validate("Posting Date", WorkDate());
        GenJournalLine.Validate("Document No.", NoSeries.GetNextNo(GenJournalBatch."No. Series", WorkDate(), true));
        if (AccountType = 'GL ACCOUNT') or (AccountType = 'G/L ACCOUNT') then
            GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::"G/L Account");
        if (AccountType = 'FIXED ASSET') then
            GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::"Fixed Asset");
        if (AccountType = 'BANK ACCOUNT') then
            GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::"Bank Account");
        GenJournalLine.Validate("Account No.", AccountNo);
        //Evaluate(Amount1, Amount);
        if Amount < 0 then
            GenJournalLine.Validate("Credit Amount", Amount)
        else
            GenJournalLine.Validate("Debit Amount", Amount);
        GenJournalLine.Insert(true);
        exit(true);
    end;

    [ServiceEnabled]
    procedure CheckBankAccReconExist(BankAccountNo: Code[20]; StatementNo: Code[20]): Boolean
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
    begin
        if BankAccReconciliation.Get(BankAccReconciliation."Statement Type"::"Bank Reconciliation", BankAccountNo, StatementNo) then
            exit(true)
        else
            exit(false);

    end;

    [ServiceEnabled]
    procedure PostBankAccReconciliation(BankAccountNo: Code[20]; StatementNo: Code[20]): Boolean
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        ReversePaymentRecJournal: Codeunit "Reverse Payment Rec. Journal";
    begin
        if BankAccReconciliation.Get(BankAccReconciliation."Statement Type"::"Bank Reconciliation", BankAccountNo, StatementNo) then begin
            BankAccReconciliation."Statement Date" := Today;
            BankAccReconciliation.Modify(true);
            Commit();
            if not CODEUNIT.Run(CODEUNIT::"Bank Acc. Reconciliation Post", BankAccReconciliation) then
                exit(false);
            ReversePaymentRecJournal.SetGLRegisterNo(BankAccReconciliation);
            exit(true);
        end;
    end;

    [ServiceEnabled]
    procedure RunCashFlowReport(StartDate: Text; EndDate: Text): Text
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
        StartDateDay: Text;
        StartDateMonth: Text;
        StartDateYear: Integer;
        EndDateDay: Text;
        EndDateMonth: Text;
        EndDateYear: Integer;
        StartDate1: Date;
        EndDate1: Date;
    begin
        Evaluate(StartDate1, StartDate);
        Evaluate(EndDate1, EndDate);
        StartDateDay := Format(Date2DMY(StartDate1, 1));
        if StrLen(StartDateDay) = 1 then
            StartDateDay := '0' + StartDateDay;
        StartDateMonth := Format(Date2DMY(StartDate1, 2));
        if StrLen(StartDateMonth) = 1 then
            StartDateMonth := '0' + StartDateMonth;
        StartDateYear := Date2DMY(StartDate1, 3);
        EndDateDay := Format(Date2DMY(EndDate1, 1));
        if StrLen(EndDateDay) = 1 then
            EndDateDay := '0' + EndDateDay;
        EndDateMonth := Format(Date2DMY(EndDate1, 2));
        if StrLen(EndDateMonth) = 1 then
            EndDateMonth := '0' + EndDateMonth;
        EndDateYear := Date2DMY(EndDate1, 3);
        GeneralLedgerSetup.Get();

        StoreValue := '<?xml version="1.0" standalone="yes"?><ReportParameters name="Account Schedule" id="25"><Options><Field name="FinancialReportName">' + GeneralLedgerSetup."Fin. Rep. for Cash Flow Stmt" + '</Field><Field name="AccSchedName">' + GeneralLedgerSetup."Fin. Rep. for Cash Flow Stmt" + '</Field><Field name="ColumnLayoutName">M-NETCHANG</Field><Field name="StartDate">' + Format(StartDateYear) + '-' + Format(StartDateMonth) + '-' + Format(StartDateDay) + '</Field><Field name="EndDate">' + Format(EndDateYear) + '-' + Format(EndDateMonth) + '-' + Format(EndDateDay) + '</Field><Field name="GLBudgetName" /><Field name="CostBudgetFilter" /><Field name="BusinessUnitFilter" /><Field name="ShowError">0</Field><Field name="UseAmtsInAddCurr">false</Field><Field name="ShowRowNo">false</Field><Field name="ShowAlternatingShading">false</Field><Field name="SkipEmptyLines">false</Field><Field name="ShowCurrencySymbol">false</Field><Field name="ShowEmptyAmountType">0</Field><Field name="NegativeAmountFormat">0</Field><Field name="Dim1Filter" /><Field name="Dim2Filter" /><Field name="Dim3Filter" /><Field name="Dim4Filter" /><Field name="CostCenterFilter" /><Field name="CostObjectFilter" /><Field name="CashFlowFilter" /></Options><DataItems><DataItem name="AccScheduleName">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Heading">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Acc. Schedule Line">VERSION(1) SORTING(Field1,Field2)</DataItem><DataItem name="Column Layout">VERSION(1) SORTING(Field1,Field2)</DataItem><DataItem name="FixedColumns">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>';
        AccScheduleName.SetRange(Name, GeneralLedgerSetup."Fin. Rep. for Cash Flow Stmt");
        if AccScheduleName.FindFirst() then;
        RecRef.GetTable(AccScheduleName);
        TempBlob.CreateOutStream(OStream);
        Report.SaveAs(25, StoreValue, ReportFormat::Pdf, OStream, RecRef);
        TempBlob.CreateInStream(IStream);
        LargeText := Base64Convert.ToBase64(IStream);
        exit(LargeText);
    end;

    [ServiceEnabled]
    procedure RunTrialBalanceReport(StartDate: Text; EndDate: Text): Text
    var
        StoreValue: Text;
        RecRef: RecordRef;
        IStream: InStream;
        LargeText: Text;
        TempBlob: Codeunit "Temp Blob";
        OStream: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        GLAccount: Record "G/L Account";
        TrialBalance: Report "Trial Balance";
        StartDate1: Date;
        EndDate1: Date;
    begin
        Evaluate(StartDate1, StartDate);
        Evaluate(EndDate1, EndDate);
        GLAccount.SetFilter("Date Filter", '%1..%2', StartDate1, EndDate1);
        if GLAccount.FindSet() then;
        TrialBalance.SetTableView(GLAccount);
        //  TrialBalance.StoreDateValue(StartDate, EndDate);
        TrialBalance.UseRequestPage := false;
        TempBlob.CreateOutStream(OStream);
        RecRef.GetTable(GLAccount);
        TrialBalance.SaveAs('', ReportFormat::Pdf, OStream, RecRef);
        TempBlob.CreateInStream(IStream);
        LargeText := Base64Convert.ToBase64(IStream);
        exit(LargeText);
    end;

    [ServiceEnabled]
    procedure RunProfitLossReport(StartDate: Text; EndDate: Text): Text
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
        StartDateDay: Text;
        StartDateMonth: Text;
        StartDateYear: Integer;
        EndDateDay: Text;
        EndDateMonth: Text;
        EndDateYear: Integer;
        StartDate1: Date;
        EndDate1: Date;
    begin
        Evaluate(StartDate1, StartDate);
        Evaluate(EndDate1, EndDate);
        StartDateDay := Format(Date2DMY(StartDate1, 1));
        if StrLen(StartDateDay) = 1 then
            StartDateDay := '0' + StartDateDay;
        StartDateMonth := Format(Date2DMY(StartDate1, 2));
        if StrLen(StartDateMonth) = 1 then
            StartDateMonth := '0' + StartDateMonth;
        StartDateYear := Date2DMY(StartDate1, 3);
        EndDateDay := Format(Date2DMY(EndDate1, 1));
        if StrLen(EndDateDay) = 1 then
            EndDateDay := '0' + EndDateDay;
        EndDateMonth := Format(Date2DMY(EndDate1, 2));
        if StrLen(EndDateMonth) = 1 then
            EndDateMonth := '0' + EndDateMonth;
        EndDateYear := Date2DMY(EndDate1, 3);
        GeneralLedgerSetup.Get();

        StoreValue := '<?xml version="1.0" standalone="yes"?><ReportParameters name="Account Schedule" id="25"><Options><Field name="FinancialReportName">' + GeneralLedgerSetup."Fin. Rep. for Income Stmt." + '</Field><Field name="AccSchedName">' + GeneralLedgerSetup."Fin. Rep. for Income Stmt." + '</Field><Field name="ColumnLayoutName">M-NETCHANG</Field><Field name="StartDate">' + Format(StartDateYear) + '-' + Format(StartDateMonth) + '-' + Format(StartDateDay) + '</Field><Field name="EndDate">' + Format(EndDateYear) + '-' + Format(EndDateMonth) + '-' + Format(EndDateDay) + '</Field><Field name="GLBudgetName" /><Field name="CostBudgetFilter" /><Field name="BusinessUnitFilter" /><Field name="ShowError">0</Field><Field name="UseAmtsInAddCurr">false</Field><Field name="ShowRowNo">false</Field><Field name="ShowAlternatingShading">false</Field><Field name="SkipEmptyLines">false</Field><Field name="ShowCurrencySymbol">false</Field><Field name="ShowEmptyAmountType">0</Field><Field name="NegativeAmountFormat">0</Field><Field name="Dim1Filter" /><Field name="Dim2Filter" /><Field name="Dim3Filter" /><Field name="Dim4Filter" /><Field name="CostCenterFilter" /><Field name="CostObjectFilter" /><Field name="CashFlowFilter" /></Options><DataItems><DataItem name="AccScheduleName">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Heading">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Acc. Schedule Line">VERSION(1) SORTING(Field1,Field2)</DataItem><DataItem name="Column Layout">VERSION(1) SORTING(Field1,Field2)</DataItem><DataItem name="FixedColumns">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>';
        AccScheduleName.SetRange(Name, GeneralLedgerSetup."Fin. Rep. for Income Stmt.");
        if AccScheduleName.FindFirst() then;
        RecRef.GetTable(AccScheduleName);
        TempBlob.CreateOutStream(OStream);
        Report.SaveAs(25, StoreValue, ReportFormat::Pdf, OStream, RecRef);
        TempBlob.CreateInStream(IStream);
        LargeText := Base64Convert.ToBase64(IStream);
        exit(LargeText);
    end;

    [ServiceEnabled]
    procedure RunCFOReport(StartDate: Text; EndDate: Text): Text
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
        GeneralLedgerSetup: Record "Copilot Finance Module";
        UserSetting: Record "User Settings";
        StartDateDay: Text;
        StartDateMonth: Text;
        StartDateYear: Integer;
        EndDateDay: Text;
        EndDateMonth: Text;
        EndDateYear: Integer;
        StartDate1: Date;
        EndDate1: Date;
    begin
        Evaluate(StartDate1, StartDate);
        Evaluate(EndDate1, EndDate);
        StartDateDay := Format(Date2DMY(StartDate1, 1));
        if StrLen(StartDateDay) = 1 then
            StartDateDay := '0' + StartDateDay;
        StartDateMonth := Format(Date2DMY(StartDate1, 2));
        if StrLen(StartDateMonth) = 1 then
            StartDateMonth := '0' + StartDateMonth;
        StartDateYear := Date2DMY(StartDate1, 3);
        EndDateDay := Format(Date2DMY(EndDate1, 1));
        if StrLen(EndDateDay) = 1 then
            EndDateDay := '0' + EndDateDay;
        EndDateMonth := Format(Date2DMY(EndDate1, 2));
        if StrLen(EndDateMonth) = 1 then
            EndDateMonth := '0' + EndDateMonth;
        EndDateYear := Date2DMY(EndDate1, 3);
        GeneralLedgerSetup.Get();

        StoreValue := '<?xml version="1.0" standalone="yes"?><ReportParameters name="Account Schedule" id="25"><Options><Field name="FinancialReportName">' + GeneralLedgerSetup."CFO Finance Report" + '</Field><Field name="AccSchedName">' + GeneralLedgerSetup."CFO Finance Report" + '</Field><Field name="ColumnLayoutName">M-NETCHANG</Field><Field name="StartDate">' + Format(StartDateYear) + '-' + Format(StartDateMonth) + '-' + Format(StartDateDay) + '</Field><Field name="EndDate">' + Format(EndDateYear) + '-' + Format(EndDateMonth) + '-' + Format(EndDateDay) + '</Field><Field name="GLBudgetName" /><Field name="CostBudgetFilter" /><Field name="BusinessUnitFilter" /><Field name="ShowError">0</Field><Field name="UseAmtsInAddCurr">false</Field><Field name="ShowRowNo">false</Field><Field name="ShowAlternatingShading">false</Field><Field name="SkipEmptyLines">false</Field><Field name="ShowCurrencySymbol">false</Field><Field name="ShowEmptyAmountType">0</Field><Field name="NegativeAmountFormat">0</Field><Field name="Dim1Filter" /><Field name="Dim2Filter" /><Field name="Dim3Filter" /><Field name="Dim4Filter" /><Field name="CostCenterFilter" /><Field name="CostObjectFilter" /><Field name="CashFlowFilter" /></Options><DataItems><DataItem name="AccScheduleName">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Heading">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Acc. Schedule Line">VERSION(1) SORTING(Field1,Field2)</DataItem><DataItem name="Column Layout">VERSION(1) SORTING(Field1,Field2)</DataItem><DataItem name="FixedColumns">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>';
        AccScheduleName.SetRange(Name, GeneralLedgerSetup."CFO Finance Report");
        if AccScheduleName.FindFirst() then;
        RecRef.GetTable(AccScheduleName);
        TempBlob.CreateOutStream(OStream);
        Report.SaveAs(25, StoreValue, ReportFormat::Pdf, OStream, RecRef);
        TempBlob.CreateInStream(IStream);
        LargeText := Base64Convert.ToBase64(IStream);
        exit(LargeText);
    end;

    [ServiceEnabled]
    procedure RunTaxReport(StartDate: Text; EndDate: Text): Text
    var
        VATStatement: Report "VAT Statement";
        TempBlob: Codeunit "Temp Blob";
        OStream: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        VATStatementName: Record "VAT Statement Name";
        RecRef: RecordRef;
        IStream: InStream;
        LargeText: Text;
        VATStatementLine: Record "VAT Statement Line";
        StartDate1: Date;
        EndDate1: Date;
    begin
        Evaluate(StartDate1, StartDate);
        Evaluate(EndDate1, EndDate);
        if VATStatementLine.FindFirst() then;
        if VATStatementName.Get(VATStatementLine."Statement Template Name", VATStatementLine."Statement Name") then;
        VATStatement.SetTableView(VATStatementName);
        VATStatement.StoreStartDate(StartDate1, EndDate1);
        VATStatement.UseRequestPage := false;
        TempBlob.CreateOutStream(OStream);
        RecRef.GetTable(VATStatementName);
        VATStatement.SaveAs('', ReportFormat::Pdf, OStream, RecRef);
        TempBlob.CreateInStream(IStream);
        LargeText := Base64Convert.ToBase64(IStream);
        exit(LargeText);
    end;

    [ServiceEnabled]
    procedure BatchExsit(BatchName: Code[10]): Boolean
    var
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        if GenJournalBatch.Get('PAYMENT', BatchName) then
            exit(true)
        else
            exit(false);

    end;

    [ServiceEnabled]
    procedure ApprovePaymentJournalBatch(BatchName: Code[10]): Boolean
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        ApprovalManagement: Codeunit "Approvals Mgmt.";
    begin
        if GenJournalBatch.Get('PAYMENT', BatchName) then;
        if not
           WorkflowManagement.CanExecuteWorkflow(GenJournalBatch,
             WorkflowEventHandling.RunWorkflowOnSendGeneralJournalBatchForApprovalCode())
        then
            exit(false);
        if ApprovalManagement.HasOpenApprovalEntries(GenJournalBatch.RecordId) or
           ApprovalManagement.HasAnyOpenJournalLineApprovalEntries(GenJournalBatch."Journal Template Name", GenJournalBatch.Name)
        then
            exit(false);

        ApprovalManagement.OnSendGeneralJournalBatchForApproval(GenJournalBatch);
        exit(true);
    end;

    [ServiceEnabled]
    procedure VerifyFAExist(FANO: Code[20]): Boolean
    var
        FixedAsset: Record "Fixed Asset";
    begin
        if FixedAsset.Get(FANO) then
            exit(true)
        else
            exit(false);
    end;

    [ServiceEnabled]
    procedure FAInsert(FANO: Code[20]; Startdate: Text; EndDate: Text): Boolean
    var
        FixedAsset: Record "Fixed Asset";
        FADepreciationBook: Record "FA Depreciation Book";
        StartDate1: Date;
        EndDate1: Date;
    begin
        Evaluate(StartDate1, Startdate);
        Evaluate(EndDate1, EndDate);
        if FixedAsset.Get(FANO) then;
        FADepreciationBook.SetRange("FA No.", FixedAsset."No.");
        if FADepreciationBook.FindLast() then begin
            FADepreciationBook.Validate("Depreciation Starting Date", StartDate1);
            FADepreciationBook.Validate("Depreciation Ending Date", EndDate1);
            FADepreciationBook.Modify(true);
            exit(true);
        end
        else
            exit(false);
    end;
}
