page 50717 WorkCenterGrpAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'workCenterGrpAPI';
    DelayedInsert = true;
    EntityName = 'WorkCenterGrpAPI';
    EntitySetName = 'WorkCenterGrpAPI';
    PageType = API;
    SourceTable = "Work Center Group";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(capacityEffective; Rec."Capacity (Effective)")
                {
                    Caption = 'Capacity (Effective)';
                }
                field(capacityTotal; Rec."Capacity (Total)")
                {
                    Caption = 'Capacity (Total)';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(prodOrderNeedQty; Rec."Prod. Order Need (Qty.)")
                {
                    Caption = 'Prod. Order Need (Qty.)';
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
                field(dateFilter; Rec."Date Filter")
                {
                    Caption = 'Date Filter';
                }
                field(prodOrderStatusFilter; Rec."Prod. Order Status Filter")
                {
                    Caption = 'Prod. Order Status Filter';
                }
                field(workShiftFilter; Rec."Work Shift Filter")
                {
                    Caption = 'Work Shift Filter';
                }
            }
        }
    }
}
