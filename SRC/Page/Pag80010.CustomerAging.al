page 80010 CustomerAging
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'CustomerAging';
    DelayedInsert = true;
    EntityName = 'CustomerAging';
    EntitySetName = 'CustomerAging';
    PageType = API;
    SourceTable = Customer;
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
                field(CustCurrentDec; CustCurrentDec)
                {
                    Caption = 'Current';
                    Editable = false;
                }
                field(CustBalance30D; CustBalance30D)
                {
                    Caption = '30 Days';
                    Editable = false;
                }
                field(CustBalance60D; CustBalance60D)
                {
                    Caption = '60 Days';
                    Editable = false;
                }
                field(CustBalance90D; CustBalance90D)
                {
                    Caption = '90 Days';
                    Editable = false;
                }
                field(TotalPayableDue; TotalPayableDue)
                {
                    Caption = 'Total Payable Due';
                    Editable = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        CustLedEntry: Record "Cust. Ledger Entry";
    begin
        CustCurrentDec := 0;
        CustLedEntry.Reset();
        CustLedEntry.SetLoadFields("Due Date", "Remaining Amt. (LCY)");
        CustLedEntry.SetFilter("Due Date", '>%1', WorkDate());
        CustLedEntry.SetFilter("Remaining Amt. (LCY)", '<>0');
        CustLedEntry.SetRange("Customer No.", Rec."No.");
        IF CustLedEntry.FindSet() then
            repeat
                CustLedEntry.CalcFields("Remaining Amt. (LCY)");
                CustCurrentDec += CustLedEntry."Remaining Amt. (LCY)";
            until CustLedEntry.Next() = 0;

        CustBalance30D := 0;
        CustLedEntry.Reset();
        CustLedEntry.SetLoadFields("Due Date", "Remaining Amt. (LCY)");
        CustLedEntry.SetRange("Due Date", CalcDate('<-30D>', WorkDate()), WorkDate());
        CustLedEntry.SetFilter("Remaining Amt. (LCY)", '<>0');
        CustLedEntry.SetRange("Customer No.", Rec."No.");
        IF CustLedEntry.FindSet() then
            repeat
                CustLedEntry.CalcFields("Remaining Amt. (LCY)");
                CustBalance30D += CustLedEntry."Remaining Amt. (LCY)";
            until CustLedEntry.Next() = 0;

        CustBalance60D := 0;
        CustLedEntry.Reset();
        CustLedEntry.SetLoadFields("Due Date", "Remaining Amt. (LCY)");
        CustLedEntry.SetRange("Due Date", CalcDate('<-60D>', WorkDate()), CalcDate('<-31D>', WorkDate()));
        CustLedEntry.SetFilter("Remaining Amt. (LCY)", '<>0');
        CustLedEntry.SetRange("Customer No.", Rec."No.");
        IF CustLedEntry.FindSet() then
            repeat
                CustLedEntry.CalcFields("Remaining Amt. (LCY)");
                CustBalance60D += CustLedEntry."Remaining Amt. (LCY)";
            until CustLedEntry.Next() = 0;

        CustBalance90D := 0;
        CustLedEntry.Reset();
        CustLedEntry.SetLoadFields("Due Date", "Remaining Amt. (LCY)");
        CustLedEntry.SetRange("Due Date", 0D, CalcDate('<-61D>', WorkDate()));
        CustLedEntry.SetFilter("Remaining Amt. (LCY)", '<>0');
        CustLedEntry.SetRange("Customer No.", Rec."No.");
        IF CustLedEntry.FindSet() then
            repeat
                CustLedEntry.CalcFields("Remaining Amt. (LCY)");
                CustBalance90D += CustLedEntry."Remaining Amt. (LCY)";
            until CustLedEntry.Next() = 0;

        TotalPayableDue := 0;
        TotalPayableDue := CustCurrentDec + CustBalance30D + CustBalance60D + CustBalance90D;
    end;

    var
        CustBalance30D: Decimal;
        CustBalance60D: Decimal;
        CustBalance90D: Decimal;
        CustCurrentDec: Decimal;
        TotalPayableDue: Decimal;
}