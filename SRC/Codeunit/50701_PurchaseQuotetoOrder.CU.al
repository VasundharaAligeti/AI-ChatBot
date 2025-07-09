
codeunit 50701 "Purch QuotetoOrder customized"
{
    TableNo = "Purchase Header";

    trigger OnRun()
    var
        ConfirmManagement: Codeunit "Confirm Management";
        IsHandled: Boolean;
    begin
        Rec.TestField("Document Type", Rec."Document Type"::Quote);

        IsHandled := false;
        OnBeforePurchQuoteToOrder(Rec, IsHandled);
        if IsHandled then
            exit;

        PurchQuoteToOrder.Run(Rec);
        PurchQuoteToOrder.GetPurchOrderHeader(PurchOrderHeader);

        IsHandled := false;
        OnAfterCreatePurchOrder(PurchOrderHeader, IsHandled);

    end;

    var
        ConvertQuoteToOrderQst: Label 'Do you want to convert the quote to an order?';
        PurchOrderHeader: Record "Purchase Header";
        PurchQuoteToOrder: Codeunit "Purch.-Quote to Order";
        OpenNewOrderQst: Label 'The quote has been converted to order number %1. Do you want to open the new order?', Comment = '%1 - No. of new purchase order.';

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreatePurchOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePurchQuoteToOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;
}

