page 50910 VendorstatisticsAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'vendorstatisticsAPI';
    DelayedInsert = true;
    EntityName = 'VendorstatisticsAPI';
    EntitySetName = 'VendorstatisticsAPI';
    PageType = API;
    SourceTable = Vendor;
    ODataKeyFields = SystemId;

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
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field("BalanceLCY"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total value of your completed purchases from the vendor in the current fiscal year. It is calculated from amounts including VAT on all completed purchase invoices and credit memos.';
                }
                field(BalanceAsCustomer; BalanceAsCustomer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance (LCY) As Customer';
                    Editable = false;
                    Enabled = BalanceAsCustomerEnabled;
                    ToolTip = 'Specifies the amount that this company owes you. This is relevant when your vendor is also your customer. Vendor and customer are linked together through their contact record. Using vendor''s contact record you can create linked customer or link contact with existing customer to enable calculation of Balance As Customer amount.';

                    trigger OnDrillDown()
                    var
                        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                        CustLedgerEntry: Record "Cust. Ledger Entry";
                    begin
                        if LinkedCustomerNo = '' then
                            exit;
                        DetailedCustLedgEntry.SetRange("Customer No.", LinkedCustomerNo);
                        Rec.CopyFilter("Global Dimension 1 Filter", DetailedCustLedgEntry."Initial Entry Global Dim. 1");
                        Rec.CopyFilter("Global Dimension 2 Filter", DetailedCustLedgEntry."Initial Entry Global Dim. 2");
                        Rec.CopyFilter("Currency Filter", DetailedCustLedgEntry."Currency Code");
                        CustLedgerEntry.DrillDownOnEntries(DetailedCustLedgEntry);
                    end;
                }
                field("OutstandingOrdersLCY"; Rec."Outstanding Orders (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of outstanding orders (in LCY) to this vendor.';
                }
                field("AmtRcdNotInvoicedLCY"; Rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Amt. Rcd. Not Invd. (LCY)';
                    ToolTip = 'Specifies the total invoice amount (in LCY) for the items you have received but not yet been invoiced for.';
                }
                field("OutstandingInvoicesLCY"; Rec."Outstanding Invoices (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of the vendor''s outstanding purchase invoices in LCY.';
                }
                field(TotalAmountLCY; TotalAmountLCY)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatType = 1;
                    Caption = 'Total (LCY)';
                    ToolTip = 'Specifies the payment amount that you owe the vendor for completed purchases plus purchases that are still ongoing.';
                }
                field("OverDueBalance"; OverDueBalance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Due (LCY)';
                }
                field(GetInvoicedPrepmtAmountLCY; InvoicedPrepmtAmountLCY)
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Invoiced Prepayment Amount (LCY)';
                    ToolTip = 'Specifies your payments to the vendor, based on invoiced prepayments.';
                }
                field("PaymentsLCY"; Rec."Payments (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of payments paid to the vendor.';
                }
                field("RefundsLCY"; Rec."Refunds (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of refunds paid to the vendor.';
                }
                field(LastPaymentDate; LastPaymentDate)
                {
                    AccessByPermission = TableData "Vendor Ledger Entry" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Last Payment Date';
                    ToolTip = 'Specifies the posting date of the last payment paid to the vendor.';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetAutoCalcFields("Balance (LCY)", "Outstanding Orders (LCY)", "Amt. Rcd. Not Invoiced (LCY)", "Outstanding Invoices (LCY)");
    end;

    trigger OnAfterGetRecord()
    var
        VendorNo: Code[20];
        VendorNoFilter: Text;
    begin
        TotalAmountLCY := Rec."Balance (LCY)" + Rec."Outstanding Orders (LCY)" + Rec."Amt. Rcd. Not Invoiced (LCY)" + Rec."Outstanding Invoices (LCY)";
        // Get the vendor number and set the current vendor number
        Rec.FilterGroup(4);
        VendorNoFilter := Rec.GetFilter("No.");
        if (VendorNoFilter = '') then begin
            Rec.FilterGroup(0);
            VendorNoFilter := Rec.GetFilter("No.");
        end;

        VendorNo := CopyStr(VendorNoFilter, 1, MaxStrLen(VendorNo));
        if VendorNo <> CurrVendorNo then begin
            CurrVendorNo := VendorNo;
            CalculateFieldValues(CurrVendorNo);
        end;
        OverdueBalance := 0;
        OverdueBalance := Rec.CalcOverDueBalance();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        TotalAmountLCY := 0;

        exit(Rec.Find(Which));
    end;

    var
        Text000: Label 'Overdue Amounts (LCY) as of %1';
        TaskIdCalculateCue: Integer;
        CurrVendorNo: Code[20];
        LinkedCustomerNo: Code[20];
        BalanceAsCustomerEnabled: Boolean;

    protected var
        TotalAmountLCY: Decimal;
        LastPaymentDate: Date;
        InvoicedPrepmtAmountLCY: Decimal;
        OverdueBalance: Decimal;
        BalanceAsCustomer: Decimal;

    procedure CalculateFieldValues(VendorNo: Code[20])
    var
        CalculateVendorStats: Codeunit CalculateVendorStatsSJSI;
        Args: Dictionary of [Text, Text];
    begin
        if (TaskIdCalculateCue <> 0) then
            CurrPage.CancelBackgroundTask(TaskIdCalculateCue);

        Clear(LastPaymentDate);
        Clear(OverdueBalance);
        Clear(InvoicedPrepmtAmountLCY);
        Clear(LinkedCustomerNo);
        Clear(BalanceAsCustomer);
        Clear(BalanceAsCustomerEnabled);

        if VendorNo = '' then
            exit;

        Args.Add(CalculateVendorStats.GetVendorNoLabel(), VendorNo);
        CurrPage.EnqueueBackgroundTask(TaskIdCalculateCue, Codeunit::CalculateVendorStatsSJSI, Args);
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        CalculateVendorStats: Codeunit CalculateVendorStatsSJSI;
        DictionaryValue: Text;
    begin
        if (TaskId = TaskIdCalculateCue) then begin
            if Results.Count() = 0 then
                exit;

            if TryGetDictionaryValueFromKey(Results, CalculateVendorStats.GetLastPaymentDateLabel(), DictionaryValue) then
                Evaluate(LastPaymentDate, DictionaryValue);

            if TryGetDictionaryValueFromKey(Results, CalculateVendorStats.GetOverdueBalanceLabel(), DictionaryValue) then
                Evaluate(OverdueBalance, DictionaryValue);

            if TryGetDictionaryValueFromKey(Results, CalculateVendorStats.GetInvoicedPrepmtAmountLCYLabel(), DictionaryValue) then
                Evaluate(InvoicedPrepmtAmountLCY, DictionaryValue);

            if TryGetDictionaryValueFromKey(Results, CalculateVendorStats.GetLinkedCustomerNoLabel(), DictionaryValue) then
                LinkedCustomerNo := CopyStr(DictionaryValue, 1, MaxStrLen(LinkedCustomerNo));
            BalanceAsCustomerEnabled := LinkedCustomerNo <> '';
            if BalanceAsCustomerEnabled then
                if TryGetDictionaryValueFromKey(Results, CalculateVendorStats.GetBalanceAsCustomerLabel(), DictionaryValue) then
                    Evaluate(BalanceAsCustomer, DictionaryValue);
        end;
    end;

    [TryFunction]
    local procedure TryGetDictionaryValueFromKey(var DictionaryToLookIn: Dictionary of [Text, Text]; KeyToSearchFor: Text; var ReturnValue: Text)
    begin
        ReturnValue := DictionaryToLookIn.Get(KeyToSearchFor);
    end;

    local procedure ShowDetails()
    begin
        PAGE.Run(PAGE::"Vendor Card", Rec);
    end;

    local procedure SetFilterLastPaymentDateEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        VendorLedgerEntry.SetCurrentKey("Document Type", "Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Vendor No.", Rec."No.");
        VendorLedgerEntry.SetRange("Document Type", VendorLedgerEntry."Document Type"::Payment);
        VendorLedgerEntry.SetRange(Reversed, false);
    end;

    local procedure SetFilterRefundEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        VendorLedgerEntry.SetCurrentKey("Document Type", "Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Vendor No.", Rec."No.");
        VendorLedgerEntry.SetRange("Document Type", VendorLedgerEntry."Document Type"::Refund);
        VendorLedgerEntry.SetRange(Reversed, false);
    end;
}
