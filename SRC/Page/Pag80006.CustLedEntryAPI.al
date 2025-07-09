page 80006 CustLedEntryAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'CustLedEntryAPI';
    DelayedInsert = true;
    EntityName = 'CustLedEntryAPI';
    EntitySetName = 'CustLedEntryAPI';
    PageType = API;
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = where("Document Type" = filter(Invoice | "Credit Memo"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(SelltoCustomerNo; Rec."Sell-to Customer No.") { }
                field(Description; Rec.Description) { }
                field(RemainingAmount; Rec."Remaining Amount") { }
                field(PostingDate; Rec."Posting Date") { }
                field(AmountLCY; Rec."Amount (LCY)") { }
                field(GetLastMonthAmount1; GetLastMonthAmount()) { }
                // field(GetCustomerWithOverDueBalance1; GetCustomerWithOverDueBalance()) { }
                field(GetOverdueBalanceForCustomer1; GetOverdueBalanceForCustomer(Rec."Customer No.")) { }
                field(ItemCardURL; GetItemCardPageFilterAPI()) { }


            }
        }
    }
    //-------------------------------View - CLE- Customer Module------------------------------------//


    local procedure GetItemCardPageFilterAPI(): Text
    var
        CopilotInventoryModule: Record "Cust. Ledger Entry";
        BaseURL: Text;
        EncodedNo: Text;
    begin

        BaseURL := 'https://businesscentral.dynamics.com/d883421a-ac43-457f-ade4-01f4f16f29bc/VasuuSandbox/?company=Cronus-German&page=25';
        EncodedNo := UrlEncode(Rec."Sell-to Customer No.");
        BaseURL += '&filter=''' + 'Customer No.' + ''' IS ''' + EncodedNo + '''';

        exit(BaseURL);

    end;

    procedure UrlEncode(Input: Code[2048]): Text
    var
        Output: Text;
        i: Integer;
        Char: Char;
    begin
        for i := 1 to StrLen(Input) do begin
            Char := Input[i];
            case Char of
                'A' .. 'Z', 'a' .. 'z', '0' .. '9', '-', '_', '.', '~':
                    Output += Char;
                ' ':
                    Output += '%20';
                else
                    Output += '%' + Format(Char, 0, 2);
            end;
        end;

        exit(Output);
    end;

    //-------------------------------View - CLE- Customer Module------------------------------------//




    [ServiceEnabled]
    procedure GetLastMonthAmount(): Decimal
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        TotalAmount: Decimal;
    begin
        StartDate := WorkDate();
        EndDate := CALCDATE('<-1M>', StartDate);


        CustLedgEntry.Reset();
        CustLedgEntry.SetAutoCalcFields("Amount (LCY)");
        CustLedgEntry.SetLoadFields("Amount (LCY)");
        CustLedgEntry.SetRange("Posting Date", EndDate, StartDate);
        CustLedgEntry.SetFilter("Document Type", '%1|%2',
            CustLedgEntry."Document Type"::Invoice,
            CustLedgEntry."Document Type"::"Credit Memo");

        if CustLedgEntry.FindSet() then
            repeat
                TotalAmount += CustLedgEntry."Amount (LCY)";
            until CustLedgEntry.Next() = 0;

        exit(TotalAmount);
    end;

    [ServiceEnabled]
    procedure GetOverdueBalanceForCustomer(CustomerNo: Code[20]): Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        TotalOverdue: Decimal;
        Key1: code[20];
        Value: Decimal;
        Customer: Record Customer;
        OverdueDict: Dictionary of [Code[20], Decimal];
        Result: Text;
    begin
        TotalOverdue := 0;
        CustLedgerEntry.SetFilter("Customer No.", '%1', CustomerNo);
        CustLedgerEntry.SetRange(Open, true);
        CustLedgerEntry.SetFilter("Due Date", '<%1', Today);
        CustLedgerEntry.SetAutoCalcFields("Remaining Amt. (LCY)");

        if CustLedgerEntry.FindSet() then
            repeat
                TotalOverdue += CustLedgerEntry."Remaining Amt. (LCY)";
            until CustLedgerEntry.Next() = 0;

        exit(TotalOverdue);
    end;
}