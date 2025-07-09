page 50617 ItemAPI
{
    APIGroup = 'ItemAPI';
    APIPublisher = 'ItemAPI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'itemAPI';
    DelayedInsert = true;
    EntityName = 'ItemAPI';
    EntitySetName = 'ItemAPI';
    PageType = API;
    SourceTable = Item;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Picture; Rec.Picture)
                {

                }
                field(number; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(no2; Rec."No. 2")
                {
                    Caption = 'No. 2';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(searchDescription; Rec."Search Description")
                {
                    Caption = 'Search Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(baseUnitOfMeasure; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit of Measure';
                }
                field(priceUnitConversion; Rec."Price Unit Conversion")
                {
                    Caption = 'Price Unit Conversion';
                }
                field(reorderPoint; Rec."Reorder Point")
                {
                    Caption = 'Reorder Point';
                }
                field(maximumInventory; Rec."Maximum Inventory")
                {
                    Caption = 'Maximum Inventory';
                }
                field(reorderQuantity; Rec."Reorder Quantity")
                {
                    Caption = 'Reorder Quantity';
                }
                field("ProductionBOMNo"; Rec."Production BOM No.")
                {
                    Caption = 'Production BOM No.';
                }
            }
        }
    }

}
