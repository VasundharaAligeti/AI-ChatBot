page 50906 customReportSelectionV
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'customReportSelectionV';
    DelayedInsert = true;
    EntityName = 'customReportSelectionV';
    EntitySetName = 'customReportSelectionV';
    PageType = API;
    SourceTable = "Custom Report Selection";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(sourceType; Rec."Source Type")
                {
                    Caption = 'Source Type';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }
                field(usage; Rec.Usage)
                {
                    Caption = 'Usage';
                }
                field(reportID; Rec."Report ID")
                {
                    Caption = 'Report ID';
                }
                field(sendToEmail; Rec."Send To Email")
                {
                    Caption = 'Send To Email';
                }
                field(SystemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
