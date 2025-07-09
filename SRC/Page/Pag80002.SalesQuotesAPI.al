page 80002 SalesQuotesAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'SalesQuotesAPI';
    DelayedInsert = true;
    EntityName = 'SalesQuotesAPI';
    EntitySetName = 'SalesQuotesAPI';
    PageType = API;
    SourceTable = "Sales Header";
    ODataKeyFields = "No.";
    SourceTableView = where("Document Type" = const(Quote));
    Permissions = tabledata "Sales Header" = rimd;
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
                // field(SalesQuote_to_SalesOrder1; SalesQuote_to_SalesOrder) { }
                field(Id; Rec.SystemId) { }
            }
        }
    }
    [ServiceEnabled]
    procedure SalesQuote_to_SalesOrder(): Text
    var
        SalesHeader2: Record "Sales Header";
        SalesQuoteToOrder: Codeunit "Sales-Quote to Order";
    begin
        SalesQuoteToOrder.Run(Rec);
        SalesQuoteToOrder.GetSalesOrderHeader(SalesHeader2);
        Commit();
        exit(SalesHeader2."No.");
    end;



    var
        Margin: Decimal;
        TotalSales: Decimal;
        TotalCost: Decimal;
        MarginPercent: Decimal;

}
