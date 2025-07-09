page 50727 ServiceLineAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'serviceLineAPI';
    DelayedInsert = true;
    EntityName = 'ServiceLineAPI';
    EntitySetName = 'ServiceLineAPI';
    PageType = API;
    SourceTable = "Service Line";
    ODataKeyFields = SystemId;
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
                field(orderNo; Rec."Order No.")
                {
                    Caption = 'Order No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(PlannedDeliveryDate; Rec."Planned Delivery Date")
                {
                    Caption = 'Planned Delivery Date';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
            }
        }
    }
}
