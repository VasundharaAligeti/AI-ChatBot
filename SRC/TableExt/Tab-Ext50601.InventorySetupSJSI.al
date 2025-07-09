tableextension 50601 InventorySetupSJSI extends "Inventory Setup"
{
    fields
    {
        field(50100; TemplateNameForBOTSJSI; Code[20])
        {
            Caption = 'Template Name for BOT';
            TableRelation = "Item Templ.";
        }
    }
}