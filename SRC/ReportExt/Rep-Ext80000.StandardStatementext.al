reportextension 80000 "Standard Statement ext" extends "Standard Statement"
{
    procedure StoreDate(Date1: Date; Date2: Date)
    var

    begin
        StartDate := Date1;
        EndDate := Date2;
    end;
}
