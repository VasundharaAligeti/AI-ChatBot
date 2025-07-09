report 50510 "Item Aging Reports"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Item Aging Reports';
    // ProcessingOnly = true;
    //UseRequestPage = false;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            DataItemTableView = sorting("No.") where(Type = const(Inventory));
            column(No_; "No.")
            {

            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                ItemAgingQuantityHeader();

            end;

            trigger OnAfterGetRecord()
            var
                i: Integer;
                ItemLedgerEntry: Record "Item Ledger Entry";
            begin
                for i := 1 to 5 do begin
                    InventoryQuantity[i] := 0;
                    ItemLedgerEntry.FindLinesWithItemToPlan(Item, false);
                    case i of
                        1:
                            ItemLedgerEntry.SetFilter("Posting Date", '..%1', CalcDate('-1D', WorkDate()));
                        2:
                            ItemLedgerEntry.SetFilter("Posting Date", '%1..%2', WorkDate(), CalcDate('30D', WorkDate()));
                        3:
                            ItemLedgerEntry.SetFilter("Posting Date", '%1..%2', CalcDate('31D', WorkDate()), CalcDate('60D', WorkDate()));
                        4:
                            ItemLedgerEntry.SetFilter("Posting Date", '%1..%2', CalcDate('61D', WorkDate()), CalcDate('90D', WorkDate()));
                        5:
                            ItemLedgerEntry.SetFilter("Posting Date", '%1..', CalcDate('1D', WorkDate()));
                    end;

                    if ItemLedgerEntry.FindSet() then;
                    ItemLedgerEntry.CalcSums("Remaining Quantity");
                    InventoryQuantity[i] := ItemLedgerEntry."Remaining Quantity";
                    TotalInventoryQuantity[1] += ItemLedgerEntry."Remaining Quantity";
                    TotalInventoryQuantity[2] += ItemLedgerEntry."Remaining Quantity";
                    TotalInventoryQuantity[3] += ItemLedgerEntry."Remaining Quantity";
                    TotalInventoryQuantity[4] += ItemLedgerEntry."Remaining Quantity";
                    TotalInventoryQuantity[5] += ItemLedgerEntry."Remaining Quantity";
                end;
                ItemAgingQuantityBody();
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                CreateExcelSheet('Quantity', true);
            end;
        }
        dataitem(Item1; Item)
        {
            DataItemTableView = sorting("No.") where(Type = const(Inventory));
            column(No_1; "No.")
            {

            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                ItemAgingValueHeader();
                Item1.SetRange("No.", '1965-W');
            end;

            trigger OnAfterGetRecord()
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
                i: Integer;
                ValueEntry: Record "Value Entry";
            begin
                TotalUnitCost := 0;
                TotalQuantity := 0;
                ItemLedgerEntry.FilterLinesWithItemToPlan(Item1, false);
                for i := 1 to 5 do begin
                    TotalUnitCost := 0;
                    TotalQuantity := 0;
                    InventoryValue[i] := 0;
                    case i of
                        1:
                            ItemLedgerEntry.SetFilter("Posting Date", '..%1', CalcDate('-1D', WorkDate()));
                        2:
                            ItemLedgerEntry.SetFilter("Posting Date", '%1..%2', WorkDate(), CalcDate('30D', WorkDate()));
                        3:
                            ItemLedgerEntry.SetFilter("Posting Date", '%1..%2', CalcDate('31D', WorkDate()), CalcDate('60D', WorkDate()));
                        4:
                            ItemLedgerEntry.SetFilter("Posting Date", '%1..%2', CalcDate('61D', WorkDate()), CalcDate('90D', WorkDate()));
                        5:
                            ItemLedgerEntry.SetFilter("Posting Date", '%1..', CalcDate('1D', WorkDate()));
                    end;

                    if ItemLedgerEntry.FindSet() then begin
                        ItemLedgerEntry.CalcSums("Remaining Quantity");
                        TotalQuantity := ItemLedgerEntry."Remaining Quantity";
                        repeat
                            ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                            if ValueEntry.Find('-') then
                                repeat
                                    if ValueEntry."Partial Revaluation" then
                                        // SumUnitCost(UnitCost, ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)", ValueEntry."Valued Quantity")
                                        TotalUnitCost += (ValueEntry."Cost per Unit") * ItemLedgerEntry.Quantity
                                    else
                                        //   SumUnitCost(UnitCost, ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)", "Item Ledger Entry".Quantity);
                                        TotalUnitCost += (ValueEntry."Cost per Unit") * ItemLedgerEntry.Quantity;
                                until ValueEntry.Next() = 0;
                        until ItemLedgerEntry.Next() = 0;
                    end;

                    InventoryValue[i] := TotalUnitCost;
                end;
                ItemAgingValueBody();
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                CreateExcelSheet('Value', false);
            end;
            // dataitem("Item Ledger Entry"; "Item Ledger Entry")
            // {
            //     DataItemLink = "Item No." = field("No."), "Location Code" = field("Location Filter"), "Variant Code" = field("Variant Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter");
            //     DataItemTableView = sorting("Item No.", Open) where(Open = const(true));

            //     trigger OnPreDataItem()
            //     var
            //         myInt: Integer;
            //     begin
            //         ItemAgingValueHeader();
            //     end;

            //     trigger OnAfterGetRecord()
            //     var
            //         myInt: Integer;
            //     begin

            //     end;

            //     trigger OnPostDataItem()
            //     var
            //         myInt: Integer;
            //     begin
            //         CreateExcelSheet('Value', true);
            //     end;
            // }
        }
    }
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.DeleteAll();
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        CreateExcelBook();
    end;

    var
        TotalUnitCost: Decimal;
        TotalQuantity: Decimal;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        InventoryQuantity: array[5] of Decimal;
        InventoryValue: array[5] of Decimal;
        TotalInventoryQuantity: array[5] of Decimal;

    local procedure CreateExcelBook()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Item Aging Report');
        TempExcelBuffer.OpenExcel();
    end;

    local procedure CreateExcelSheet(sheetname: Text[250]; NewBook: Boolean)
    var
        myInt: Integer;
    begin
        if NewBook then
            TempExcelBuffer.CreateNewBook(sheetname)
        else
            TempExcelBuffer.SelectOrAddSheet(sheetname);
        TempExcelBuffer.WriteSheet(sheetname, CompanyName, UserId);
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.ClearNewRow();

    end;

    local procedure ItemAgingQuantityHeader()
    var
        myInt: Integer;
        StartingDate: Date;
        EndingDate: Date;
    begin
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn('Item Aging', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn('No.', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Name', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Before', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('0-30 Days', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('31-60 Days', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('60-90 Days', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('After', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total Quantity', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);

    end;

    local procedure ItemAgingQuantityBody()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(Item."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Item.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(InventoryQuantity[1], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(InventoryQuantity[2], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(InventoryQuantity[3], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(InventoryQuantity[4], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(InventoryQuantity[5], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(InventoryQuantity[1] + InventoryQuantity[2] + InventoryQuantity[3] + InventoryQuantity[4] + InventoryQuantity[5], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
    end;

    local procedure ItemAgingQuantityTotal()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Total', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TotalInventoryQuantity[1], false, '', true, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(TotalInventoryQuantity[2], false, '', true, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(TotalInventoryQuantity[3], false, '', true, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(TotalInventoryQuantity[4], false, '', true, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(TotalInventoryQuantity[5], false, '', true, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(TotalInventoryQuantity[1] + TotalInventoryQuantity[2] + TotalInventoryQuantity[3] + TotalInventoryQuantity[4] + TotalInventoryQuantity[5], false, '', true, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
    end;

    local procedure ItemAgingValueHeader()
    var
        myInt: Integer;
        StartingDate: Date;
        EndingDate: Date;
    begin
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn('Item Aging', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn('No.', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Name', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Before', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('0-30 Days', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('31-60 Days', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('60-90 Days', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('After', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total Value', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure ItemAgingValueBody()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(Item1."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Item1.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(InventoryValue[1], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(InventoryValue[2], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(InventoryValue[3], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(InventoryValue[4], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(InventoryValue[5], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(InventoryValue[1] + InventoryValue[2] + InventoryValue[3] + InventoryValue[4] + InventoryValue[5], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
    end;
}