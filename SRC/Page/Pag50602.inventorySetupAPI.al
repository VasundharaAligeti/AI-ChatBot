page 50602 inventorySetupAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'inventorySetupAPI';
    DelayedInsert = true;
    EntityName = 'inventorySetupAPI';
    EntitySetName = 'inventorySetupAPI';
    PageType = API;
    SourceTable = "Inventory Setup";
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
                field(SystemId; Rec.SystemId) { }
            }
        }
    }
}
