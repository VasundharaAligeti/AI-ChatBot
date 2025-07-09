page 50720 CreateCustServiceAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'createCustServiceAPI';
    DelayedInsert = true;
    EntityName = 'CreateCustServiceAPI';
    EntitySetName = 'CreateCustServiceAPI';
    PageType = API;
    SourceTable = Customer;
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
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(currencyFilter; Rec."Currency Filter")
                {
                    Caption = 'Currency Filter';
                }
                field(dateFilter; Rec."Date Filter")
                {
                    Caption = 'Date Filter';
                }
                field(globalDimension1Filter; Rec."Global Dimension 1 Filter")
                {
                    Caption = 'Global Dimension 1 Filter';
                }
                field(globalDimension2Filter; Rec."Global Dimension 2 Filter")
                {
                    Caption = 'Global Dimension 2 Filter';
                }
                field(shipToFilter; Rec."Ship-to Filter")
                {
                    Caption = 'Ship-to Filter';
                }
                field(SystemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        serviceHeader: Record "Service Header";
        ServiceHEaderNO: Code[20];
        NoSeriesMgt: Codeunit "No. Series";
        "Service Mgt. Setup": Record "Service Mgt. Setup";
    begin
        if "Service Mgt. Setup".Get() then;
        ServiceHEaderNO := NoSeriesMgt.GetNextNo("Service Mgt. Setup"."Service Order Nos.");

        if ServiceHEaderNO <> '' then begin
            serviceHeader.Reset();
            serviceHeader.Init();
            serviceHeader.Validate("No.", ServiceHEaderNO);
            serviceHeader.Validate("Document Type", serviceHeader."Document Type"::Order);
            serviceHeader.Validate("Customer No.", Rec."No.");
            serviceHeader.Validate("Order Date", WorkDate());
            serviceHeader.Validate("Order Time", Time());
            serviceHeader.Insert(true);
        end;
    end;
}
