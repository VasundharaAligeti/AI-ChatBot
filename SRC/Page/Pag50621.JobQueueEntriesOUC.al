page 50621 JobQueueEntriesOUC
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'jobQueueEntriesOUC';
    DelayedInsert = true;
    EntityName = 'JobQueueEntriesOUC';
    EntitySetName = 'JobQueueEntriesOUC';
    PageType = API;
    SourceTable = "Job Queue Entry";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(lastReadyState; Rec."Last Ready State")
                {
                    Caption = 'Last Ready State';
                }
                field(objectTypeToRun; Rec."Object Type to Run")
                {
                    Caption = 'Object Type to Run';
                }
                field(objectIDToRun; Rec."Object ID to Run")
                {
                    Caption = 'Object ID to Run';
                }
                field(objectCaptionToRun; Rec."Object Caption to Run")
                {
                    Caption = 'Object Caption to Run';
                }
                field(reportOutputType; Rec."Report Output Type")
                {
                    Caption = 'Report Output Type';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
            }
        }
    }
}
