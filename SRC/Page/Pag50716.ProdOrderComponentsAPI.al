page 50716 ProdOrderComponentsAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'prodOrderComponentsAPI';
    DelayedInsert = true;
    EntityName = 'ProdOrderComponentsAPI';
    EntitySetName = 'ProdOrderComponentsAPI';
    PageType = API;
    SourceTable = "Prod. Order Component";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(actConsumptionQty; Rec."Act. Consumption (Qty)")
                {
                    Caption = 'Act. Consumption (Qty)';
                }
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(calculationFormula; Rec."Calculation Formula")
                {
                    Caption = 'Calculation Formula';
                }
                field(completelyPicked; Rec."Completely Picked")
                {
                    Caption = 'Completely Picked';
                }
                field(costAmount; Rec."Cost Amount")
                {
                    Caption = 'Cost Amount';
                }
                field(depth; Rec.Depth)
                {
                    Caption = 'Depth';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(directCostAmount; Rec."Direct Cost Amount")
                {
                    Caption = 'Direct Cost Amount';
                }
                field(directUnitCost; Rec."Direct Unit Cost")
                {
                    Caption = 'Direct Unit Cost';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(dueDateTime; Rec."Due Date-Time")
                {
                    Caption = 'Due Date-Time';
                }
                field(dueTime; Rec."Due Time")
                {
                    Caption = 'Due Time';
                }
                field(expectedQtyBase; Rec."Expected Qty. (Base)")
                {
                    Caption = 'Expected Qty. (Base)';
                }
                field(expectedQuantity; Rec."Expected Quantity")
                {
                    Caption = 'Expected Quantity';
                }
                field(flushingMethod; Rec."Flushing Method")
                {
                    Caption = 'Flushing Method';
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                    Caption = 'Indirect Cost %';
                }
                field(itemLowLevelCode; Rec."Item Low-Level Code")
                {
                    Caption = 'Item Low-Level Code';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(leadTimeOffset; Rec."Lead-Time Offset")
                {
                    Caption = 'Lead-Time Offset';
                }
                field(length; Rec.Length)
                {
                    Caption = 'Length';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(originalItemNo; Rec."Original Item No.")
                {
                    Caption = 'Original Item No.';
                }
                field(originalVariantCode; Rec."Original Variant Code")
                {
                    Caption = 'Original Variant Code';
                }
                field(overheadAmount; Rec."Overhead Amount")
                {
                    Caption = 'Overhead Amount';
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                    Caption = 'Overhead Rate';
                }
                field(pickQty; Rec."Pick Qty.")
                {
                    Caption = 'Pick Qty.';
                }
                field(pickQtyBase; Rec."Pick Qty. (Base)")
                {
                    Caption = 'Pick Qty. (Base)';
                }
                field(planningLevelCode; Rec."Planning Level Code")
                {
                    Caption = 'Planning Level Code';
                }
                field(position; Rec.Position)
                {
                    Caption = 'Position';
                }
                field(position2; Rec."Position 2")
                {
                    Caption = 'Position 2';
                }
                field(position3; Rec."Position 3")
                {
                    Caption = 'Position 3';
                }
                field(prodOrderLineNo; Rec."Prod. Order Line No.")
                {
                    Caption = 'Prod. Order Line No.';
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Prod. Order No.';
                }
                field(qtyPicked; Rec."Qty. Picked")
                {
                    Caption = 'Qty. Picked';
                }
                field(qtyPickedBase; Rec."Qty. Picked (Base)")
                {
                    Caption = 'Qty. Picked (Base)';
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
                field(quantityPer; Rec."Quantity per")
                {
                    Caption = 'Quantity per';
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
                field(routingLinkCode; Rec."Routing Link Code")
                {
                    Caption = 'Routing Link Code';
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
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(substitutionAvailable; Rec."Substitution Available")
                {
                    Caption = 'Substitution Available';
                }
                field(suppliedByLineNo; Rec."Supplied-by Line No.")
                {
                    Caption = 'Supplied-by Line No.';
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
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(weight; Rec.Weight)
                {
                    Caption = 'Weight';
                }
                field(width; Rec.Width)
                {
                    Caption = 'Width';
                }
            }
        }
    }
}
