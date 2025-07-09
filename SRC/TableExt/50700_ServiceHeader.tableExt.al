tableextension 50700 serviceHeaderTableExt extends "Service Header"
{
    fields
    {
        field(50100; Ship; Boolean)
        {
            Caption = 'ship';
            DataClassification = CustomerContent;
        }
        field(50101; Invoice; Boolean)
        {
            Caption = 'Invoice';
            DataClassification = CustomerContent;
        }
        field(50102; Consume; Boolean)
        {
            Caption = 'Consume';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}