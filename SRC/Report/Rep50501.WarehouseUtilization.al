report 50511 "Warehouse Utilization"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Warehouse Utilization.rdl';
    //DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            column(Document_No_; "Document No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Item_No_; "Item No.")
            {

            }
            column(Description; Description)
            {

            }
            column(Location_Code; "Location Code")
            {

            }
            column(Quantity; Quantity)
            {

            }
            column(Invoiced_Quantity; "Invoiced Quantity")
            {

            }
            column(Remaining_Quantity; "Remaining Quantity")
            {

            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                "Item Ledger Entry".SetFilter("Location Code", '<>%1', '');
                "Item Ledger Entry".SetFilter("Entry Type", '%1', "Item Ledger Entry"."Entry Type"::Sale);
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }

    var
        myInt: Integer;
}