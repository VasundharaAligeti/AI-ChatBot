page 50616 BillOfMaterialAPI
{
    APIGroup = 'BillOfMaterialAPI';
    APIPublisher = 'BillOfMaterialAPI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'billOfMaterialAPI';
    DelayedInsert = true;
    EntityName = 'BillOfMaterialAPI';
    EntitySetName = 'BillOfMaterialAPI';
    PageType = API;
    SourceTable = "Sales Line";

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
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                // field(productionBOMNo; Rec."Production BOM No.")
                // {
                //     Caption = 'Production BOM No.';
                // }
                field("UnitofMeasureCode"; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                // field("Quantityper"; Rec."Quantity per")
                // {
                //     Caption = 'Quantity Per';
                // }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }

                // part(ProductionBOM; "Production BOM Lines")
                // {
                //     EntityName = 'BillOfMaterialAPI';
                //     EntitySetName = 'BillOfMaterialAPI';
                //     Caption = 'Production BOM Lines';
                //     SubPageLink = "No." = field("No.");
                // }
            }
        }
    }
}
