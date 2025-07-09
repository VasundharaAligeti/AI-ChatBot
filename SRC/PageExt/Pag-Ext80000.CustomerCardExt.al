pageextension 80000 "Customer Card Ext" extends "Customer List"
{
    layout
    {
        addafter("No.")
        {
            field(Tag; Rec.Tag)
            {
                ApplicationArea = All;
                Caption = 'Tag';
                ToolTip = 'Tag for categorizing customers.';
                Editable = false;
            }
        }
    }
    actions
    {

        addafter(History)
        {
            action(StatementReport)
            {
                ApplicationArea = All;
                Caption = 'StatementReport', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;

                trigger OnAction()
                var
                    OutStream: OutStream;
                    TempBlob: Codeunit "Temp Blob";
                    Base64Convert: Codeunit "Base64 Convert";
                    RecRef: RecordRef;
                    InStream: InStream;
                    LargeText: Text;
                    Customer: Record Customer;
                    report1: Report 1316;
                    repoarameters: Text;
                    Today1: Text;

                begin
                    Today1 := Format(Today());

                    // repoarameters := report1.RunRequestPage();
                    // Message('Report Parameters: %1', repoarameters);
                    Customer.SetRange("No.", Rec."No.");
                    if Customer.FindFirst() then;
                    RecRef.GetTable(Customer);
                    TempBlob.CreateOutStream(OutStream);
                    Report.SaveAs(1316, Today1, ReportFormat::Pdf, OutStream, RecRef);
                    TempBlob.CreateInStream(InStream);
                    LargeText := Base64Convert.ToBase64(InStream, false);
                    // exit(LargeText);
                end;
            }
        }
    }
}
