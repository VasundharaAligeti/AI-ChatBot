page 50510 InventoryCustomerAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'inventoryCustomerAPI';
    DelayedInsert = true;
    EntityName = 'InventoryCustomerAPI';
    EntitySetName = 'InventoryCustomerAPI';
    PageType = API;
    SourceTable = Customer;
    SourceTableView = where(Blocked = const(" "));

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
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
            }
        }
    }
    [ServiceEnabled]
    procedure RunItemDetailsReportCustomer(): Text
    var
        OutStream: OutStream;
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        Item: Record Item;
        InStream: InStream;
        LargeText: Text;
        Customer: Record Customer;
    begin
        Customer.SetRange("No.", Rec."No.");
        if Customer.FindFirst() then;
        RecRef.GetTable(Customer);
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(113, '', ReportFormat::Pdf, OutStream, RecRef);
        TempBlob.CreateInStream(InStream);
        LargeText := Base64Convert.ToBase64(InStream, false);
        // LargeText := GetUrl(ClientType::Web, CompanyName, ObjectType::Report, Report::"Inventory - List", Item, false);
        exit(LargeText);

    end;
}
