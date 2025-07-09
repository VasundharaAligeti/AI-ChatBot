page 80001 SalesInvoiceAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'SalesInvoiceAPI';
    DelayedInsert = true;
    EntityName = 'SalesInvoiceAPI';
    EntitySetName = 'SalesInvoiceAPI';
    PageType = API;
    SourceTable = "Sales Header";
    // ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(No; Rec."No.") { }
                field(SelltoCustomerNo; Rec."Sell-to Customer No.") { }
                field(PostingDate; Rec."Posting Date") { }
            }
        }
    }
}