page 50501 CopilotItemAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'copilotItemAPI';
    DelayedInsert = true;
    EntityName = 'CopilotItemAPI';
    EntitySetName = 'CopilotItemAPI';
    PageType = API;
    SourceTable = item;
    //SourceTableView = where(Blocked = const(false));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(inventory; Rec.Inventory)
                {
                    Caption = 'Inventory';
                }
                field(reorderQuantity; Rec."Reorder Quantity")
                {
                    Caption = 'Reorder Quantity';
                }
                field(picture; Rec.Picture)
                {
                    Caption = 'Picture';
                }
                field(ItemCardFilterURL; GetItemCardPageFilterAPI())
                {
                    Caption = 'Item Card Filter URL';
                }
                field("productionBOMNo"; Rec."Production BOM No.")
                {
                    Caption = 'Production BOM No.';
                }
            }
        }
    }
    local procedure GetItemCardPageFilterAPI(): Text
    var
        CopilotInventoryModule: Record "Copilot Inventory Module";
        BaseURL: Text;
        EncodedNo: Text;
    begin
        CopilotInventoryModule.Get();
        BaseURL := CopilotInventoryModule."Item Card Page URL";
        EncodedNo := UrlEncode(Rec."No.");
        BaseURL += '&page=30' +
                   '&filter=''' + 'No.' + ''' IS ''' + EncodedNo + '''';

        exit(BaseURL);

    end;

    procedure UrlEncode(Input: Code[2048]): Text
    var
        Output: Text;
        i: Integer;
        Char: Char;
    begin
        for i := 1 to StrLen(Input) do begin
            Char := Input[i];
            case Char of
                'A' .. 'Z', 'a' .. 'z', '0' .. '9', '-', '_', '.', '~':
                    Output += Char;
                ' ':
                    Output += '%20';
                else
                    Output += '%' + Format(Char, 0, 2);
            end;
        end;

        exit(Output);
    end;
}
