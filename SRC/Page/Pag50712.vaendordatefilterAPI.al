page 50712 vaendordatefilterAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'vaendordatefilterAPI';
    DelayedInsert = true;
    EntityName = 'vaendordatefilterAPI';
    EntitySetName = 'vaendordatefilterAPI';
    PageType = API;
    SourceTable = Vendor;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(InvDiscountsLCY; Rec."Inv. Discounts (LCY)")
                {

                }
                field(PmtDiscountsLCY; Rec."Pmt. Discounts (LCY)")
                {

                }
                field(pmtToleranceLCY; Rec."Pmt. Tolerance (LCY)")
                {
                    Caption = 'Pmt. Tolerance (LCY)';
                }
                field(PmtDiscToleranceLCY; Rec."Pmt. Disc. Tolerance (LCY)")
                {
                    Caption = 'Pmt. Disc. Tolerance (LCY)';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(paymentsLCY; Rec."Payments (LCY)")
                {
                    Caption = 'Payments (LCY)';
                }
                field(PurchasesLCY; Rec."Purchases (LCY)")
                {
                    Caption = 'Purchases (LCY)';
                }
                field(dateFilter; Rec."Date Filter")
                {
                    Caption = 'Date Filter';
                }

            }
        }
    }
}
