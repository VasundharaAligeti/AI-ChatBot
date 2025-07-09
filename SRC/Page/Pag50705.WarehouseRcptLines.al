page 50705 WarehouseRcptLines
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'warehouseRcptLines';
    DelayedInsert = true;
    EntityName = 'WarehouseRcptLines';
    EntitySetName = 'WarehouseRcptLines';
    PageType = API;
    SourceTable = "Warehouse Receipt Line";

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
                field(crossDockBinCode; Rec."Cross-Dock Bin Code")
                {
                    Caption = 'Cross-Dock Bin Code';
                }
                field(crossDockZoneCode; Rec."Cross-Dock Zone Code")
                {
                    Caption = 'Cross-Dock Zone Code';
                }
                field(cubage; Rec.Cubage)
                {
                    Caption = 'Cubage';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
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
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(notUpdBySrcDocPost; Rec."Not upd. by Src. Doc. Post.")
                {
                    Caption = 'Not upd. by Src. Doc. Post.';
                }
                field(overReceiptCode; Rec."Over-Receipt Code")
                {
                    Caption = 'Over-Receipt Code';
                }
                field(overReceiptQuantity; Rec."Over-Receipt Quantity")
                {
                    Caption = 'Over-Receipt Quantity';
                }
                field(postingFromWhseRef; Rec."Posting from Whse. Ref.")
                {
                    Caption = 'Posting from Whse. Ref.';
                }
                field(qtyBase; Rec."Qty. (Base)")
                {
                    Caption = 'Qty. (Base)';
                }
                field(qtyOutstanding; Rec."Qty. Outstanding")
                {
                    Caption = 'Qty. Outstanding';
                }
                field(qtyOutstandingBase; Rec."Qty. Outstanding (Base)")
                {
                    Caption = 'Qty. Outstanding (Base)';
                }
                field(qtyReceived; Rec."Qty. Received")
                {
                    Caption = 'Qty. Received';
                }
                field(qtyReceivedBase; Rec."Qty. Received (Base)")
                {
                    Caption = 'Qty. Received (Base)';
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
                field(qtyToCrossDock; Rec."Qty. to Cross-Dock")
                {
                    Caption = 'Qty. to Cross-Dock';
                }
                field(qtyToCrossDockBase; Rec."Qty. to Cross-Dock (Base)")
                {
                    Caption = 'Qty. to Cross-Dock (Base)';
                }
                field(qtyToReceive; Rec."Qty. to Receive")
                {
                    Caption = 'Qty. to Receive';
                }
                field(qtyToReceiveBase; Rec."Qty. to Receive (Base)")
                {
                    Caption = 'Qty. to Receive (Base)';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(shelfNo; Rec."Shelf No.")
                {
                    Caption = 'Shelf No.';
                }
                field(sortingSequenceNo; Rec."Sorting Sequence No.")
                {
                    Caption = 'Sorting Sequence No.';
                }
                field(sourceDocument; Rec."Source Document")
                {
                    Caption = 'Source Document';
                }
                field(sourceLineNo; Rec."Source Line No.")
                {
                    Caption = 'Source Line No.';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }
                field(sourceSubtype; Rec."Source Subtype")
                {
                    Caption = 'Source Subtype';
                }
                field(sourceType; Rec."Source Type")
                {
                    Caption = 'Source Type';
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
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
                field(zoneCode; Rec."Zone Code")
                {
                    Caption = 'Zone Code';
                }
            }
        }
    }
}
