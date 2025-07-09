page 50722 ServiceOrderAllocationAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'serviceOrderAllocationAPI';
    DelayedInsert = true;
    EntityName = 'ServiceOrderAllocationAPI';
    EntitySetName = 'ServiceOrderAllocationAPI';
    PageType = API;
    SourceTable = "Service Order Allocation";
    ODataKeyFields = SystemId;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(allocatedHours; Rec."Allocated Hours")
                {
                    Caption = 'Allocated Hours';
                }
                field(allocationDate; Rec."Allocation Date")
                {
                    Caption = 'Allocation Date';
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
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(finishingTime; Rec."Finishing Time")
                {
                    Caption = 'Finishing Time';
                }
                field(posted; Rec.Posted)
                {
                    Caption = 'Posted';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(repairStatus; Rec."Repair Status")
                {
                    Caption = 'Repair Status';
                }
                field(resourceGroupNo; Rec."Resource Group No.")
                {
                    Caption = 'Resource Group No.';
                }
                field(resourceNo; Rec."Resource No.")
                {
                    Caption = 'Resource No.';
                }
                field(serviceItemDescription; Rec."Service Item Description")
                {
                    Caption = 'Service Item Description';
                }
                field(serviceItemLineNo; Rec."Service Item Line No.")
                {
                    Caption = 'Service Item Line No.';
                }
                field(serviceItemNo; Rec."Service Item No.")
                {
                    Caption = 'Service Item No.';
                }
                field(serviceItemSerialNo; Rec."Service Item Serial No.")
                {
                    Caption = 'Service Item Serial No.';
                }
                field(serviceStarted; Rec."Service Started")
                {
                    Caption = 'Service Started';
                }
                field(startingTime; Rec."Starting Time")
                {
                    Caption = 'Starting Time';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
    [ServiceEnabled]
    procedure CreateNewResourceAllocation(ResourceNo: Code[30]; DocumentNo: Code[20]; ServiceItemNo: Code[20]; serviceItemLineNo: Integer): text
    var
        serviceOrderAllocation: Record "Service Order Allocation";
    begin
        if CreateNewResourceAllocationtryfunc(ResourceNo, DocumentNo, ServiceItemNo, serviceItemLineNo) then
            exit('Resource Allocation created successfully')
        else
            exit('Failed to create Resource Allocation ' + GetLastErrorText());
    end;

    [TryFunction]
    procedure CreateNewResourceAllocationtryfunc(ResourceNo: Code[30]; DocumentNo: Code[20]; ServiceItemNo: Code[20]; serviceItemLineNo: Integer)
    var
        serviceOrderAllocation: Record "Service Order Allocation";
        serviceItemlines: Record "Service Item Line";
        resource: Record Resource;
    begin
        serviceItemlines.setrange("Document No.", DocumentNo);
        serviceItemlines.setrange("Service Item No.", ServiceItemNo);
        if serviceItemlines.findfirst() then
            serviceItemLineNo := serviceItemlines."Line No."
        else
            Error('Service Item Line not found for Document No. %1 and Service Item No. %2', DocumentNo, ServiceItemNo);
        if not resource.Get(ResourceNo) then
            Error('Resource No. %1 not found', ResourceNo);
        serviceOrderAllocation.Init();
        serviceOrderAllocation.Validate("Document Type", serviceOrderAllocation."Document Type"::Order);
        serviceOrderAllocation.Validate("Document No.", DocumentNo);
        serviceOrderAllocation.Validate("Service Item No.", ServiceItemNo);
        serviceOrderAllocation.Validate("Service Item Line No.", serviceItemLineNo);
        serviceOrderAllocation.Validate("Resource No.", ResourceNo);
        serviceOrderAllocation.Validate("Allocation Date", Today());
        serviceOrderAllocation.Insert(true);
    end;
}
