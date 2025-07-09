pageextension 50500 "Transfer Order Subform Ext" extends "Transfer Order Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = all;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
