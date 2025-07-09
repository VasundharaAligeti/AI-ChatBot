page 50601 PurchaseQuotesAPIMasroor
{
    PageType = API;
    Caption = 'purchase quotes';
    APIPublisher = 'SJSI';
    APIGroup = 'SJSI';
    APIVersion = 'v2.0';
    EntityName = 'purchaseQuoteapi';
    EntitySetName = 'purchaseQuoteapi';
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = const(Quote));
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    ChangeTrackingAllowed = true;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Id; Rec.SystemId)
                {
                }
                field("number"; Rec."No.") { }
                field("PostingDate"; Rec."Posting Date")
                {
                }
                field("VendorNo"; Rec."Buy-from Vendor No.")
                {
                }
                field("AmountIncludingVAT"; Rec."Amount Including VAT") { }
                field(WebURL; WebURL)
                {
                    Caption = 'Web URL';
                    ToolTip = 'The URL to access the purchase quote in the web client.';
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec."Posting Date" = 0D then
            Rec."Posting Date" := Today;
    end;

    trigger OnAfterGetRecord()
    begin
        WebURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Purchase Quote", Rec, false);
    end;

    var
        WebURL: Text;
}