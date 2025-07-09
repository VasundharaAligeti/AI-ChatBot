codeunit 50500 "Event Subscriber"
{
    procedure CreateTransferHeader(): Text
    var
        TransferHeader: Record "Transfer Header";
    begin
        TransferHeader.Init();
        TransferHeader.Insert(true);
        exit(TransferHeader."No.");
    end;

    var
        myInt: Integer;
}