page 50721 ServiceOrderHeaderAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'serviceOrderHeaderAPI';
    DelayedInsert = true;
    EntityName = 'ServiceOrderHeaderAPI';
    EntitySetName = 'ServiceOrderHeaderAPI';
    PageType = API;
    SourceTable = "Service Header";
    ODataKeyFields = SystemId;
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
                field(releaseStatus; Rec."Release Status")
                {
                    Caption = 'Release Status';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(CustomerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(URL; URL)
                {
                    Caption = 'URL';
                }
                field(DocumentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        URL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Service Order", Rec, false);
    end;

    [ServiceEnabled]
    procedure Invoice(): Text
    begin
        Rec.Ship := false;
        Rec.Invoice := true;
        Rec.Consume := false;
        Rec.Modify();
        if not PostServiceOrder then
            exit('Failed to post service order ' + GetLastErrorText())
        else
            exit('Service order ' + Rec."No." + ' has been invoiced successfully.');
    end;

    [ServiceEnabled]
    procedure Ship(): Text
    begin
        Rec.Ship := true;
        Rec.Invoice := false;
        Rec.Consume := false;
        Rec.Modify();
        if not PostServiceOrder then
            exit('Failed to post service order ' + GetLastErrorText())
        else
            exit('Service order ' + Rec."No." + ' has been shipped successfully.');
    end;

    [ServiceEnabled]
    procedure ShipandInvoice(): Text
    var
        myInt: Integer;
    begin
        Rec.Ship := true;
        Rec.Invoice := true;
        Rec.Consume := false;
        Rec.Modify();
        if not PostServiceOrder then
            exit('Failed to post service order ' + GetLastErrorText())
        else
            exit('Service order ' + Rec."No." + ' has been shipped and invoiced successfully.');
    end;

    [ServiceEnabled]
    procedure ShipandConsume(): Text
    var
        myInt: Integer;
    begin
        Rec.Ship := true;
        Rec.Invoice := false;
        Rec.Consume := true;
        Rec.Modify();
        if not PostServiceOrder then
            exit('Failed to post service order ' + GetLastErrorText())
        else
            exit('Service order ' + Rec."No." + ' has been shipped and consumed successfully.');
    end;

    [TryFunction]
    procedure PostServiceOrder()
    begin
        SendToPostnew(Codeunit::"Service-Post (Yes/No) modified");
    end;

    procedure SendToPostnew(CodeunitId: Integer) IsSuccess: Boolean
    var
        TempServLine: Record "Service Line" temporary;
    begin
        exit(SendToPostWithLinesnew(CodeunitId, TempServLine));
    end;

    procedure SendToPostWithLinesnew(CodeunitId: Integer; var TempServLine: Record "Service Line" temporary) IsSuccess: Boolean
    var
        ErrorContextElement: Codeunit "Error Context Element";
        ErrorMessageMgt: Codeunit "Error Message Management";
        ErrorMessageHandler: Codeunit "Error Message Handler";
        ServPostYesNo: Codeunit "Service-Post (Yes/No) modified";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeSendToPostWithLines(Rec, TempServLine, CodeunitId, IsHandled, IsSuccess);
        if IsHandled then
            exit(IsSuccess);

        Commit();
        ErrorMessageMgt.Activate(ErrorMessageHandler);
        ErrorMessageMgt.PushContext(ErrorContextElement, rec.RecordId, 0, '');
        if CodeunitId = Codeunit::"Service-Post (Yes/No) modified" then begin
            ServPostYesNo.SetGlobalServiceHeader(Rec);
            IsSuccess := ServPostYesNo.Run(TempServLine);
            ServPostYesNo.GetGlobalServiceHeader(Rec);
        end else
            IsSuccess := Codeunit.Run(CodeunitId, Rec);

        if not IsSuccess then
            ErrorMessageHandler.ShowErrors();
    end;

    [serviceEnabled]
    procedure SendSLAAlertNotification(): Text
    var
        ServiceLineRec: Record "Service Line";
        CustomerRec: Record User;
        sendAlert: Boolean;
        Subject: Text;
        Body: Text;
        Body1: Text;
        outstrem: OutStream;
        Instrem: InStream;
        RecordVariant: Variant;
        Base64: Codeunit "Base64 Convert";
        Base64Strimg: Text;
        TempBlob: Codeunit "Temp Blob";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        BodyBuilder: TextBuilder;
        BoduText: Text;
    begin
        sendAlert := false;
        ServiceLineRec.SetRange("Document Type", Rec."Document Type");
        ServiceLineRec.SetRange("Document No.", Rec."No.");

        if CustomerRec.Get(Rec.SystemCreatedBy) then;
        Subject := 'SLA breach Alert for service order ' + Rec."No.";
        BodyBuilder.AppendLine('<html><body>');
        BodyBuilder.AppendLine('<p>Dear ' + CustomerRec."User Name" + ',</p>');
        BodyBuilder.AppendLine('<p>The following service lines have a Planned Delivery Date exceeded</p>');

        BodyBuilder.AppendLine('<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse;">');
        BodyBuilder.AppendLine('<tr><th>No.</th><th>Description</th></tr>');

        if ServiceLineRec.FindSet() then
            repeat
                if ServiceLineRec."Planned Delivery Date" < Today then begin
                    sendAlert := true;
                    BodyBuilder.AppendLine(
                        StrSubstNo('<tr><td>%1</td><td>%2</td></tr>',
                            ServiceLineRec."No.",
                            ServiceLineRec.Description));
                end;
            until ServiceLineRec.Next() = 0;

        BodyBuilder.AppendLine('</table>');

        BodyBuilder.AppendLine('<p>Please take necessary actions.</p>');
        BodyBuilder.AppendLine('</body></html>');

        BoduText := BodyBuilder.ToText();

        if sendAlert then begin
            EmailMessage.Create(CustomerRec."Authentication Email", Subject, BoduText, true);
            Email.Send(EmailMessage);
            exit('Sent alert notification');
        end
        else
            exit('No need to send SLA alert notification for service order ' + Rec."No.");
    end;

    [ServiceEnabled]
    procedure SendServiceReportToCustomer(): Text
    var
        Subject: Text;
        Body: Text;
        Body1: Text;
        outstrem: OutStream;
        Instrem: InStream;
        RecordVariant: Variant;
        Base64: Codeunit "Base64 Convert";
        Base64Strimg: Text;
        TempBlob: Codeunit "Temp Blob";
        EmailMessage: Codeunit "Email Message";
        CustomerRec: Record Customer;
        Email: Codeunit Email;
    begin
        if CustomerRec.get(Rec."Customer No.") then;
        Subject := 'Service Order Report ' + Rec."No.";
        Body := 'This is a report of the Service Order ' + Rec."No.";
        Body1 := '<p style="font-family:Calibri"> This Report is Generated by Chatbot AI' + '</p>';
        RecordVariant := Rec;
        TempBlob.CreateOutStream(outstrem);
        Report.SaveAs(Report::"Service Order", '', ReportFormat::Pdf, outstrem, GetRecRef(RecordVariant));
        TempBlob.CreateInStream(Instrem);
        Base64Strimg := Base64.ToBase64(Instrem);
        EmailMessage.Create(CustomerRec."E-Mail", Subject, Body + Body1, true);
        if Base64Strimg <> '' then begin
            EmailMessage.AddAttachment(StrSubstNo('Service Order ' + Rec."No." + '.pdf'), '', Base64Strimg);
            Email.Send(EmailMessage);
            exit('Service Order Report sent to customer' + ' ' + rec."Customer No.");
        end
        else
            exit('Failed to send Service Order Report to customer' + ' ' + rec."Customer No.");
    end;

    local procedure GetRecRef(RecVariant: Variant) RecRef: RecordRef
    begin
        if RecVariant.IsRecordRef() then
            exit(RecVariant);
        if RecVariant.IsRecord() then
            RecRef.GetTable(RecVariant);
    end;

    [serviceEnabled]
    procedure CreateNewServiceOrderForCustomer(CustomerNo: Code[20]): Text
    var
        ServiceHeader: Record "Service Header";
        ServiceOrderNo: Code[20];
    begin
        ServiceHeader.Init();
        ServiceHeader.Validate("Document Type", ServiceHeader."Document Type"::Order);
        ServiceHeader.Validate("Customer No.", CustomerNo);
        if ServiceHeader.Insert(true) then
            exit('New Service Order created for Customer No. ' + CustomerNo + ' with Order No. ' + ServiceHeader."No.")
        else
            exit('Failed to create new Service Order for Customer No. ' + CustomerNo);
    end;

    var
        URL: Text;
}
