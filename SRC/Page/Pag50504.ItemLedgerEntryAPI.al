page 50504 ItemLedgerEntryAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'itemLedgerEntryAPI';
    DelayedInsert = true;
    EntityName = 'ItemLedgerEntryAPI';
    EntitySetName = 'ItemLedgerEntryAPI';
    PageType = API;
    SourceTable = "Item Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                    Caption = 'Remaining Quantity';
                }
                field(invoicedQuantity; Rec."Invoiced Quantity")
                {
                    Caption = 'Invoiced Quantity';
                }
                field(open; Rec.Open)
                {
                    Caption = 'Open';
                }
                field(TrackItemMovements; TrackItemMovementsAPI())
                {
                    Caption = 'Track Item Movements';
                }
                field("EntryNo"; Rec."Entry No.")
                {

                }
            }
        }
    }
    trigger OnOpenPage()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        StartDate := WorkDate();
        EndDate := CalcDate('-1M', WorkDate());
        Rec.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
    end;

    procedure TrackItemMovementsAPI(): Text
    var
        BaseUrl: Text;
    begin
        BaseUrl := GetUrl(CurrentClientType, CompanyName, ObjectType::Page, Page::"Item Ledger Entries", Rec, true);
        exit(BaseUrl);
    end;
}
