page 50515 PostedWhseShipmentHeader
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'postedWhseShipmentHeader';
    DelayedInsert = true;
    EntityName = 'PostedWhseShipmentHeader';
    EntitySetName = 'PostedWhseShipmentHeader';
    PageType = API;
    SourceTable = "Posted Whse. Shipment Header";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(assignedUserID; Rec."Assigned User ID")
                {
                    Caption = 'Assigned User ID';
                }
                field(assignmentDate; Rec."Assignment Date")
                {
                    Caption = 'Assignment Date';
                }
                field(assignmentTime; Rec."Assignment Time")
                {
                    Caption = 'Assignment Time';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(zoneCode; Rec."Zone Code")
                {
                    Caption = 'Zone Code';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetRange("Posting Date", Today);

    end;
}
