tableextension 50701 ProductionOrderTableExt extends "Production Order"
{
    fields
    {
        // Add changes to fields here
        field(50101; Isconsumption; Boolean)
        {
            Caption = 'Is consumption';
            DataClassification = CustomerContent;
        }
        field(50102; IsOutput; Boolean)
        {
            Caption = 'Is Output';
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