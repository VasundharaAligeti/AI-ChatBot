page 50719 PostConsOptReleasedProdAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'postConsOptReleasedProdAPI';
    DelayedInsert = true;
    EntityName = 'PostConsOptReleasedProdAPI';
    EntitySetName = 'PostConsOptReleasedProdAPI';
    PageType = API;
    SourceTable = "Prod. Order Line";
    ODataKeyFields = SystemId;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Prod. Order No.';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(capacityNoFilter; Rec."Capacity No. Filter")
                {
                    Caption = 'Capacity No. Filter';
                }
                field(capacityTypeFilter; Rec."Capacity Type Filter")
                {
                    Caption = 'Capacity Type Filter';
                }
                field(dateFilter; Rec."Date Filter")
                {
                    Caption = 'Date Filter';
                }
                field(lotNoFilter; Rec."Lot No. Filter")
                {
                    Caption = 'Lot No. Filter';
                }
                field(packageNoFilter; Rec."Package No. Filter")
                {
                    Caption = 'Package No. Filter';
                }
                field(serialNoFilter; Rec."Serial No. Filter")
                {
                    Caption = 'Serial No. Filter';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        ShowProductionJournal();
    end;

    local procedure ShowProductionJournal()
    var
        ProdOrder: Record "Production Order";
        ProductionJrnlMgt: Codeunit "Production Journal Mgt";
    begin
        CurrPage.SaveRecord();

        ProdOrder.Get(Rec.Status, Rec."Prod. Order No.");

        Clear(ProductionJrnlMgt);
        ProductionJrnlMgt.Handling(ProdOrder, Rec."Line No.");
    end;


}
