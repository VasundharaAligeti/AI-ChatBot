page 80007 SalesInvLinesAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'SalesInvLinesAPI';
    DelayedInsert = true;
    EntityName = 'SalesInvLinesAPI';
    EntitySetName = 'SalesInvLinesAPI';
    PageType = API;
    SourceTable = "Sales Invoice Line";
    // SourceTableView = where("Document Type" = filter(Invoice | "Credit Memo"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec."No.") { }
                field(DocumentNo; Rec."Document No.") { }
                field(SelltoCustomerNo; Rec."Sell-to Customer No.") { }
                field(PostingDate; Rec."Posting Date") { }
            }
        }
    }
}