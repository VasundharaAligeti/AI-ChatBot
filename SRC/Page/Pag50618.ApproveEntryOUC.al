page 50618 ApproveEntryOUC
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'approveEntryOUC';
    DelayedInsert = true;
    EntityName = 'ApproveEntryOUC';
    EntitySetName = 'ApproveEntryOUC';
    PageType = API;
    SourceTable = "Approval Entry";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(sequenceNo; Rec."Sequence No.")
                {
                    Caption = 'Sequence No.';
                }
                field(approvalCode; Rec."Approval Code")
                {
                    Caption = 'Approval Code';
                }
                field(approverID; Rec."Approver ID")
                {
                    Caption = 'Approver ID';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountLCY; Rec."Amount (LCY)")
                {
                    Caption = 'Amount (LCY)';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field("DueDate"; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
            }
        }
    }
}
