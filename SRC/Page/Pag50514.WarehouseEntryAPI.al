page 50514 WarehouseEntryAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'warehouseEntryAPI';
    DelayedInsert = true;
    EntityName = 'WarehouseEntryAPI';
    EntitySetName = 'WarehouseEntryAPI';
    PageType = API;
    SourceTable = "Warehouse Entry";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
            }
        }
    }
}
