page 50620 userOUC
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'userOUC';
    DelayedInsert = true;
    EntityName = 'userOUC';
    EntitySetName = 'userOUC';
    PageType = API;
    SourceTable = User;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(userSecurityID; Rec."User Security ID")
                {
                    Caption = 'User Security ID';
                }
                field(userName; Rec."User Name")
                {
                    Caption = 'User Name';
                }
                field(fullName; Rec."Full Name")
                {
                    Caption = 'Full Name';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(UserId; UserId)
                {
                    Caption = 'User ID';
                    ToolTip = 'Specifies the user ID of the user who is currently logged in.';
                }

            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        UserId := UserSecurityId();
    end;

    var
        UserId: Guid;
}
