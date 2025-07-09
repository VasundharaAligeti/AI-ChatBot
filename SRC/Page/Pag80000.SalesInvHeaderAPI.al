page 80000 SalesInvHeaderAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'SalesInvHeaderAPI';
    DelayedInsert = true;
    EntityName = 'SalesInvHeaderAPI';
    EntitySetName = 'SalesInvHeaderAPI';
    PageType = API;
    SourceTable = "Sales Invoice Header";
    ODataKeyFields = SystemId;
    // ODataKeyFields = "No.";
    // SourceTableView = where("Document Type" = const(Order));

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(No; Rec."No.") { }
                field(SelltoCustomerNo; Rec."Sell-to Customer No.") { }
                field(PostingDate; Rec."Posting Date") { }
                field(Amount; Rec.Amount) { }
                field(SystemId; Rec.SystemId) { }
            }
        }
    }
    [ServiceEnabled]
    procedure SendInvoiceToCustomer()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        EmailOutbox: Record "Email Outbox";
        IsEmailDataValid: Boolean;
    begin
        SalesInvHeader := Rec;
        CurrPage.SetSelectionFilter(SalesInvHeader);
        SalesInvHeader.EmailRecords(true);

    end;

    [ServiceEnabled]
    procedure CustomerSalesReport()
    var
        RecRef: RecordRef;
        Customer: Record Customer;
    begin
        Report.RunModal(113);

    end;



    var
        Margin: Decimal;
        TotalSales: Decimal;
        TotalCost: Decimal;
        MarginPercent: Decimal;
        customreportselection: Record "Custom Report Selection";
        pos: Page "Posted Sales Invoice";
        email: Page "Email Editor";
}