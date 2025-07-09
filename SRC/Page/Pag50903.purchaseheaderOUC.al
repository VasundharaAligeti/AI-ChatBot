page 50903 purchaseheaderOUC
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'purchaseheaderOUC';
    DelayedInsert = true;
    EntityName = 'purchaseheaderOUC';
    EntitySetName = 'purchaseheaderOUC';
    PageType = API;
    SourceTable = "Purchase Header";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field("BuyfromVendorName"; Rec."Buy-from Vendor Name")
                {
                    Caption = 'Buy-from Vendor Name';
                }
                field("OrderDate"; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field("AmountIncludingVAT"; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                    ToolTip = 'Total amount including VAT.';
                }
                field("ExpectedReceiptDate"; Rec."Expected Receipt Date")
                {
                    Caption = 'Expected Receipt Date';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(ReportOutput; ReportOutput)
                {
                    Caption = 'Report Output';
                    ToolTip = 'Base64 encoded PDF of the report.';
                }
                field(WebUrl; WebUrl)
                {
                    Caption = 'Web URL';
                    ToolTip = 'URL to view the purchase order or quote in the web client.';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        Base64: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        InStream: InStream;
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        RecordVariant: Variant;
        PurchaseHeader: Record "Purchase Header";
    begin
        ReportOutput := '';
        TempBlob.CreateOutStream(OutStream);
        PurchaseHeader.SetRange(SystemId, Rec.SystemId);
        if PurchaseHeader.FindFirst() then
            RecordVariant := PurchaseHeader;
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            Report.SaveAs(Report::"Standard Purchase - Order", '', ReportFormat::Pdf, OutStream, GetRecRef(RecordVariant));
            TempBlob.CreateInStream(InStream);
            ReportOutput := Base64.ToBase64(InStream);
            WebURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Purchase Order", Rec, false);
        end;
        // if Rec."Document Type" = Rec."Document Type"::Quote then begin
        //     Report.SaveAs(Report::"Sales Quote NA", '', ReportFormat::Pdf, OutStream, GetRecRef(RecordVariant));
        //     TempBlob.CreateInStream(InStream);
        //     ReportOutput := Base64.ToBase64(InStream);
        //     WebURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Purchase Quote", Rec, false);
        // end;

    end;


    local procedure GetRecRef(RecVariant: Variant) RecRef: RecordRef
    begin
        if RecVariant.IsRecordRef() then
            exit(RecVariant);
        if RecVariant.IsRecord() then
            RecRef.GetTable(RecVariant);
    end;

    var

        ReportOutput: Text;
        WebUrl: Text;
}
