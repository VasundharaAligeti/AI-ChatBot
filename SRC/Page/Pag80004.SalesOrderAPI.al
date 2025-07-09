page 80004 SalesOrderAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'SalesOrderAPI';
    DelayedInsert = true;
    EntityName = 'SalesOrderAPI';
    EntitySetName = 'SalesOrderAPI';
    PageType = API;
    SourceTable = "Sales Header";
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
                field(Id; Rec.SystemId) { }
                field(GetMargin1; GetMargin()) { }
                field(GetMarginPercent1; GetMarginPercent()) { }
            }
        }
    }

    [ServiceEnabled]
    procedure GetMarginPercent(): Decimal
    var
        myInt: Integer;
        SalesLine: Record "Sales Line";
    begin
        MarginPercent := 0;
        Margin := 0;
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");

        SalesLine.CalcSums("Unit Price", "Unit Cost");

        TotalSales := SalesLine."Unit Price";
        TotalCost := SalesLine."Unit Cost";
        Margin := TotalSales - TotalCost;

        if TotalSales <> 0 then
            MarginPercent := Round((Margin / TotalSales) * 100, 0.01);
        exit(MarginPercent);

    end;

    [ServiceEnabled]
    procedure GetMargin(): Decimal
    var
        myInt: Integer;
        SalesLine: Record "Sales Line";
    begin
        MarginPercent := 0;
        Margin := 0;
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");

        SalesLine.CalcSums("Unit Price", "Unit Cost");
        TotalSales := SalesLine."Unit Price";
        TotalCost := SalesLine."Unit Cost";
        Margin := TotalSales - TotalCost;

        exit(Margin);
    end;


    [ServiceEnabled]
    procedure ApprovalSO(): Boolean
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then begin
            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
            exit(true);
        end
        ELSE
            exit(FALSE);
    end;


    var
        Margin: Decimal;
        TotalSales: Decimal;
        TotalCost: Decimal;
        MarginPercent: Decimal;

}
