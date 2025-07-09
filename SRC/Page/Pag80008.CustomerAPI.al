page 80008 CustomerAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'CustomerAPI';
    DelayedInsert = true;
    EntityName = 'CustomerAPI';
    EntitySetName = 'CustomerAPI';
    PageType = API;
    SourceTable = Customer;
    ODataKeyFields = SystemId;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(SystemId; Rec.SystemId) { }
                field(No; Rec."No.") { }
                field(Name; Rec.Name + Rec."Name 2")
                {

                }
                field(Contact; Rec.Contact) { }
                field(Balance; Rec.Balance) { }
                field(Address; Rec.Address + Rec."Address 2") { }
                field("City"; Rec.City) { }
                field(PostCode; Rec."Post Code") { }
                field(CountryRegionCode; Rec."Country/Region Code") { }
                field(Amount; Rec.Amount) { }
                field(Profit; Rec."Profit (LCY)") { }
                field(EMail; Rec."E-Mail") { }
                field(PhoneNo; Rec."Phone No.") { }
                field(getoverduebalance; GetOverdueBalanceForCustomer(Rec."No.")) { }
                field(Tag; Rec.Tag) { }
                field(CustomerCardURL; GetCustomerCardURL()) { }
            }
        }
    }




    //-------------------------------Customer Details - Customer Module-------------------------------------//
    [ServiceEnabled]
    procedure GetCustomerCardURL(): Text
    var
        myInt: Integer;
    begin
        exit(GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Customer Card", Rec, false));
    end;
    //-------------------------------Customer Details - Customer Module-------------------------------------//


    //-------------------------------Customer Sales Report - Sales Module---------------------------------//
    [ServiceEnabled]
    procedure customerSalesReport(): Text
    var
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        InStream: InStream;
        LargeText: Text;
        Customer: Record Customer;
    begin

        RecRef.GetTable(Customer);
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(113, '', ReportFormat::Pdf, OutStream, RecRef);
        TempBlob.CreateInStream(InStream);
        LargeText := Base64Convert.ToBase64(InStream, false);
        exit(LargeText);
    end;

    [ServiceEnabled]
    procedure SendReport(): Text;
    var
        UserSetup: Record "User Setup";
        UserIdNew: Code[50];
    begin
        UserIdNew := UserId();
        UserSetup.SetRange("User ID", UserIdNew);
        if UserSetup.FindFirst() then;
        exit(UserSetup."E-Mail");
    end;
    //--------------------------------------------------------------------------------//
    //-------------------------------Customer Sales Summary Report - Customer Module------------------------------------//
    [ServiceEnabled]
    procedure customerSalesSummaryReport(): Text
    var
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        InStream: InStream;
        LargeText: Text;
        Customer: Record Customer;

    begin

        RecRef.GetTable(Customer);
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(119, '', ReportFormat::Pdf, OutStream, RecRef);
        TempBlob.CreateInStream(InStream);
        LargeText := Base64Convert.ToBase64(InStream, false);
        exit(LargeText);
    end;

    [ServiceEnabled]
    procedure SendReport1(): Text;
    var
        UserSetup: Record "User Setup";
        UserIdNew: Code[50];
    begin
        UserIdNew := UserId();
        UserSetup.SetRange("User ID", UserIdNew);
        if UserSetup.FindFirst() then;
        exit(UserSetup."E-Mail");
    end;
    //-------------------------------Customer Sales Summary Report-------------------------------------------------//


    //----------------Generate customer aging report-------------------//
    [ServiceEnabled]
    procedure customerAgingReport(): Text
    var
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        InStream: InStream;
        LargeText: Text;
        Customer: Record Customer;

    begin
        Customer.SetRange("No.", Rec."No.");
        if Customer.FindFirst() then;
        RecRef.GetTable(Customer);
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(105, '', ReportFormat::Pdf, OutStream, RecRef);
        TempBlob.CreateInStream(InStream);
        LargeText := Base64Convert.ToBase64(InStream, false);
        exit(LargeText);
    end;

    [ServiceEnabled]
    procedure SendReport2(): Text;
    var
        UserSetup: Record "User Setup";
        Customer: Record Customer;
        UserIdNew: Code[50];
    begin
        Customer.SetRange("No.", Rec."No.");
        if Customer.FindFirst() then;
        exit(Customer."E-Mail");
    end;
    //------------------Generate customer aging report-----------------------//

    //------------------Add comments for customer [no]----------------------//
    [ServiceEnabled]
    procedure AddCustomerComment(CustomerNo: Code[20]; CommentText: Text)
    var
        Customer: Record Customer;
        CommentLine: Record "Comment Line";
        CommentLineNo: Integer;
    begin
        if Customer.Get(CustomerNo) then begin
            CommentLine.Reset();
            CommentLine.SetRange("Table Name", CommentLine."Table Name"::Customer);
            CommentLine.SetRange("No.", CustomerNo);
            if CommentLine.FindLast() then
                CommentLineNo := CommentLine."Line No." + 10000
            else
                CommentLineNo := 10000; // First line

            CommentLine.Init();
            CommentLine."Table Name" := CommentLine."Table Name"::Customer;
            CommentLine."No." := CustomerNo;
            CommentLine."Line No." := CommentLineNo;
            CommentLine.Date := Today;
            CommentLine.Comment := CommentText;
            CommentLine.Insert();
        end;
    end;
    //-------------------Add comments for customer [no]-------------------------//

    //-------------------Send statement of account to customer----------------------//
    [ServiceEnabled]
    procedure StatementOfAccount(StartDate: Text; EndDate: Text): Text
    var
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        InStream: InStream;
        LargeText: Text;
        Customer: Record Customer;
        StdStmtReport: Report "Standard Statement";
        repoarameters: Text;
        StartDate1: Date;
        EndDate1: Date;
    begin
        Evaluate(StartDate1, StartDate);
        Evaluate(EndDate1, EndDate);
        StdStmtReport.StoreDate(StartDate1, EndDate1);
        StdStmtReport.UseRequestPage := false;
        Customer.SetRange("No.", Rec."No.");
        if Customer.FindFirst() then;
        RecRef.GetTable(Customer);
        TempBlob.CreateOutStream(OutStream);
        StdStmtReport.SaveAs('', ReportFormat::Pdf, OutStream, RecRef);
        TempBlob.CreateInStream(InStream);
        LargeText := Base64Convert.ToBase64(InStream, false);
        exit(LargeText);
    end;

    [ServiceEnabled]
    procedure SendReport3(): Text;
    var
        UserSetup: Record "User Setup";
        Customer: Record Customer;
        UserIdNew: Code[50];
    begin
        Customer.SetRange("No.", Rec."No.");
        if Customer.FindFirst() then;
        exit(Customer."E-Mail");
    end;



    //-------------------Send statement of account to customer----------------------//

    //-------------------------Customer Tagging VIP-------------------------------------//
    [ServiceEnabled]
    procedure CustomerTag(CustomerNo: Code[20]; TagText: Text)
    var
        Customer: Record Customer;
    begin
        if (Customer.Get(CustomerNo)) and (Customer.Tag = '') then begin
            Customer."Tag" := TagText; // use correct field name here
            Customer.Modify();
        end;
    end;
    //----------------------------Customer Tagging VIP-------------------------------------//




    [ServiceEnabled]
    procedure GetOverdueBalanceForCustomer(CustomerNo: Code[20]): Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        TotalOverdue: Decimal;
        Key1: code[20];
        Value: Decimal;
        Customer: Record Customer;
        OverdueDict: Dictionary of [Code[20], Decimal];
        Result: Text;
        report: Report 1316;
    begin
        TotalOverdue := 0;
        CustLedgerEntry.SetFilter("Customer No.", '%1', CustomerNo);
        CustLedgerEntry.SetRange(Open, true);
        CustLedgerEntry.SetFilter("Due Date", '<%1', Today);
        CustLedgerEntry.SetAutoCalcFields("Remaining Amt. (LCY)");

        if CustLedgerEntry.FindSet() then
            repeat
                TotalOverdue += CustLedgerEntry."Remaining Amt. (LCY)";
            until CustLedgerEntry.Next() = 0;

        exit(TotalOverdue);
    end;


    var
        comments: Record "Comment Line";
}