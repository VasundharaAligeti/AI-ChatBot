pageextension 50601 InventorySetupSJSI extends "Inventory Setup"
{
    layout
    {
        addlast(General)
        {
            field(TemplateNameForBOTSJSI; Rec.TemplateNameForBOTSJSI)
            {
                ApplicationArea = All;
            }
        }
    }
}