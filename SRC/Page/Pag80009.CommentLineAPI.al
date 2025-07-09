page 80009 CommentLineAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'CommentLineAPI';
    DelayedInsert = true;
    EntityName = 'CommentLineAPI';
    EntitySetName = 'CommentLineAPI';
    PageType = API;
    SourceTable = "Comment Line";
    // SourceTableView = where("Document Type" = filter(Invoice | "Credit Memo"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec."No.") { }
                field(Date; Rec.Date) { }
                field(Comment; Rec."Comment") { }
            }
        }
    }
    [ServiceEnabled]
    procedure CustomerComment(): Text
    var
        CommentLine: Record "Comment Line";
        CustomComments: Text[80];
        CommentDate: Date;
    begin





    end;


}