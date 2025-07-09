page 50905 vendorLedgerEntriesV
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'vendorLedgerEntriesV';
    DelayedInsert = true;
    EntityName = 'vendorLedgerEntriesV';
    EntitySetName = 'vendorLedgerEntriesV';
    PageType = API;
    SourceTable = "Vendor Ledger Entry";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(remainingAmount; Rec."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                }
                field(remainingAmtLCY; Rec."Remaining Amt. (LCY)")
                {
                    Caption = 'Remaining Amt. (LCY)';
                }
                field(open; Rec.Open)
                {
                    Caption = 'Open';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field("DateFilter"; Rec."Date Filter")
                {
                    Caption = 'Date Filter';
                }
            }
        }
    }
}
