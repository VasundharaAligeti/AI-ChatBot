page 50901 VendorLedgerEntriesAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'vendorLedgerEntriesAPI';
    DelayedInsert = true;
    EntityName = 'VendorLedgerEntriesAPI';
    EntitySetName = 'VendorLedgerEntriesAPI';
    PageType = API;
    SourceTable = "Vendor Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    ToolTip = 'The date when the transaction was posted.';
                }
                field(vendorName; Rec."Vendor Name")
                {
                    Caption = 'Vendor Name';
                    ToolTip = 'The name of the vendor associated with the ledger entry.';
                }
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                    ToolTip = 'The unique identifier for the vendor associated with the ledger entry.';
                }
                field(amountLCY; Rec."Amount (LCY)")
                {
                    Caption = 'Amount (LCY)';
                    ToolTip = 'The amount in local currency for the ledger entry.';
                }
                field(remainingAmtLCY; Rec."Remaining Amt. (LCY)")
                {
                    Caption = 'Remaining Amt. (LCY)';
                    ToolTip = 'The remaining amount in local currency for the ledger entry.';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                    ToolTip = 'The type of document associated with the ledger entry, such as invoice or credit memo.';
                }
                field(WebListUrl; WebListUrl)
                {
                    Caption = 'Web List URL';
                    ToolTip = 'The URL to access the vendor ledger entries list page in the web client.';
                }
                field(VendorLedgerListAllUrl; VendorLedgerListAllUrl)
                {
                    Caption = 'Vendor Ledger List All URL';
                    ToolTip = 'The URL to access all vendor ledger entries in the web client.';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        VendorLedgerEntries: Record "Vendor Ledger Entry";
    begin
        if Rec."Vendor No." <> '' then begin
            VendorLedgerEntries.SetFilter("Vendor No.", Rec."Vendor No.");
            WebListUrl := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Vendor Ledger Entries", VendorLedgerEntries, true);
        end;
        VendorLedgerListAllUrl := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Vendor Ledger Entries", Rec, false);
    end;

    var
        VendorLedgerListAllUrl: Text;
        WebListUrl: Text;
}
