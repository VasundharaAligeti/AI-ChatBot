page 50513 WarehouseShipmentHeaderAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'warehouseShipmentHeaderAPI';
    DelayedInsert = true;
    EntityName = 'WarehouseShipmentHeaderAPI';
    EntitySetName = 'WarehouseShipmentHeaderAPI';
    PageType = API;
    SourceTable = "Warehouse Shipment Header";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(documentStatus; Rec."Document Status")
                {
                    Caption = 'Document Status';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
            }
        }
    }
}
