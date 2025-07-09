page 50508 TrackBinContentAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'trackBinContentAPI';
    DelayedInsert = true;
    EntityName = 'TrackBinContentAPI';
    EntitySetName = 'TrackBinContentAPI';
    PageType = API;
    SourceTable = "Bin Content";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(binTypeCode; Rec."Bin Type Code")
                {
                    Caption = 'Bin Type Code';
                }
            }
        }
    }
}
