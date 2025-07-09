reportextension 50520 "VAT Statement Ext" extends "VAT Statement"
{
    procedure StoreStartDate(Date1: Date; Date2: Date)
    var
        myInt: Integer;
    begin
        StartDate := Date1;
        EndDate := Date2;
        EndDateReq := Date2;
        PeriodSelection := PeriodSelection::"Within Period";
        Selection := Selection::"Open and Closed";
    end;

    var
        StartingDate: Date;
        EndingDate: Date;
        TemplateName: Code[20];
        Name: Code[20];

}
