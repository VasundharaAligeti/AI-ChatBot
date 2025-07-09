page 50604 salesReceivableSetupAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'salesReceivableSetupAPI';
    DelayedInsert = true;
    EntityName = 'salesReceivableSetupAPI';
    EntitySetName = 'salesReceivableSetupAPI';
    PageType = API;
    SourceTable = "Sales & Receivables Setup";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(TemplateNameForBOTSJSI; Rec.TemplateNameForBOTSJSI) { }
                field(SystemId; Rec.SystemId) { }
            }
        }
    }
}
