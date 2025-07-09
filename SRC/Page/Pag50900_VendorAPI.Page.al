page 50900 VendorAPIHimani
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'vendorAPI';
    DelayedInsert = true;
    EntityName = 'VendorAPIHimani';
    EntitySetName = 'VendorAPIHimani';
    PageType = API;
    SourceTable = Vendor;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(no; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'The unique identifier for the vendor.';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                    ToolTip = 'The name of the vendor.';
                }
                field(Contact; Rec.Contact)
                {
                    Caption = 'Contact';
                    ToolTip = 'The contact person for the vendor.';
                }
                field(balance; Rec.Balance)
                {
                    Caption = 'Balance';
                    ToolTip = 'The total balance of the vendor.';
                }
                field(balanceDue; Rec."Balance Due")
                {
                    Caption = 'Balance Due';
                    ToolTip = 'The total amount due from the vendor.';
                }
                field(WebUrl; WebUrl)
                {
                    Caption = 'Web URL';
                    ToolTip = 'The URL to access the vendor card page in the web client.';
                }
                field(WebListUrl; WebListUrl)
                {
                    Caption = 'Web List URL';
                    ToolTip = 'The URL to access the vendor list page in the web client.';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        WebUrl := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Vendor Card", Rec, false);
        WebListUrl := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Vendor List", Rec, false);
    end;

    var
        WebUrl: Text;
        WebListUrl: Text;
}
