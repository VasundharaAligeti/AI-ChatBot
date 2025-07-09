tableextension 80000 "Customer Ext" extends Customer
{
    fields
    {
        field(80001; Tag; Text[20])
        {
            Caption = 'Tag';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}