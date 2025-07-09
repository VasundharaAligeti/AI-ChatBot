page 50509 ServiceHeaderAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'serviceHeaderAPI';
    DelayedInsert = true;
    EntityName = 'ServiceHeaderAPI';
    EntitySetName = 'ServiceHeaderAPI';
    PageType = API;
    SourceTable = "Service Header";
    SourceTableView = where(Status = const(Pending));

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
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(postingDescription; Rec."Posting Description")
                {
                    Caption = 'Posting Description';
                }
            }
        }
    }
}
