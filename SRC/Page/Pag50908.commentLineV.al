page 50908 commentLineV
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'commentLineV';
    DelayedInsert = true;
    EntityName = 'commentLineV';
    EntitySetName = 'commentLineV';
    PageType = API;
    SourceTable = "Comment Line";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(tableName; Rec."Table Name")
                {
                    Caption = 'Table Name';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Date';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        Rec.Date := WorkDate;
    end;
}
