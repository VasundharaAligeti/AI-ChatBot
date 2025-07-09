page 50502 CopilotInventoryModuleAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'copilotInventoryModuleAPI';
    DelayedInsert = true;
    EntityName = 'CopilotInventoryModuleAPI';
    EntitySetName = 'CopilotInventoryModuleAPI';
    PageType = API;
    SourceTable = "Copilot Inventory Module";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(itemCardPageURL; Rec."Item Card Page URL")
                {
                    Caption = 'Item Card Page URL';
                }
                field(itemListPageURL; Rec."Item List Page URL")
                {
                    Caption = 'Item List Page URL';
                }
                field("itemInventoryThreshold"; Rec."Item Inventory Threshold")
                {
                    Caption = 'Item Inventory Threshold';
                }
                field("itemLedgerListPageURL"; Rec."Item Ledger List Page URL")
                {
                    Caption = 'Item Ledger List Page URL';
                }
            }
        }
    }
    [ServiceEnabled]
    procedure ListofTrackItemMovementsAPI(): Text
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        Baseurl: Text;
    begin
        StartDate := WorkDate();
        EndDate := CalcDate('-1M', WorkDate());
        ItemLedgerEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
        if ItemLedgerEntry.FindSet() then;
        BaseUrl := GetUrl(CurrentClientType, CompanyName, ObjectType::Page, Page::"Item Ledger Entries", ItemLedgerEntry, true);
        exit(BaseUrl);
    end;

    [ServiceEnabled]
    procedure CreateTransferHeader(SourceLocation: Code[20]; DestinationLocation: Code[20]): Text
    var
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        LineNo: Integer;
        InventorySetup: Record "Inventory Setup";
        NoSeries: Codeunit "No. Series";
    begin
        TransferHeader.Init();
        InventorySetup.Get();
        TransferHeader.Validate("No.", NoSeries.GetNextNo(InventorySetup."Transfer Order Nos.", WorkDate(), true));
        TransferHeader.Validate("Transfer-from Code", SourceLocation);
        TransferHeader.Validate("Transfer-to Code", DestinationLocation);
        TransferHeader.Validate("In-Transit Code", 'OUT. LOG.');
        TransferHeader.Insert(true);
        exit(TransferHeader."No.");

    end;

    [ServiceEnabled]
    procedure AssignPutAway(DocumentNo: Code[20]; UserRec: Code[20]): Boolean
    var
        User: Record User;
        WarehouseActivityHeader: Record "Warehouse Activity Header";
    begin
        User.SetRange("User Name", UserRec);
        if not User.FindFirst() then
            exit(false);

        WarehouseActivityHeader.SetRange("No.", DocumentNo);
        if WarehouseActivityHeader.FindFirst() then
            exit(false)
        else begin
            if WarehouseActivityHeader."Assigned User ID" <> '' then
                exit(false)
            else begin
                WarehouseActivityHeader.Validate("Assigned User ID", UserRec);
                WarehouseActivityHeader.Modify(true);
            end;
        end;

    end;

    [ServiceEnabled]
    procedure CreateTransferLine(DocumentNo: Code[20]; ItemNo: Code[20]; Quantity: Decimal): Text
    var
        TransferLine: Record "Transfer Line";
        LineNo: Integer;
    begin
        TransferLine.SetRange("Document No.", DocumentNo);
        if TransferLine.FindLast() then
            LineNo := TransferLine."Line No." + 10000
        else
            LineNo := 10000;

        TransferLine.Init();
        TransferLine.Validate("Document No.", DocumentNo);
        TransferLine."Line No." := LineNo;
        TransferLine.Validate("Item No.", ItemNo);
        TransferLine.Validate(Quantity, Quantity);
        TransferLine.Insert();

    end;

    [ServiceEnabled]
    procedure GetStockAlertItemAPI(): Text
    var
        BaseUrl: Text;
        EncodedCompany: Text;
        CopilotInventoryModule: Record "Copilot Inventory Module";
        InventoryFilter: Integer;
    begin
        CopilotInventoryModule.Get();
        BaseURL := CopilotInventoryModule."Item List Page URL";
        InventoryFilter := CopilotInventoryModule."Item Inventory Threshold" - 1;
        BaseURL += '&filter=''' + 'Inventory' + ''' IS ..' + Format(InventoryFilter) + '';
        exit(BaseUrl);
    end;

    [ServiceEnabled]
    procedure GetReorderQuantityItemAPI(): Text
    var
        BaseUrl: Text;
        EncodedCompany: Text;
        CopilotInventoryModule: Record "Copilot Inventory Module";
        InventoryFilter: Integer;
    begin
        CopilotInventoryModule.Get();
        BaseURL := CopilotInventoryModule."Item List Page URL";
        InventoryFilter := CopilotInventoryModule."Item Inventory Threshold" - 1;
        BaseURL += '&filter=''' + 'Reorder Quantity' + ''' IS ..' + Format(InventoryFilter) + '';
        exit(BaseUrl);
    end;

    [ServiceEnabled]
    procedure WarehouseUtilizationReport(): Text
    var
        OutStream: OutStream;
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        Item: Record Item;
        InStream: InStream;
        LargeText: Text;
        ItemLedgerentry: Record "Item Ledger Entry";
    begin
        RecRef.GetTable(ItemLedgerentry);
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(50501, '', ReportFormat::Pdf, OutStream, RecRef);
        TempBlob.CreateInStream(InStream);
        LargeText := Base64Convert.ToBase64(InStream, false);
        exit(LargeText);
    end;

    [ServiceEnabled]
    procedure RunInventoryValuationReport(): Text
    var
        OutStream: OutStream;
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        Item: Record Item;
        InStream: InStream;
        LargeText: Text;
    begin
        Item.SetRange(Blocked, false);
        if Item.FindSet() then;
        RecRef.GetTable(Item);
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(701, '', ReportFormat::Pdf, OutStream, RecRef);
        TempBlob.CreateInStream(InStream);
        LargeText := Base64Convert.ToBase64(InStream, false);
        exit(LargeText);
    end;

    [ServiceEnabled]
    procedure RunItemAgingReport(): Text
    var
        OutStream: OutStream;
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        Item: Record Item;
        InStream: InStream;
        LargeText: Text;
    begin
        TempExcelBuffer.DeleteAll();
        BuildItemAgingQuantitySheet();
        BuildItemAgingValueSheet();

        // TempExcelBuffer.WriteSheet('Quantity Aging', CompanyName, UserId);
        // TempExcelBuffer.WriteSheet('Value Aging', CompanyName, UserId);

        TempExcelBuffer.CloseBook();
        //TempExcelBuffer.OpenExcel();
        TempBlob.CreateOutStream(OutStream);
        TempExcelBuffer.SaveToStream(OutStream, false);
        TempBlob.CreateInStream(InStream);
        LargeText := Base64Convert.ToBase64(InStream, false);
        exit(LargeText);

    end;

    local procedure BuildItemAgingQuantitySheet()
    var
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        i: Integer;
        InventoryQuantity: array[5] of Decimal;
    begin

        // Headers
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Item No.', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Description', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Before', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('0-30 Days', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('31-60 Days', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('61-90 Days', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('After', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

        // Data
        Item.SetRange(Blocked, false);
        if Item.FindSet() then
            repeat
                for i := 1 to 5 do begin
                    InventoryQuantity[i] := 0;
                    ItemLedgerEntry.SetRange("Item No.", Item."No.");

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
                            ItemLedgerEntry.SetFilter("Posting Date", '%1..', CalcDate('91D', WorkDate()));
                    end;

                    ItemLedgerEntry.CalcSums("Remaining Quantity");
                    InventoryQuantity[i] := ItemLedgerEntry."Remaining Quantity";
                end;

                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(Item."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Item.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                for i := 1 to 5 do
                    TempExcelBuffer.AddColumn(InventoryQuantity[i], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);

                TempExcelBuffer.AddColumn(InventoryQuantity[1] + InventoryQuantity[2] + InventoryQuantity[3] + InventoryQuantity[4] + InventoryQuantity[5], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);

            until Item.Next() = 0;
        TempExcelBuffer.CreateNewBook('Quantity Aging');
        TempExcelBuffer.SelectOrAddSheet('Quantity Aging');
        TempExcelBuffer.WriteSheet('Quantity Aging', CompanyName, UserId);
        TempExcelBuffer.DeleteAll();
    end;

    local procedure BuildItemAgingValueSheet()
    var
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        i: Integer;
        InventoryValue: array[5] of Decimal;
        TotalUnitCost: Decimal;
        TotalQuantity: Decimal;
    begin
        //TempExcelBuffer.SelectOrAddSheet('Value Aging');
        //TempExcelBuffer.WriteSheet('Value Aging', CompanyName, UserId);
        // Headers
        // TempExcelBuffer.SelectOrAddSheet('Value Aging');
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Item No.', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Description', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Before', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('0-30 Days', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('31-60 Days', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('61-90 Days', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('After', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

        Item.SetRange(Blocked, false);
        if Item.FindSet() then
            repeat
                for i := 1 to 5 do begin
                    InventoryValue[i] := 0;
                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Item No.", Item."No.");

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
                            ItemLedgerEntry.SetFilter("Posting Date", '%1..', CalcDate('91D', WorkDate()));
                    end;

                    TotalUnitCost := 0;
                    if ItemLedgerEntry.FindSet() then
                        repeat
                            ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                            if ValueEntry.FindSet() then
                                repeat
                                    TotalUnitCost += ValueEntry."Cost Amount (Actual)";
                                until ValueEntry.Next() = 0;
                        until ItemLedgerEntry.Next() = 0;

                    InventoryValue[i] := TotalUnitCost;
                end;

                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(Item."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Item.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                for i := 1 to 5 do
                    TempExcelBuffer.AddColumn(InventoryValue[i], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);

                TempExcelBuffer.AddColumn(InventoryValue[1] + InventoryValue[2] + InventoryValue[3] + InventoryValue[4] + InventoryValue[5], false, '', false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);

            until Item.Next() = 0;
        // TempExcelBuffer.CreateNewBook('Value Aging');

        TempExcelBuffer.SelectOrAddSheet('Value Aging');
        TempExcelBuffer.WriteSheet('Value Aging', CompanyName, UserId);
        TempExcelBuffer.DeleteAll();
        // TempExcelBuffer.DeleteAll();
    end;

    [ServiceEnabled]
    procedure RegisterWarehousePutAwayDocumentWise(UserEmail: Text[250]; DocumentNo: Code[20]): Text
    var
        WarehouseActivityLine: Record "Warehouse Activity Line";
        WarehouseEmployee: Record "Warehouse Employee";
        WarehouseActivityHeader: Record "Warehouse Activity Header";
        WhseActivityRegister: Codeunit "Whse.-Activity-Register";
        User: Record User;
        OutputValue: Label 'Warehouse put away for %1 has been sucessfully completed.';
        Text001: Label 'Missing warehouse employee %1';
        Text002: Label 'Missing warehouse put away document %1';
    begin
        User.SetRange("Authentication Email", UserEmail);
        if User.FindFirst() then begin
            WarehouseActivityHeader.SetRange("Assigned User ID", User."User Name");
            WarehouseActivityHeader.SetRange("No.", DocumentNo);
            if WarehouseActivityHeader.FindFirst() then begin
                WarehouseEmployee.SetRange("Location Code", WarehouseActivityHeader."Location Code");
                WarehouseEmployee.SetRange("User ID", WarehouseActivityHeader."Assigned User ID");
                if WarehouseEmployee.FindFirst() then begin
                    WarehouseActivityLine.SetRange("Activity Type", WarehouseActivityLine."Activity Type"::"Put-away");
                    WarehouseActivityLine.SetRange("No.", DocumentNo);
                    if WarehouseActivityLine.FindSet() then begin
                        repeat
                            if CheckBalanceQtyToHandle(WarehouseActivityLine) then begin
                                WhseActivityRegister.Run(WarehouseActivityLine);
                                exit(OutputValue);
                            end;
                        until WarehouseActivityLine.Next() = 0;
                    end;
                end
                else
                    exit(Text001);
            end
            else
                exit(Text002);
        end
        else
            exit('User does not exist');
    end;

    [ServiceEnabled]
    procedure RegisterWarehousePutAwayItemNo(UserID: Text[250]; ItemNo: Code[20]): Text
    var
        WarehouseActivityLine: Record "Warehouse Activity Line";
        WarehouseEmployee: Record "Warehouse Employee";
        WarehouseActivityHeader: Record "Warehouse Activity Header";
        WhseActivityRegister: Codeunit "Whse.-Activity-Register";
        User: Record User;
        OutputValue: Label 'Warehouse put away for %1 by User %2 has been sucessfully completed.';
    begin
        User.SetRange("Authentication Email", UserID);
        if User.FindFirst() then begin
            WarehouseEmployee.SetRange("User ID", User."User Name");
            if WarehouseEmployee.FindSet() then begin
                repeat
                    WarehouseActivityHeader.SetRange(Type, WarehouseActivityHeader.Type::"Put-away");
                    WarehouseActivityHeader.SetRange("Assigned User ID", WarehouseEmployee."User ID");
                    WarehouseActivityHeader.SetRange("Location Code", WarehouseEmployee."Location Code");
                    if WarehouseActivityHeader.FindSet() then begin
                        repeat
                            WarehouseActivityLine.SetRange("Item No.", ItemNo);
                            WarehouseActivityLine.SetRange("Activity Type", WarehouseActivityLine."Activity Type"::"Put-away");
                            WarehouseActivityLine.SetRange("No.", WarehouseActivityHeader."No.");
                            if WarehouseActivityLine.FindSet() then begin
                                repeat
                                    if CheckBalanceQtyToHandle1(WarehouseActivityLine) then begin
                                        WhseActivityRegister.Run(WarehouseActivityLine);
                                        exit(StrSubstNo(OutputValue, ItemNo, UserID));
                                    end;
                                until WarehouseActivityLine.Next() = 0;
                            end
                            else
                                exit('Warehouse activity Line does not exist');
                        until WarehouseActivityHeader.Next() = 0;
                    end
                    else
                        exit('Warehouse activity Header does not exist');
                until WarehouseEmployee.Next() = 0;
            end
            else
                exit('Warehouse employee does not exist');
        end
        else
            exit('user does not exist');
    end;

    local procedure CheckBalanceQtyToHandle(var WarehouseActivityLine2: Record "Warehouse Activity Line"): Boolean
    var
        WarehouseActivityLine: Record "Warehouse Activity Line";
        WarehouseActivityLine3: Record "Warehouse Activity Line";
        TempWarehouseActivityLine: Record "Warehouse Activity Line" temporary;
        QtyToPick: Decimal;
        QtyToPutAway: Decimal;
        OutputValue: Boolean;
    begin
        OutPutValue := false;
        WarehouseActivityLine.Copy(WarehouseActivityLine2);

        WarehouseActivityLine.SetCurrentKey("Activity Type", "No.", "Item No.", "Variant Code", "Action Type");
        WarehouseActivityLine.SetRange("Activity Type", WarehouseActivityLine."Activity Type");
        WarehouseActivityLine.SetRange("No.", WarehouseActivityLine."No.");
        WarehouseActivityLine.SetRange("Action Type");
        if WarehouseActivityLine.FindSet() then
            repeat
                if not TempWarehouseActivityLine.Get(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.", WarehouseActivityLine."Line No.") then begin
                    WarehouseActivityLine3.Copy(WarehouseActivityLine);
                    WarehouseActivityLine3.SetRange("Item No.", WarehouseActivityLine."Item No.");
                    WarehouseActivityLine3.SetRange("Variant Code", WarehouseActivityLine."Variant Code");
                    WarehouseActivityLine3.SetTrackingFilterFromWhseActivityLine(WarehouseActivityLine);

                    if (WarehouseActivityLine2."Action Type" = WarehouseActivityLine2."Action Type"::Take) or
                        (WarehouseActivityLine2.GetFilter("Action Type") = '')
                    then begin
                        WarehouseActivityLine3.SetRange("Action Type", WarehouseActivityLine3."Action Type"::Take);
                        if WarehouseActivityLine3.FindSet() then
                            repeat
                                QtyToPick := QtyToPick + WarehouseActivityLine3."Qty. to Handle (Base)";
                                TempWarehouseActivityLine := WarehouseActivityLine3;
                                TempWarehouseActivityLine.Insert();
                            until WarehouseActivityLine3.Next() = 0;
                    end;

                    if (WarehouseActivityLine2."Action Type" = WarehouseActivityLine2."Action Type"::Place) or
                        (WarehouseActivityLine2.GetFilter("Action Type") = '')
                    then begin
                        WarehouseActivityLine3.SetRange("Action Type", WarehouseActivityLine3."Action Type"::Place);
                        if WarehouseActivityLine3.FindSet() then
                            repeat
                                QtyToPutAway := QtyToPutAway + WarehouseActivityLine3."Qty. to Handle (Base)";
                                TempWarehouseActivityLine := WarehouseActivityLine3;
                                TempWarehouseActivityLine.Insert();
                            until WarehouseActivityLine3.Next() = 0;
                    end;

                    if QtyToPick = QtyToPutAway then
                        OutPutValue := true;

                    QtyToPick := 0;
                    QtyToPutAway := 0;
                end;
            until WarehouseActivityLine.Next() = 0;
        exit(OutPutValue)
    end;

    local procedure CheckBalanceQtyToHandle1(var WarehouseActivityLine2: Record "Warehouse Activity Line"): Boolean
    var
        WarehouseActivityLine: Record "Warehouse Activity Line";
        WarehouseActivityLine3: Record "Warehouse Activity Line";
        TempWarehouseActivityLine: Record "Warehouse Activity Line" temporary;
        QtyToPick: Decimal;
        QtyToPutAway: Decimal;
        OutputValue: Boolean;
    begin
        OutPutValue := false;
        WarehouseActivityLine.Copy(WarehouseActivityLine2);

        WarehouseActivityLine.SetCurrentKey("Activity Type", "No.", "Item No.", "Variant Code", "Action Type");
        WarehouseActivityLine.SetRange("Activity Type", WarehouseActivityLine."Activity Type");
        WarehouseActivityLine.SetRange("No.", WarehouseActivityLine."No.");
        WarehouseActivityLine.SetRange("Item No.", WarehouseActivityLine."Item No.");
        WarehouseActivityLine.SetRange("Action Type");
        if WarehouseActivityLine.FindSet() then
            repeat
                if not TempWarehouseActivityLine.Get(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.", WarehouseActivityLine."Line No.") then begin
                    WarehouseActivityLine3.Copy(WarehouseActivityLine);
                    WarehouseActivityLine3.SetRange("Item No.", WarehouseActivityLine."Item No.");
                    WarehouseActivityLine3.SetRange("Variant Code", WarehouseActivityLine."Variant Code");
                    WarehouseActivityLine3.SetTrackingFilterFromWhseActivityLine(WarehouseActivityLine);

                    if (WarehouseActivityLine2."Action Type" = WarehouseActivityLine2."Action Type"::Take) or
                        (WarehouseActivityLine2.GetFilter("Action Type") = '')
                    then begin
                        WarehouseActivityLine3.SetRange("Action Type", WarehouseActivityLine3."Action Type"::Take);
                        if WarehouseActivityLine3.FindSet() then
                            repeat
                                QtyToPick := QtyToPick + WarehouseActivityLine3."Qty. to Handle (Base)";
                                TempWarehouseActivityLine := WarehouseActivityLine3;
                                TempWarehouseActivityLine.Insert();
                            until WarehouseActivityLine3.Next() = 0;
                    end;

                    if (WarehouseActivityLine2."Action Type" = WarehouseActivityLine2."Action Type"::Place) or
                        (WarehouseActivityLine2.GetFilter("Action Type") = '')
                    then begin
                        WarehouseActivityLine3.SetRange("Action Type", WarehouseActivityLine3."Action Type"::Place);
                        if WarehouseActivityLine3.FindSet() then
                            repeat
                                QtyToPutAway := QtyToPutAway + WarehouseActivityLine3."Qty. to Handle (Base)";
                                TempWarehouseActivityLine := WarehouseActivityLine3;
                                TempWarehouseActivityLine.Insert();
                            until WarehouseActivityLine3.Next() = 0;
                    end;

                    if QtyToPick = QtyToPutAway then
                        OutPutValue := true;

                    QtyToPick := 0;
                    QtyToPutAway := 0;
                end;
            until WarehouseActivityLine.Next() = 0;
        exit(OutPutValue)
    end;


    var
        TotalUnitCost: Decimal;
        TotalQuantity: Decimal;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        InventoryQuantity: array[5] of Decimal;
        InventoryValue: array[5] of Decimal;
        TotalInventoryQuantity: array[5] of Decimal;
}
