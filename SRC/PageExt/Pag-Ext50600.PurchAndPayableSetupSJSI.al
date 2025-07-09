pageextension 50600 PurchAndPayableSetupSJSI extends "Purchases & Payables Setup"
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