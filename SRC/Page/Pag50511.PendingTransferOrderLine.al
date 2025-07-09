page 50511 PendingTransferOrderLine
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'pendingTransferOrderLine';
    DelayedInsert = true;
    EntityName = 'PendingTransferOrderLine';
    EntitySetName = 'PendingTransferOrderLine';
    PageType = API;
    SourceTable = "Transfer Line";
    //    ODataKeyFields = "Document No.";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field("lineNo"; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
            }
        }
    }
}
