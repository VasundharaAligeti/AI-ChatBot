tableextension 50602 SalesAndReceivalbeSetupSJSI extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; TemplateNameForBOTSJSI; Code[20])
        {
            // Caption = 'Template Name for BOT';
            TableRelation = "Customer Templ.";
        }
    }
}