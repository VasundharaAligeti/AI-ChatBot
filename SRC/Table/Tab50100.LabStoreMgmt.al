table 80000 "Lab Store Mgmt"
{
    Caption = 'Lab Store Mgmt';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item Code"; Code[50])
        {
            Caption = 'Item Code';
        }
        field(2; "Item Name"; Text[50])
        {
            Caption = 'Item Name';
        }
        field(3; "Item Purchase Date"; Date)
        {
            Caption = 'Item Purchase Date';
        }
        field(4; "Remove Item"; Boolean)
        {
            Caption = 'Remove Item';
        }
        field(5; Condition; Enum Condition)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Item Code")
        {
            Clustered = true;
        }
    }
}
