codeunit 50700 ProcessLogic
{
    // [EventSubscriber(ObjectType::Page, page::"Sales Order Subform", OnAfterValidateEvent, "No.", true, true)]
    // local procedure MyProcedure(var rec: Record "Sales Line")
    // var
    //     itemrec: Record Item;
    //     salesline_rec: Record "Sales Line";
    //     salesheader_rec: Record "Sales Header";
    // begin
    //     itemrec.SetRange("No.", rec."No.");
    //     if itemrec.FindFirst() then begin
    //         salesheader_rec.SetRange("No.", rec."Document No.");
    //         if salesheader_rec.FindFirst() then begin
    //             salesheader_rec.Remarks := itemrec.Remarks;
    //             salesheader_rec.Modify();
    //         end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", OnAfterCopySellToCustomerAddressFieldsFromCustomer, '', true, true)]
    local procedure MyProcedure(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer)
    var
        customer_rec: Record Customer;
        salesheader_rec: Record "Sales Header";
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SellToCustomer.SetRange("No.", SalesHeader."Sell-to Customer No.");
        if SellToCustomer.FindFirst() then begin
            // SalesHeader.Remarks := customer_rec.Remarks;
            // SalesHeader.Modify();
        end;
    end;
    //sumit ++ 21-06-2025
    // [EventSubscriber(ObjectType::Table, Database::"Document Sending Profile", OnBeforeTrySendToEMail, '', false, false)]
    // local procedure "Document Sending Profile_OnBeforeTrySendToEMail"(ReportUsage: Integer; RecordVariant: Variant; DocumentNoFieldNo: Integer; DocName: Text[150]; CustomerFieldNo: Integer; var ShowDialog: Boolean; var Handled: Boolean; var IsCustomer: Boolean)
    // begin
    //     ShowDialog := false; // Show the dialog
    // end;

    // [ServiceEnabled]
    // procedure GenerateCustomerItemSalesReport(CustomerNo: Code[20]): Text
    // var
    //     Customer: Record Customer;
    //     TempBlob: Codeunit "Temp Blob";
    //     OutputStream: OutStream;
    //     InputStream: InStream;
    //     ReportParameters: JsonObject;
    //     JsonObject: JsonObject;
    // begin
    //     Report.RunModal(113);
    // end;




    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCopyBuyFromVendorAddressFieldsFromVendor', '', true, true)]
    local procedure OnAfterCopyBuyFromVendorAddressFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; BuyFromVendor: Record Vendor)
    var
    begin
        BuyFromVendor.SetRange("No.", PurchaseHeader."Buy-from Vendor No.");
        if BuyFromVendor.FindFirst() then begin
            // PurchaseHeader.Remarks := BuyFromVendor.Remarks;
        end;
    end;

    var
        myInt: Integer;
}