page 50512 SalesShipmentHeaderAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'salesShipmentHeaderAPI';
    DelayedInsert = true;
    EntityName = 'SalesShipmentHeaderAPI';
    EntitySetName = 'SalesShipmentHeaderAPI';
    PageType = API;
    SourceTable = "Sales Shipment Header";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(sellToCustomerName; Rec."Sell-to Customer Name")
                {
                    Caption = 'Sell-to Customer Name';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetFilter("Posting Date", '%1', WorkDate());

    end;
}
