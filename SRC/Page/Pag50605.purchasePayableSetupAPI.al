page 50605 purchasePayableSetupAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'purchasePayableSetupAPI';
    DelayedInsert = true;
    EntityName = 'purchasePayableSetupAPI';
    EntitySetName = 'purchasePayableSetupAPI';
    PageType = API;
    SourceTable = "Purchases & Payables Setup";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(templateNameForBOTSJSI; Rec.TemplateNameForBOTSJSI)
                {
                    Caption = 'Template Name for BOT';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
