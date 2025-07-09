page 50505 "Warehouse Employee"
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'warehouseEmployee';
    DelayedInsert = true;
    EntityName = 'WarehouseEmployeeAPI';
    EntitySetName = 'WarehouseEmployeeAPI';
    PageType = API;
    SourceTable = "Warehouse Employee";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(default; Rec.Default)
                {
                    Caption = 'Default';
                }
            }
        }
    }
}
