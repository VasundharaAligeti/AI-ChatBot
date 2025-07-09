page 80003 SalesLineNEWAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'SalesLineNEWAPI';
    DelayedInsert = true;
    EntityName = 'SalesLineNEWAPI';
    EntitySetName = 'SalesLineNEWAPI';
    PageType = API;
    SourceTable = "Sales Line";
    ODataKeyFields = "No.";
    SourceTableView = where("Document Type" = const(Order));

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(No; Rec."No.") { }
                field(SelltoCustomerNo; Rec."Sell-to Customer No.") { }
                field(PostingDate; Rec."Posting Date") { }
                field(DocumentNo; Rec."Document No.") { }
                field(UnitPrice; Rec."Unit Price") { }
                field(UnitCost; Rec."Unit Cost") { }
                field(GetOrderDeliveryStatus; GetOrderDeliveryStatus1(Rec."Document Type"::Order, Rec."Document No.")) { }
            }
        }
    }



    procedure GetOrderDeliveryStatus1(DocumentType: Enum "Sales Document Type"; DocumentNo: Code[20]): Text
    var
        SalesLine: Record "Sales Line";
        AnyShipped: Boolean;
        AllShipped: Boolean;
    begin
        SalesLine.SetRange("Document Type", DocumentType);
        SalesLine.SetRange("Document No.", DocumentNo);

        AnyShipped := false;
        AllShipped := true;

        if SalesLine.FindSet() then
            repeat
                if SalesLine."Quantity Shipped" > 0 then
                    AnyShipped := true;

                if SalesLine."Quantity Shipped" < SalesLine.Quantity then
                    AllShipped := false;
            until SalesLine.Next() = 0;

        if not AnyShipped then
            exit('Not Shipped')
        else if AllShipped then
            exit('Fully Shipped')
        else
            exit('Partially Shipped');
    end;


    var
        Margin: Decimal;
        TotalSales: Decimal;
        TotalCost: Decimal;
        MarginPercent: Decimal;

}
