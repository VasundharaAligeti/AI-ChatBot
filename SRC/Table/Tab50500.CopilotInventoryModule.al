table 50510 "Copilot Inventory Module"
{
    Caption = 'Copilot Inventory Module';
    DataClassification = ToBeClassified;
    DataCaptionFields = "Primary Key";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Item Card Page URL"; Text[2048])
        {
            Caption = 'Item Card Page URL';
        }
        field(3; "Item List Page URL"; Text[2048])
        {
            Caption = 'Item List Page URL';
        }
        field(4; "Item Inventory Threshold"; Decimal)
        {
            Caption = 'Item Inventory Threshold';
        }
        field(5; "Item Ledger List Page URL"; Text[2048])
        {
            Caption = 'Item Ledger List Page URL';
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
