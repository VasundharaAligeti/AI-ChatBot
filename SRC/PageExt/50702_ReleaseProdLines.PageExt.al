// pageextension 50702 ReleaseProdOrderLines extends "Released Prod. Order Lines"
// {
//     layout
//     {

//     }

//     actions
//     {
//         addafter(ProductionJournal)
//         {
//             action(postConsumption)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Post Consumption';
//                 Image = Post;
//                 ToolTip = 'Post the consumption of the production order lines.';

//                 trigger OnAction()
//                 var
//                     productionorderRec: Record "Production Order";
//                     ItemJournalLine: Record "Item Journal Line";
//                     ProductionJrnlMgt: Codeunit "Production JournalMgt Modified";
//                 begin
//                     SetTemplateandBatchName();
//                     ProductionJrnlMgt.DeleteJnlLines(ToTemplateName, ToBatchName, Rec."Prod. Order No.", Rec."Line No.");
//                     if productionorderRec.Get(Rec.Status, Rec."Prod. Order No.") then;
//                     productionorderRec.Isconsumption := true;
//                     productionorderRec.IsOutput := false;
//                     productionorderRec.Modify(true);
//                     ShowProductionJournal();

//                     //posting output
//                     ItemJournalLine.SetRange("Document No.", Rec."Prod. Order No.");
//                     ItemJournalLine.SetRange("Source No.", rec."Item No.");
//                     ItemJournalLine.SetRange("Journal Template Name", ToTemplateName);
//                     ItemJournalLine.SetRange("Journal Batch Name", ToBatchName);
//                     productionorderRec.Get(Rec.Status, Rec."Prod. Order No.");
//                     if productionorderRec.Isconsumption then
//                         ItemJournalLine.SetRange("Entry Type", ItemJournalLine."Entry Type"::Consumption)
//                     else if productionorderRec.IsOutput then
//                         ItemJournalLine.SetRange("Entry Type", ItemJournalLine."Entry Type"::Output);
//                     if ItemJournalLine.FindFirst() then
//                         PostingItemJnlFromProduction(false, ItemJournalLine);
//                     //setup(ItemJournalLine);
//                     InsertTempRec();

//                     SetFilterGroup();
//                     CurrPage.Update(false);

//                     ProductionJrnlMgt.DeleteJnlLines(ToTemplateName, ToBatchName, Rec."Prod. Order No.", Rec."Line No.");
//                 end;
//             }
//             action(postOutput)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Post Output';
//                 Image = Post;
//                 ToolTip = 'Post the Output of the production order lines.';

//                 trigger OnAction()
//                 var
//                     productionorderRec: Record "Production Order";
//                     ItemJournalLine: Record "Item Journal Line";
//                     ProductionJrnlMgt: Codeunit "Production JournalMgt Modified";
//                 begin
//                     SetTemplateandBatchName();
//                     ProductionJrnlMgt.DeleteJnlLines(ToTemplateName, ToBatchName, Rec."Prod. Order No.", Rec."Line No.");
//                     if productionorderRec.Get(Rec.Status, Rec."Prod. Order No.") then;
//                     productionorderRec.Isconsumption := false;
//                     productionorderRec.IsOutput := true;
//                     productionorderRec.Modify(true);
//                     ShowProductionJournal();

//                     //posting output
//                     //posting output
//                     // if PostItemJrnlLines() then
//                     //     Message('posted consumption for %1', Rec."Prod. Order No.")
//                     // else
//                     //     Message(GetLastErrorText() + 'from AI');
//                     ItemJournalLine.SetRange("Document No.", Rec."Prod. Order No.");
//                     ItemJournalLine.SetRange("Source No.", rec."Item No.");
//                     ItemJournalLine.SetRange("Journal Template Name", ToTemplateName);
//                     ItemJournalLine.SetRange("Journal Batch Name", ToBatchName);
//                     productionorderRec.Get(Rec.Status, Rec."Prod. Order No.");
//                     if productionorderRec.Isconsumption then
//                         ItemJournalLine.SetRange("Entry Type", ItemJournalLine."Entry Type"::Consumption)
//                     else if productionorderRec.IsOutput then
//                         ItemJournalLine.SetRange("Entry Type", ItemJournalLine."Entry Type"::Output);
//                     if ItemJournalLine.FindFirst() then
//                         PostingItemJnlFromProduction(false, ItemJournalLine);
//                     //setup(ItemJournalLine);
//                     InsertTempRec();

