page 50611 Salesheaderapi
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'salesheaderapi';
    DelayedInsert = true;
    EntityName = 'Salesheaderapi';
    EntitySetName = 'Salesheaderapi';
    PageType = API;
    SourceTable = "Sales Header";
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
                field("CustomerName"; Rec."Sell-to Customer Name") { }
                field("OrderDate"; Rec."Order Date") { }
                field("PromisedDeliveryDate"; Rec."Promised Delivery Date") { }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(number; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(AmountIncludingVAT; Rec."Amount Including VAT") { }
                field(ReportOutput; ReportOutput)
                {
                    Caption = 'Report Output';
                    ToolTip = 'Base64 encoded PDF of the report.';
                }
                field(WebUrl; WebUrl)
                {
                    Caption = 'Web URL';
                    ToolTip = 'URL to view the sales order or quote in the web client.';
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
        SalesHeader: Record "Sales Header";
    begin
        ReportOutput := '';
        TempBlob.CreateOutStream(OutStream);
        SalesHeader.SetRange(SystemId, Rec.SystemId);
        if SalesHeader.FindFirst() then
            RecordVariant := SalesHeader;
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            Report.SaveAs(Report::"Standard Sales - Order Conf.", '', ReportFormat::Pdf, OutStream, GetRecRef(RecordVariant));
            TempBlob.CreateInStream(InStream);
            ReportOutput := Base64.ToBase64(InStream);
            WebURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Sales Order", Rec, false);
        end;
        if Rec."Document Type" = Rec."Document Type"::Quote then begin
            Report.SaveAs(Report::"Sales Quote NA", '', ReportFormat::Pdf, OutStream, GetRecRef(RecordVariant));
            TempBlob.CreateInStream(InStream);
            ReportOutput := Base64.ToBase64(InStream);
            WebURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Sales Quote", Rec, false);
        end;

    end;

    [ServiceEnabled]
    procedure ConvertToSalesOrder(QuoteNo: Code[20]): Text
    begin
        if not ConvertToSalesOrderusingErrorHandling(QuoteNo) then
            exit(GetLastErrorText)
        else
            exit('');
    end;

    [TryFunction]
    procedure ConvertToSalesOrderusingErrorHandling(QuoteNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("No.", QuoteNo);
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Quote);
        SalesHeader.FindFirst();
        CODEUNIT.Run(CODEUNIT::"Sales-Quote to Order", SalesHeader);
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
