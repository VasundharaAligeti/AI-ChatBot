// pageextension 50701 ServiceOrder extends "Service Order"
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         addafter(Post)
//         {
//             action(newShip)
//             {
//                 ApplicationArea = All;
//                 Caption = 'new Ship';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Image = Post;
//                 ToolTip = 'Post the service order with new logic.';
//                 Visible = true;
//                 Enabled = true;
//                 trigger OnAction()
//                 begin
//                     Rec.Ship := true;
//                     Rec.Invoice := false;
//                     Rec.Consume := false;
//                     Rec.Modify();
//                     SendToPostnew(Codeunit::"Service-Post (Yes/No) modified");
//                     //Message('posted');
//                 end;
//             }
//             action(NewInvoice)
//             {
//                 ApplicationArea = All;
//                 Caption = 'New Invoice';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Image = Post;
//                 ToolTip = 'Post the service order with new logic.';
//                 Visible = true;
//                 Enabled = true;
//                 trigger OnAction()
//                 begin
//                     Rec.Ship := true;
//                     Rec.Invoice := true;
//                     Rec.Consume := false;
//                     Rec.Modify();
//                     SendToPostnew(Codeunit::"Service-Post (Yes/No) modified");
//                     //Message('posted');
//                 end;
//             }
//             action(NewShipandInvoice)
//             {
//                 ApplicationArea = All;
//                 Caption = 'New Ship and Invoice';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Image = Post;
//                 ToolTip = 'Post the service order with new logic.';
//                 Visible = true;
//                 Enabled = true;
//                 trigger OnAction()
//                 begin
//                     Rec.Ship := true;
//                     Rec.Invoice := true;
//                     Rec.Consume := false;
//                     Rec.Modify();
//                     SendToPostnew(Codeunit::"Service-Post (Yes/No) modified");
//                     //Message('posted');
//                 end;
//             }
//             action(NewShipandConsume)
//             {
//                 ApplicationArea = All;
//                 Caption = 'New Ship and Consume';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Image = Post;
//                 ToolTip = 'Post the service order with new logic.';
//                 Visible = true;
//                 Enabled = true;
//                 trigger OnAction()
//                 begin
//                     Rec.Ship := true;
//                     Rec.Invoice := false;
//                     Rec.Consume := true;
//                     Rec.Modify();
//                     SendToPostnew(Codeunit::"Service-Post (Yes/No) modified");
//                     //Message('posted');
//                 end;
//             }
//             action(Print)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Print';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Image = Print;
//                 ToolTip = 'Print the service order.';
//                 RunObject = report "Service Order";
//                 trigger OnAction()
//                 begin

//                 end;
//             }
//         }
//     }

//     procedure SendToPostnew(CodeunitId: Integer) IsSuccess: Boolean
//     var
//         TempServLine: Record "Service Line" temporary;
//     begin
//         exit(SendToPostWithLinesnew(CodeunitId, TempServLine));
//     end;

//     procedure SendToPostWithLinesnew(CodeunitId: Integer; var TempServLine: Record "Service Line" temporary) IsSuccess: Boolean
//     var
//         ErrorContextElement: Codeunit "Error Context Element";
//         ErrorMessageMgt: Codeunit "Error Message Management";
//         ErrorMessageHandler: Codeunit "Error Message Handler";
//         ServPostYesNo: Codeunit "Service-Post (Yes/No) modified";
//         IsHandled: Boolean;
//     begin
//         IsHandled := false;
//         //OnBeforeSendToPostWithLines(Rec, TempServLine, CodeunitId, IsHandled, IsSuccess);
//         if IsHandled then
//             exit(IsSuccess);

//         Commit();
//         ErrorMessageMgt.Activate(ErrorMessageHandler);
//         ErrorMessageMgt.PushContext(ErrorContextElement, rec.RecordId, 0, '');
//         if CodeunitId = Codeunit::"Service-Post (Yes/No) modified" then begin
//             ServPostYesNo.SetGlobalServiceHeader(Rec);
//             IsSuccess := ServPostYesNo.Run(TempServLine);
//             ServPostYesNo.GetGlobalServiceHeader(Rec);
//         end else
//             IsSuccess := Codeunit.Run(CodeunitId, Rec);

//         if not IsSuccess then
//             ErrorMessageHandler.ShowErrors();
//     end;

//     var
//         myInt: Integer;
// }