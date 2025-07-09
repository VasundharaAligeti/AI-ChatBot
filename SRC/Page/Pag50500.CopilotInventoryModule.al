page 50500 "Copilot Inventory Module"
{
    ApplicationArea = All;
    Caption = 'Copilot Inventory Module';
    PageType = Card;
    SourceTable = "Copilot Inventory Module";
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Item List Page URL"; Rec."Item List Page URL")
                {
                    ToolTip = 'Specifies the value of the Item List Page URL field.', Comment = '%';
                    MultiLine = true;
                }
                field("Item Card Page URL"; Rec."Item Card Page URL")
                {
                    ToolTip = 'Specifies the value of the Item Card Page URL field.', Comment = '%';
                    MultiLine = true;
                }
                field("Item Ledger List Page URL"; Rec."Item Ledger List Page URL")
                {
                    ToolTip = 'Specifies the value of the Item Ledger List Page URL field.', Comment = '%';
                    MultiLine = true;
                }
            }
            group(Validations)
            {
                field("Item Inventory Threshold"; Rec."Item Inventory Threshold")
                {
                    ToolTip = 'Specifies the value of the Item Inventory Threshold field.', Comment = '%';
                    BlankZero = true;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
