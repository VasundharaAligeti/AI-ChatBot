tableextension 50600 PurchAndPayableSetupSJSI extends "Purchases & Payables Setup"
{
    fields
    {
        field(50600; TemplateNameForBOTSJSI; Code[20])
        {
            Caption = 'Template Name for BOT';
            TableRelation = "Vendor Templ.";
        }
    }
}