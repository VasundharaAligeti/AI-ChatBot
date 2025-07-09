pageextension 50602 SalesAndReceiSetupSJSI extends "Sales & Receivables Setup"
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