//                     SetFilterGroup();
//                     CurrPage.Update(false);

//                     ProductionJrnlMgt.DeleteJnlLines(ToTemplateName, ToBatchName, Rec."Prod. Order No.", Rec."Line No.");
//                 end;
//             }
//         }
//     }
//     procedure DeleteTempRec()
//     var
//         TempItemJnlLineRec: Record "Item Journal Line";
//     begin
//         TempItemJnlLine.DeleteAll();

//         if TempItemJnlLineRec.Find('-') then
//             repeat
//                 case TempItemJnlLineRec."Entry Type" of
//                     TempItemJnlLineRec."Entry Type"::Consumption:
//                         if TempItemJnlLineRec."Quantity (Base)" = 0 then begin
//                             TempItemJnlLine := TempItemJnlLineRec;
//                             TempItemJnlLine.Insert();

//                             TempItemJnlLineRec.Delete();
//                         end;
//                     TempItemJnlLineRec."Entry Type"::Output:
//                         if TempItemJnlLineRec.TimeIsEmpty() and
//                            (TempItemJnlLineRec."Output Quantity (Base)" = 0) and (TempItemJnlLineRec."Scrap Quantity (Base)" = 0)
//                         then begin
//                             TempItemJnlLine := TempItemJnlLineRec;
//                             TempItemJnlLine.Insert();

//                             TempItemJnlLineRec.Delete();
//                         end;
//                 end;
//             until TempItemJnlLineRec.Next() = 0;
//     end;

//     procedure InsertTempRec()
//     var
//         ItemJournalLine: Record "Item Journal Line";
//     begin
//         if TempItemJnlLine.Find('-') then
//             repeat
//                 ItemJournalLine := TempItemJnlLine;
//                 ItemJournalLine."Changed by User" := false;
//                 ItemJournalLine.Insert();
//             until TempItemJnlLine.Next() = 0;
//         TempItemJnlLine.DeleteAll();
//     end;

//     procedure PostingItemJnlFromProduction(Print: Boolean; ItemJournalLine: Record "Item Journal Line")
//     var
//         ProductionOrder: Record "Production Order";
//         IsHandled: Boolean;
//     begin
//         if (ItemJournalLine."Order Type" = ItemJournalLine."Order Type"::Production) and (ItemJournalLine."Order No." <> '') then
//             ProductionOrder.Get(ProductionOrder.Status::Released, ItemJournalLine."Order No.");

//         IsHandled := false;
//         //OnBeforePostingItemJnlFromProduction(Rec, Print, IsHandled);
//         if IsHandled then
//             exit;

//         if Print then
//             CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post+Print", ItemJournalLine)
//         else
//             CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJournalLine);
//     end;

//     procedure SetTemplateandBatchName()
//     var
//         itemjournalLine2: Record "Item Journal Line";
//     begin
//         itemjournalLine2.SetRange("Document No.", Rec."Prod. Order No.");
//         itemjournalLine2.SetRange("Source No.", rec."Item No.");
//         if itemjournalLine2.FindFirst() then begin
//             ToTemplateName := itemjournalLine2."Journal Template Name";
//             ToBatchName := itemjournalLine2."Journal Batch Name";
//         end;
//     end;

//     procedure SetFilterGroup()
//     var
//         itemJournalLine: Record "Item Journal Line";

