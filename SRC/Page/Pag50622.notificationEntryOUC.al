page 50622 notificationEntryOUC
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'notificationEntryOUC';
    DelayedInsert = true;
    EntityName = 'notificationEntryOUC';
    EntitySetName = 'notificationEntryOUC';
    PageType = API;
    SourceTable = "Notification Entry";
    
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
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(recipientUserID; Rec."Recipient User ID")
                {
                    Caption = 'Recipient User ID';
                }
                field(triggeredByRecord; Rec."Triggered By Record")
                {
                    Caption = 'Triggered By Record';
                }
                field(linkTargetPage; Rec."Link Target Page")
                {
                    Caption = 'Link Target Page';
                }
                field(customLink; Rec."Custom Link")
                {
                    Caption = 'Custom Link';
                }
                field(errorMessage; Rec."Error Message")
                {
                    Caption = 'Error Message';
                }
                field(createdDateTime; Rec."Created Date-Time")
                {
                    Caption = 'Created Date-Time';
                }
                field(createdBy; Rec."Created By")
                {
                    Caption = 'Created By';
                }
                field(senderUserID; Rec."Sender User ID")
                {
                    Caption = 'Sender User ID';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
