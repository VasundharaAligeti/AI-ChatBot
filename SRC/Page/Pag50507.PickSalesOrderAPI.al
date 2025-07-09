page 50507 "PickSalesOrderAPI"
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'pickListSalesOrder';
    DelayedInsert = true;
    EntityName = 'PickListSalesOrder';
    EntitySetName = 'PickListSalesOrder';
    PageType = API;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Order));

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
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(sellToCustomerName; Rec."Sell-to Customer Name")
                {
                    Caption = 'Sell-to Customer Name';
                }
            }
        }
    }
    [ServiceEnabled]
    procedure RunPickListReport(): Text
    var
        OutStream: OutStream;
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        Item: Record Item;
        InStream: InStream;
        LargeText: Text;
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("No.", Rec."No.");
        if SalesHeader.FindFirst() then;
        RecRef.GetTable(SalesHeader);
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(10153, '', ReportFormat::Pdf, OutStream, RecRef);
        TempBlob.CreateInStream(InStream);
        LargeText := Base64Convert.ToBase64(InStream, false);
        exit(LargeText);

    end;
}
