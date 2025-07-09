page 50726 PostProductionOrderLinesAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'postProductionOrderLinesAPI';
    DelayedInsert = true;
    EntityName = 'PostProductionOrderLinesAPI';
    EntitySetName = 'PostProductionOrderLinesAPI';
    PageType = API;
    SourceTable = "Prod. Order Line";
    ODataKeyFields = systemId;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(costAmount; Rec."Cost Amount")
                {
                    Caption = 'Cost Amount';
                }
                field(costAmountACY; Rec."Cost Amount (ACY)")
                {
                    Caption = 'Cost Amount (ACY)';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(endingDate; Rec."Ending Date")
                {
                    Caption = 'Ending Date';
                }
                field(endingDateTime; Rec."Ending Date-Time")
                {
                    Caption = 'Ending Date-Time';
                }
                field(endingTime; Rec."Ending Time")
                {
                    Caption = 'Ending Time';
                }
                field(expectedComponentCostAmt; Rec."Expected Component Cost Amt.")
                {
                    Caption = 'Expected Component Cost Amt.';
                }
                field(expectedOperationCostAmt; Rec."Expected Operation Cost Amt.")
                {
                    Caption = 'Expected Operation Cost Amt.';
                }
                field(finishedQtyBase; Rec."Finished Qty. (Base)")
                {
                    Caption = 'Finished Qty. (Base)';
                }
                field(finishedQuantity; Rec."Finished Quantity")
                {
                    Caption = 'Finished Quantity';
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                    Caption = 'Indirect Cost %';
                }
                field(inventoryPostingGroup; Rec."Inventory Posting Group")
                {
                    Caption = 'Inventory Posting Group';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(mpsOrder; Rec."MPS Order")
                {
                    Caption = 'MPS Order';
                }
                field(manualScheduling; Rec."Manual Scheduling")
                {
                    Caption = 'Manual Scheduling';
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                    Caption = 'Overhead Rate';
                }
                field(planningFlexibility; Rec."Planning Flexibility")
                {
                    Caption = 'Planning Flexibility';
                }
                field(planningLevelCode; Rec."Planning Level Code")
                {
                    Caption = 'Planning Level Code';
                }
                field(priority; Rec.Priority)
                {
                    Caption = 'Priority';
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Prod. Order No.';
                }
                field(productionBOMNo; Rec."Production BOM No.")
                {
                    Caption = 'Production BOM No.';
                }
                field(productionBOMVersionCode; Rec."Production BOM Version Code")
                {
                    Caption = 'Production BOM Version Code';
                }
                field(putAwayQty; Rec."Put-away Qty.")
                {
                    Caption = 'Put-away Qty.';
                }
                field(putAwayQtyBase; Rec."Put-away Qty. (Base)")
                {
                    Caption = 'Put-away Qty. (Base)';
                }
                field(putAwayStatus; Rec."Put-away Status")
                {
                    Caption = 'Status';
                }
                field(qtyPutAway; Rec."Qty. Put Away")
                {
                    Caption = 'Qty. Put Away';
                }
                field(qtyPutAwayBase; Rec."Qty. Put Away (Base)")
                {
                    Caption = 'Qty. Put Away (Base)';
                }
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                    Caption = 'Qty. Rounding Precision';
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
                {
                    Caption = 'Qty. Rounding Precision (Base)';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)';
                }
                field(remainingQtyBase; Rec."Remaining Qty. (Base)")
                {
                    Caption = 'Remaining Qty. (Base)';
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                    Caption = 'Remaining Quantity';
                }
                field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                {
                    Caption = 'Reserved Qty. (Base)';
                }
                field(reservedQuantity; Rec."Reserved Quantity")
                {
                    Caption = 'Reserved Quantity';
                }
                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.';
                }
                field(routingReferenceNo; Rec."Routing Reference No.")
                {
                    Caption = 'Routing Reference No.';
                }
                field(routingType; Rec."Routing Type")
                {
                    Caption = 'Routing Type';
                }
                field(routingVersionCode; Rec."Routing Version Code")
                {
                    Caption = 'Routing Version Code';
                }
                field(scrap; Rec."Scrap %")
                {
                    Caption = 'Scrap %';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(standardTaskCode; Rec."Standard Task Code")
                {
                    Caption = 'Standard Task Code';
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                }
                field(startingDateTime; Rec."Starting Date-Time")
                {
                    Caption = 'Starting Date-Time';
                }
                field(startingTime; Rec."Starting Time")
                {
                    Caption = 'Starting Time';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(totalExpOperOutputQty; Rec."Total Exp. Oper. Output (Qty.)")
                {
                    Caption = 'Total Exp. Oper. Output (Qty.)';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(unitCostACY; Rec."Unit Cost (ACY)")
                {
                    Caption = 'Unit Cost (ACY)';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
            }
        }
    }

    [ServiceEnabled]
    procedure PostConsumptionJournals(): Text
    var
        productionorderRec: Record "Production Order";
        ProductionJrnlMgt: Codeunit "Production JournalMgt Modified";
    begin
        SetTemplateandBatchName();
        ProductionJrnlMgt.DeleteJnlLines(ToTemplateName, ToBatchName, Rec."Prod. Order No.", Rec."Line No.");
        if productionorderRec.Get(Rec.Status, Rec."Prod. Order No.") then;
        productionorderRec.Isconsumption := true;
        productionorderRec.IsOutput := false;
        productionorderRec.Modify(true);
        ShowProductionJournal();

        //posting output
        if PostItemJrnlLines() then
            exit('posted consumption for %1 ' + Rec."Prod. Order No.")
        else
            exit(GetLastErrorText());
    end;

    [ServiceEnabled]
    procedure PostOutputJournals(): Text
    var
        productionorderRec: Record "Production Order";
        ProductionJrnlMgt: Codeunit "Production JournalMgt Modified";
    begin
        SetTemplateandBatchName();
        ProductionJrnlMgt.DeleteJnlLines(ToTemplateName, ToBatchName, Rec."Prod. Order No.", Rec."Line No.");
        if productionorderRec.Get(Rec.Status, Rec."Prod. Order No.") then;
        productionorderRec.Isconsumption := false;
        productionorderRec.IsOutput := true;
        productionorderRec.Modify(true);
        ShowProductionJournal();

        //posting output
        if PostItemJrnlLines() then
            exit('posted Output for %1 ' + Rec."Prod. Order No.")
        else
            exit(GetLastErrorText());
    end;

    [TryFunction]
    procedure PostItemJrnlLines()
    var
        productionorderRec: Record "Production Order";
        ItemJournalLine: Record "Item Journal Line";
        ProductionJrnlMgt: Codeunit "Production JournalMgt Modified";
    begin

        ItemJournalLine.SetRange("Document No.", Rec."Prod. Order No.");
        ItemJournalLine.SetRange("Source No.", rec."Item No.");
        ItemJournalLine.SetRange("Journal Template Name", ToTemplateName);
        ItemJournalLine.SetRange("Journal Batch Name", ToBatchName);
        productionorderRec.Get(Rec.Status, Rec."Prod. Order No.");
        if productionorderRec.Isconsumption then
            ItemJournalLine.SetRange("Entry Type", ItemJournalLine."Entry Type"::Consumption)
        else if productionorderRec.IsOutput then
            ItemJournalLine.SetRange("Entry Type", ItemJournalLine."Entry Type"::Output);
        if ItemJournalLine.FindFirst() then
            PostingItemJnlFromProduction(false, ItemJournalLine);
        //setup(ItemJournalLine);
        InsertTempRec();
        //SetTemplateandBatchName();
        SetFilterGroup();
        CurrPage.Update(false);

        ProductionJrnlMgt.DeleteJnlLines(ToTemplateName, ToBatchName, Rec."Prod. Order No.", Rec."Line No.");
    end;

    procedure InsertTempRec()
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        if TempItemJnlLine.Find('-') then
            repeat
                ItemJournalLine := TempItemJnlLine;
                ItemJournalLine."Changed by User" := false;
                ItemJournalLine.Insert();
            until TempItemJnlLine.Next() = 0;
        TempItemJnlLine.DeleteAll();
    end;

    local procedure ShowProductionJournal()
    var
        ProdOrder: Record "Production Order";
        ProductionJrnlMgt: Codeunit "Production JournalMgt Modified";
    begin
        CurrPage.SaveRecord();

        ProdOrder.Get(Rec.Status, Rec."Prod. Order No.");

        Clear(ProductionJrnlMgt);
        ProductionJrnlMgt.Handling(ProdOrder, Rec."Line No.");
    end;

    procedure setup(ItemJournalLine: Record "Item Journal Line")
    begin
        ToBatchName := ItemJournalLine."Journal Batch Name";
        ToTemplateName := ItemJournalLine."Journal Template Name";
    end;

    procedure SetFlushingFilter()
    var
        itemJournalLine: Record "Item Journal Line";
    begin
        case FlushingFilter of
            FlushingFilter::"All Methods":
                itemJournalLine.SetRange("Flushing Method");
            FlushingFilter::"Manual Methods":
                //itemJournalLine.SetFilter("Flushing Method", '%1|%2', "Flushing Method"::Manual, "Flushing Method"::"Pick + Manual");
                itemJournalLine.SetRange("Flushing Method", "Flushing Method"::"Pick + Manual");
            else
                itemJournalLine.SetRange("Flushing Method", FlushingFilter);
        end;
    end;

    procedure SetFilterGroup()
    var
        itemJournalLine: Record "Item Journal Line";

    begin
        itemJournalLine.FilterGroup(2);
        itemJournalLine.SetRange("Journal Template Name", ToTemplateName);
        itemJournalLine.SetRange("Journal Batch Name", ToBatchName);
        itemJournalLine.SetRange("Order Type", itemJournalLine."Order Type"::Production);
        itemJournalLine.SetRange("Order No.", Rec."Prod. Order No.");
        if ProdOrderLineNo <> 0 then
            itemJournalLine.SetRange("Order Line No.", Rec."Line No.");
        SetFlushingFilter();
        //OnAfterSetFilterGroup(Rec, ProdOrder, ProdOrderLineNo);
        Rec.FilterGroup(0);
    end;

    procedure PostingItemJnlFromProduction(Print: Boolean; ItemJournalLine: Record "Item Journal Line")
    var
        ProductionOrder: Record "Production Order";
        IsHandled: Boolean;
    begin
        if (ItemJournalLine."Order Type" = ItemJournalLine."Order Type"::Production) and (ItemJournalLine."Order No." <> '') then
            ProductionOrder.Get(ProductionOrder.Status::Released, ItemJournalLine."Order No.");

        IsHandled := false;
        //OnBeforePostingItemJnlFromProduction(Rec, Print, IsHandled);
        if IsHandled then
            exit;

        if Print then
            CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post+Print", ItemJournalLine)
        else
            CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post modified", ItemJournalLine);
    end;

    procedure SetTemplateandBatchName()
    var
        itemjournalLine2: Record "Item Journal Line";
    begin
        itemjournalLine2.SetRange("Document No.", Rec."Prod. Order No.");
        itemjournalLine2.SetRange("Source No.", rec."Item No.");
        if itemjournalLine2.FindFirst() then begin
            ToTemplateName := itemjournalLine2."Journal Template Name";
            ToBatchName := itemjournalLine2."Journal Batch Name";
        end;
    end;

    var
        ItemJnlTemplate: Record "Item Journal Template";
        TempItemJnlLine: Record "Item Journal Line" temporary;
        ToTemplateName: Code[10];
        ToBatchName: Code[10];
        ProdOrder: Record "Production Order";
        ProdOrderLineNo: Integer;
        PostingDate: Date;
        xPostingDate: Date;
        FlushingFilter: Enum "Flushing Method Filter";
        Text003: Label 'DEFAULT';
        Text004: Label 'Production Journal';
        Text000: Label '%1 journal';
        ItemJnlBatch: Record "Item Journal Batch";
}
