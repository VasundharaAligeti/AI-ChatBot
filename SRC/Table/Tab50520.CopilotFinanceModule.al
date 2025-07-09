table 50520 "Copilot Finance Module"
{
    Caption = 'Copilot Finance Module';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Primary key"; Code[10])
        {
            Caption = 'Primary key';
        }
        field(2; "Journal Template"; Code[20])
        {
            Caption = 'Journal Template';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(3; "Journal Batch"; Code[20])
        {
            Caption = 'Journal Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template"));
        }
        field(4; "CFO Finance Report"; Code[10])
        {
            Caption = 'CFO Finance Report';
            TableRelation = "Financial Report".Name;
        }
    }
    keys
    {
        key(PK; "Primary key")
        {
            Clustered = true;
        }
    }
}
