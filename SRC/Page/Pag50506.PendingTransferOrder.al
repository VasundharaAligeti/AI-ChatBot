page 50506 PendingTransferOrder
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'pendingTransferOrder';
    DelayedInsert = true;
    EntityName = 'PendingTransferOrder';
    EntitySetName = 'PendingTransferOrder';
    PageType = API;
    SourceTable = "Transfer Header";

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
                field(transferFromCode; Rec."Transfer-from Code")
                {
                    Caption = 'Transfer-from Code';
                }
                field(transferFromName; Rec."Transfer-from Name")
                {
                    Caption = 'Transfer-from Name';
                }
                field(transferToCode; Rec."Transfer-to Code")
                {
                    Caption = 'Transfer-to Code';
                }
                field(transferToName; Rec."Transfer-to Name")
                {
                    Caption = 'Transfer-to Name';
                }
                field(quantity; GetTransferOrderAmount())
                {
                    Caption = 'Quantity';
                }
            }
        }
    }
    procedure GetTransferOrderAmount(): Decimal
    var
        TransferLine: Record "Transfer Line";
        Value: Decimal;
    begin
        Value := 0;
        TransferLine.SetRange("Document No.", Rec."No.");

        TransferLine.CalcSums(Quantity);
        Value := TransferLine.Quantity;
        exit(Value);
    end;

    [ServiceEnabled]
    procedure CheckTransferHeader(): Text
    var
        InventorySetup: Record "Inventory Setup";
        TransferLine: Record "Transfer Line";
        TransferOrderPostReceipt: Codeunit "TransferOrder-Post Receipt";
        TransferOrderpostShipment: Codeunit "TransferOrder-Post Shipment";
    begin
        InventorySetup.Get();

        if Rec."Direct Transfer" and (InventorySetup."Direct Transfer Posting" = InventorySetup."Direct Transfer Posting"::"Receipt and Shipment") then begin
            TransferLine.SetRange("Document No.", Rec."No.");
            TransferLine.SetLoadFields("Qty. to Ship", "Qty. to Receive", "Qty. to Ship (Base)", "Qty. to Receive (Base)");
            if TransferLine.FindSet() then
                repeat
                    // For 'Direct Transfer', "Qty. to Ship" and "Qty. to Receive" should be the same.
                    if TransferLine."Qty. to Receive" <> TransferLine."Qty. to Ship" then
                        Error(ShipReceiveNotEqualErr);
                    if TransferLine."Qty. to Receive (Base)" <> TransferLine."Qty. to Ship (Base)" then
                        Error(ShipReceiveNotEqualErr);
                until TransferLine.Next() = 0;
        end;
        // TransferOrderPostReceipt.SetHideValidationDialog(true);
        // TransferOrderPostReceipt.SetPreviewMode(false);
        // TransferOrderPostReceipt.Run(Rec);
        TransferOrderpostShipment.SetHideValidationDialog(true);
        TransferOrderpostShipment.SetPreviewMode(false);
        TransferOrderpostShipment.Run(Rec);
    end;

    var
        ShipReceiveNotEqualErr: Label 'The quantity to ship and quantity to receive must be equal in a direct transfer.';
}
