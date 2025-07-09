page 50909 VendorAgedAccPayable
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'vendorAgedAccPayable';
    DelayedInsert = true;
    EntityName = 'VendorAgedAccPayable';
    EntitySetName = 'VendorAgedAccPayable';
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
                field(VendCurrentDec; VendCurrentDec * -1)
                {
                    Caption = 'Current';
                    Editable = false;
                }
                field(VendBalance30D; VendBalance30D * -1)
                {
                    Caption = '30 Days';
                    Editable = false;
                }
                field(VendBalance60D; VendBalance60D * -1)
                {
                    Caption = '60 Days';
                    Editable = false;
                }
                field(VendBalance90D; VendBalance90D * -1)
                {
                    Caption = '90 Days';
                    Editable = false;
                }
                field(TotalPayableDue; TotalPayableDue * -1)
                {
                    Caption = 'Total Payable Due';
                    Editable = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendCurrentDec := 0;
        VendLedgerEntry.Reset();
        VendLedgerEntry.SetLoadFields("Due Date", "Remaining Amt. (LCY)");
        VendLedgerEntry.SetFilter("Due Date", '>%1', WorkDate());
        VendLedgerEntry.SetFilter("Remaining Amt. (LCY)", '<>0');
        VendLedgerEntry.SetRange("Vendor No.", Rec."No.");
        IF VendLedgerEntry.FindSet() then
            repeat
                VendLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                VendCurrentDec += VendLedgerEntry."Remaining Amt. (LCY)";
            until VendLedgerEntry.Next() = 0;

        VendBalance30D := 0;
        VendLedgerEntry.Reset();
        VendLedgerEntry.SetLoadFields("Due Date", "Remaining Amt. (LCY)");
        VendLedgerEntry.SetRange("Due Date", CalcDate('<-30D>', WorkDate()), WorkDate());
        VendLedgerEntry.SetFilter("Remaining Amt. (LCY)", '<>0');
        VendLedgerEntry.SetRange("Vendor No.", Rec."No.");
        IF VendLedgerEntry.FindSet() then
            repeat
                VendLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                VendBalance30D += VendLedgerEntry."Remaining Amt. (LCY)";
            until VendLedgerEntry.Next() = 0;

        VendBalance60D := 0;
        VendLedgerEntry.Reset();
        VendLedgerEntry.SetLoadFields("Due Date", "Remaining Amt. (LCY)");
        VendLedgerEntry.SetRange("Due Date", CalcDate('<-60D>', WorkDate()), CalcDate('<-31D>', WorkDate()));
        VendLedgerEntry.SetFilter("Remaining Amt. (LCY)", '<>0');
        VendLedgerEntry.SetRange("Vendor No.", Rec."No.");
        IF VendLedgerEntry.FindSet() then
            repeat
                VendLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                VendBalance60D += VendLedgerEntry."Remaining Amt. (LCY)";
            until VendLedgerEntry.Next() = 0;

        VendBalance90D := 0;
        VendLedgerEntry.Reset();
        VendLedgerEntry.SetLoadFields("Due Date", "Remaining Amt. (LCY)");
        VendLedgerEntry.SetRange("Due Date", 0D, CalcDate('<-61D>', WorkDate()));
        VendLedgerEntry.SetFilter("Remaining Amt. (LCY)", '<>0');
        VendLedgerEntry.SetRange("Vendor No.", Rec."No.");
        IF VendLedgerEntry.FindSet() then
            repeat
                VendLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                VendBalance90D += VendLedgerEntry."Remaining Amt. (LCY)";
            until VendLedgerEntry.Next() = 0;

        TotalPayableDue := 0;
        TotalPayableDue := VendCurrentDec + VendBalance30D + VendBalance60D + VendBalance90D;
    end;

    var
        VendBalance30D: Decimal;
        VendBalance60D: Decimal;
        VendBalance90D: Decimal;
        VendCurrentDec: Decimal;
        TotalPayableDue: Decimal;
}
