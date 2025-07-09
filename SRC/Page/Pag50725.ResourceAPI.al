page 50725 ResourceAPI
{
    APIGroup = 'SJSI';
    APIPublisher = 'SJSI';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'resourceAPI';
    DelayedInsert = true;
    EntityName = 'ResourceAPI';
    EntitySetName = 'ResourceAPI';
    PageType = API;
    SourceTable = Resource;
    ODataKeyFields = SystemId;
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
                field(automaticExtTexts; Rec."Automatic Ext. Texts")
                {
                    Caption = 'Automatic Ext. Texts';
                }
                field(baseUnitOfMeasure; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit of Measure';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(capacity; Rec.Capacity)
                {
                    Caption = 'Capacity';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(contractClass; Rec."Contract Class")
                {
                    Caption = 'Contract Class';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(coupledToDataverse; Rec."Coupled to Dataverse")
                {
                    Caption = 'Coupled to Dynamics 365 Sales';
                }
                field(defaultDeferralTemplateCode; Rec."Default Deferral Template Code")
                {
                    Caption = 'Default Deferral Template Code';
                }
                field(directUnitCost; Rec."Direct Unit Cost")
                {
                    Caption = 'Direct Unit Cost';
                }
                field(education; Rec.Education)
                {
                    Caption = 'Education';
                }
                field(employmentDate; Rec."Employment Date")
                {
                    Caption = 'Employment Date';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(icPartnerPurchGLAccNo; Rec."IC Partner Purch. G/L Acc. No.")
                {
                    Caption = 'IC Partner Purch. G/L Acc. No.';
                }
                field(image; Rec.Image)
                {
                    Caption = 'Image';
                }
                field(inCustomerZone; Rec."In Customer Zone")
                {
                    Caption = 'In Customer Zone';
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                    Caption = 'Indirect Cost %';
                }
                field(jobTitle; Rec."Job Title")
                {
                    Caption = 'Job Title';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(priceProfitCalculation; Rec."Price/Profit Calculation")
                {
                    Caption = 'Price/Profit Calculation';
                }
                field(privacyBlocked; Rec."Privacy Blocked")
                {
                    Caption = 'Privacy Blocked';
                }
                field(profit; Rec."Profit %")
                {
                    Caption = 'Profit %';
                }
                field(qtyQuotedJob; Rec."Qty. Quoted (Job)")
                {
                    Caption = 'Qty. Quoted (Project)';
                }
                field(qtyOnAssemblyOrder; Rec."Qty. on Assembly Order")
                {
                    Caption = 'Qty. on Assembly Order';
                }
                field(qtyOnOrderJob; Rec."Qty. on Order (Job)")
                {
                    Caption = 'Qty. on Order (Project)';
                }
                field(qtyOnServiceOrder; Rec."Qty. on Service Order")
                {
                    Caption = 'Qty. on Service Order';
                }
                field(resourceGroupNo; Rec."Resource Group No.")
                {
                    Caption = 'Resource Group No.';
                }
                field(salesCost; Rec."Sales (Cost)")
                {
                    Caption = 'Sales (Cost)';
                }
                field(salesPrice; Rec."Sales (Price)")
                {
                    Caption = 'Sales (Price)';
                }
                field(salesQty; Rec."Sales (Qty.)")
                {
                    Caption = 'Sales (Qty.)';
                }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(serviceZoneFilter; Rec."Service Zone Filter")
                {
                    Caption = 'Service Zone Filter';
                }
                field(socialSecurityNo; Rec."Social Security No.")
                {
                    Caption = 'Social Security No.';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                    Caption = 'Tax Group Code';
                }
                field(timeSheetApproverUserID; Rec."Time Sheet Approver User ID")
                {
                    Caption = 'Time Sheet Approver User ID';
                }
                field(timeSheetOwnerUserID; Rec."Time Sheet Owner User ID")
                {
                    Caption = 'Time Sheet Owner User ID';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(unitGroupExists; Rec."Unit Group Exists")
                {
                    Caption = 'Unit Group Exists';
                }
                field(unitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                }
                field(usageCost; Rec."Usage (Cost)")
                {
                    Caption = 'Usage (Cost)';
                }
                field(usagePrice; Rec."Usage (Price)")
                {
                    Caption = 'Usage (Price)';
                }
                field(usageQty; Rec."Usage (Qty.)")
                {
                    Caption = 'Usage (Qty.)';
                }
                field(useTimeSheet; Rec."Use Time Sheet")
                {
                    Caption = 'Use Time Sheet';
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
            }
        }
    }
    local procedure GetRecRef(RecVariant: Variant) RecRef: RecordRef
    begin
        if RecVariant.IsRecordRef() then
            exit(RecVariant);
        if RecVariant.IsRecord() then
            RecRef.GetTable(RecVariant);
    end;

    [ServiceEnabled]
    procedure SendReportUsageReporttoUser()
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
        userRec: Record User;
        Email: Codeunit Email;
    begin
        userRec.SetRange("User Name", UserId);
        if userRec.FindFirst() then begin
            Subject := 'Resource Usage Report for ' + Rec."No." + ' ' + Rec.Name;
            Body := 'This is a report of the resource usage for Resource ' + Rec."No.";
            Body1 := '<p style="font-family:Calibri"> This Report is Generated by Chatbot AI' + '</p>';
            RecordVariant := Rec;
            TempBlob.CreateOutStream(outstrem);
            Report.SaveAs(Report::"Resource Usage", '', ReportFormat::Pdf, outstrem, GetRecRef(RecordVariant));
            TempBlob.CreateInStream(Instrem);
            Base64Strimg := Base64.ToBase64(Instrem);
            EmailMessage.Create(userRec."Authentication Email", Subject, Body + Body1, true);
            if Base64Strimg <> '' then begin
                EmailMessage.AddAttachment(StrSubstNo('Resource Usage ' + Rec."No." + '.pdf'), '', Base64Strimg);
                Email.Send(EmailMessage);
            end;
        end;
    end;
}