//     begin
//         itemJournalLine.FilterGroup(2);
//         itemJournalLine.SetRange("Journal Template Name", ToTemplateName);
//         itemJournalLine.SetRange("Journal Batch Name", ToBatchName);
//         itemJournalLine.SetRange("Order Type", itemJournalLine."Order Type"::Production);
//         itemJournalLine.SetRange("Order No.", Rec."Prod. Order No.");
//         if ProdOrderLineNo <> 0 then
//             itemJournalLine.SetRange("Order Line No.", Rec."Line No.");
//         SetFlushingFilter();
//         //OnAfterSetFilterGroup(Rec, ProdOrder, ProdOrderLineNo);
//         Rec.FilterGroup(0);
//     end;

//     procedure SetFlushingFilter()
//     var
//         itemJournalLine: Record "Item Journal Line";
//     begin
//         case FlushingFilter of
//             FlushingFilter::"All Methods":
//                 itemJournalLine.SetRange("Flushing Method");
//             FlushingFilter::"Manual Methods":
//                 itemJournalLine.SetFilter("Flushing Method", '%1|%2', "Flushing Method"::Manual, "Flushing Method"::"Pick + Manual");
//             else
//                 itemJournalLine.SetRange("Flushing Method", FlushingFilter);
//         end;
//     end;

//     local procedure ShowProductionJournal()
//     var
//         ProdOrder: Record "Production Order";
//         ProductionJrnlMgt: Codeunit "Production JournalMgt Modified";
//     begin
//         CurrPage.SaveRecord();

//         ProdOrder.Get(Rec.Status, Rec."Prod. Order No.");

//         Clear(ProductionJrnlMgt);
//         ProductionJrnlMgt.Handling(ProdOrder, Rec."Line No.");
//     end;

//     [TryFunction]
//     procedure PostItemJrnlLines()
//     var
//         productionorderRec: Record "Production Order";
//         ItemJournalLine: Record "Item Journal Line";
//         ProductionJrnlMgt: Codeunit "Production JournalMgt Modified";
//     begin

//         ItemJournalLine.SetRange("Document No.", Rec."Prod. Order No.");
//         ItemJournalLine.SetRange("Source No.", rec."Item No.");
//         ItemJournalLine.SetRange("Journal Template Name", ToTemplateName);
//         ItemJournalLine.SetRange("Journal Batch Name", ToBatchName);
//         productionorderRec.Get(Rec.Status, Rec."Prod. Order No.");
//         if productionorderRec.Isconsumption then
//             ItemJournalLine.SetRange("Entry Type", ItemJournalLine."Entry Type"::Consumption)
//         else if productionorderRec.IsOutput then
//             ItemJournalLine.SetRange("Entry Type", ItemJournalLine."Entry Type"::Output);
//         if ItemJournalLine.FindFirst() then
//             PostingItemJnlFromProduction(false, ItemJournalLine);
//         setup(ItemJournalLine);
//         InsertTempRec();
//         SetTemplateandBatchName();
//         SetFilterGroup();
//         CurrPage.Update(false);

//         ProductionJrnlMgt.DeleteJnlLines(ToTemplateName, ToBatchName, Rec."Prod. Order No.", Rec."Line No.");
//     end;

//     procedure setup(ItemJournalLine: Record "Item Journal Line")
//     begin
//         ToBatchName := ItemJournalLine."Journal Batch Name";
//         ToTemplateName := ItemJournalLine."Journal Template Name";
//     end;

//     var
//         ItemJnlTemplate: Record "Item Journal Template";
//         TempItemJnlLine: Record "Item Journal Line" temporary;
//         ToTemplateName: Code[10];
//         ToBatchName: Code[10];
//         ProdOrder: Record "Production Order";
//         ProdOrderLineNo: Integer;
//         PostingDate: Date;
//         xPostingDate: Date;
//         FlushingFilter: Enum "Flushing Method Filter";
//         Text003: Label 'DEFAULT';
//         Text004: Label 'Production Journal';
//         Text000: Label '%1 journal';
//         ItemJnlBatch: Record "Item Journal Batch";
// }