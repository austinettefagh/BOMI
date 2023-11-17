/** 
 * Helper Class for eTran Documesnts Upload
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This is the helper class for document uplaad whis has the logic of fetching the docs from different objects.
*/

public without sharing class WS_etranDocumentUploadHelper {
    // OUTPUT VARS
    public static WS_eTranServiceInvocableResponse output = new WS_eTranServiceInvocableResponse();
    public static Map<Id,String> docFileNameMap = new Map<Id,String>();
    public static Map<Id,Id> docIdMap = new Map<Id,Id>();
    public static Map<Id,String> docNameMap = new Map<Id,String>();
    
    @InvocableMethod(label='eTran DocUpload')
    public static list<WS_eTranServiceInvocableResponse> main (list<WS_eTranServiceInvocableRequest> input) {
        getDataToSend(input[0].appId,input[0].method, output);
        return new list<WS_eTranServiceInvocableResponse> {output};
            }
    
    public static WS_eTranServiceInvocableResponse getDataToSend(String appID,String method, WS_eTranServiceInvocableResponse output){
        LLC_BI__Application__c application = WS_eTranServiceHelper.getApp(appId);
        LLC_BI__Loan__c loan = WS_eTranServiceHelper.getLoan(application.Id);
        Set<Id> accIdSet = new Set<Id>();
        Set<Id> collManagementRecSet = new Set<Id>();
        
        for(LLC_BI__Legal_Entities__c legalEntity: [SELECT Id, LLC_BI__Account__c,LLC_BI__Account__r.RecordType.Name, LLC_BI__Loan__c,
                                                    LLC_BI__Borrower_Type__c FROM LLC_BI__Legal_Entities__c WHERE LLC_BI__Loan__c =: loan.Id])
        {
            accIdSet.add(legalEntity.LLC_BI__Account__c);
        }
        
        for(LLC_BI__Loan_Collateral2__c col : [SELECT Id,LLC_BI__Collateral__r.LLC_BI__Life_Insurance_Policy_Number__c,
                                               LLC_BI__Collateral__r.RecordTypeID ,LLC_BI__Collateral__c
                                               FROM LLC_BI__Loan_Collateral2__c WHERE LLC_BI__Loan__c =: loan.Id])
        {
            collManagementRecSet.add(col.LLC_BI__Collateral__c);
        }
        
        List<String> greaterThan35MBFiles = new List<String>();
        
        //Loan Document
        List<LLC_BI__LLC_LoanDocument__c> documentList = [SELECT Id, Name, LLC_BI__attachmentId__c, NDOC__fileName__c, EtranDocumentTypeCode__c
                                                          FROM LLC_BI__LLC_LoanDocument__c 
                                                          WHERE LLC_BI__Loan__c =: loan.ID AND EtranDocStatus__c = 'Ready for eTran'
                                                          AND LLC_BI__Has_File__c = True];
        
        //Account Document
        List<LLC_BI__AccountDocument__c> accDocumentList = [SELECT Id, Name, LLC_BI__attachmentId__c, NDOC__fileName__c, EtranDocumentTypeCode__c
                                                            FROM LLC_BI__AccountDocument__c 
                                                            WHERE LLC_BI__Account__c In: accIdSet AND EtranDocStatus__c = 'Ready for eTran'
                                                            AND LLC_BI__Has_File__c = True];
        
        //Document Placeholder
		List<LLC_BI__Document_Placeholder__c> documentPlaceholderList = [SELECT Id, Name, NDOC__Attachment_Id__c, NDOC__file_Name__c, EtranDocumentTypeCode__c
                                                                            FROM LLC_BI__Document_Placeholder__c
                                                                            WHERE (NDOC__Collateral_Mgmt__c In: collManagementRecSet OR LLC_BI__External_Id__c =: loan.LLC_BI__Product_Package__c) 
                                                                            AND EtranDocStatus__c = 'Ready for eTran'
                                                                            AND LLC_BI__Has_File__c = True];
        
        if(documentList.size() <= 0 && accDocumentList.size() <= 0 && documentPlaceholderList.size() <= 0){
            output.errors = 'Etran Document Status should be \'Ready for eTran\' and should have a file attached to it to proceed further.';
        }else{
            for(LLC_BI__LLC_LoanDocument__c conDoc : documentList){
                docFileNameMap.put(conDoc.LLC_BI__attachmentId__c,conDoc.NDOC__fileName__c.replaceAll('[^a-zA-Z0-9\\.]', ''));
                docIdMap.put(conDoc.LLC_BI__attachmentId__c,conDoc.ID);
                docNameMap.put(conDoc.LLC_BI__attachmentId__c,conDoc.EtranDocumentTypeCode__c);
            }
            for(LLC_BI__AccountDocument__c accDoc : accDocumentList){
                docFileNameMap.put(accDoc.LLC_BI__attachmentId__c,accDoc.NDOC__fileName__c.replaceAll('[^a-zA-Z0-9\\.]', ''));
                docIdMap.put(accDoc.LLC_BI__attachmentId__c,accDoc.ID);
                docNameMap.put(accDoc.LLC_BI__attachmentId__c,accDoc.EtranDocumentTypeCode__c);
            }
            for(LLC_BI__Document_Placeholder__c docPlaceholder : documentPlaceholderList){
                docFileNameMap.put(docPlaceholder.NDOC__Attachment_Id__c,docPlaceholder.NDOC__file_Name__c.replaceAll('[^a-zA-Z0-9\\.]', ''));
                docIdMap.put(docPlaceholder.NDOC__Attachment_Id__c,docPlaceholder.Id);
                docNameMap.put(docPlaceholder.NDOC__Attachment_Id__c,docPlaceholder.EtranDocumentTypeCode__c);
            }
            
            List<ContentVersion> coVerList = [SELECT ContentDocumentId,FileExtension,Filetype,title,contentSize FROM ContentVersion WHERE 
                                              ContentDocumentId IN: docFileNameMap.keyset() AND 
                                              FileExtension IN ('pdf','xls','xlsx','csv','doc','docx','jpg','jpeg','png') and isLatest = True];
            if(coVerList.size() <= 0){
                output.errors = 'The attached file must be of file type pdf,xls,xlsx,csv,doc,docx,jpg,jpeg,png';
            }else{
                List<LLC_BI__LLC_LoanDocument__c> loanDocToBeUpdated = new List<LLC_BI__LLC_LoanDocument__c>();
                List<LLC_BI__AccountDocument__c> accDocToBeUpdated = new List<LLC_BI__AccountDocument__c>();
                List<LLC_BI__Document_Placeholder__c> docPlaceholderToBeUpdated = new List<LLC_BI__Document_Placeholder__c>();
                
                for(ContentVersion dataCon : coVerList)
                {
                    if(dataCon.contentSize >= 35000000){
                        greaterThan35MBFiles.add(dataCon.Title);
                        Break;
                    }
                    String FinanInstrumentNum = '';
                    String busCode = '';
                    if(method == 'LoanApp'){
                        FinanInstrumentNum = application.nSBA__Application_Number__c;
                        busCode = '1';
                    }
                    else if(method == 'LoanNmb'){
                        FinanInstrumentNum = application.nSBA__SBA_Loan_Number__c;
                        busCode = '2';
                    }
                    
                    String docTypeCode = '';
                    if(docNameMap.ContainsKey(dataCon.ContentDocumentId))
                        docTypeCode = docNameMap.get(dataCon.ContentDocumentId);
                    
                    Id recID = docIdMap.get(dataCon.ContentDocumentId);
                    String objectname = String.valueof(recID.getSobjectType());
                    
                    docUploadRequestBuild(FinanInstrumentNum, method , docTypeCode, dataCon.Id, 
                                          docFileNameMap.get(dataCon.ContentDocumentId), docIdMap, busCode, objectname);
                    //update records
                    
                    if(objectname == 'LLC_BI__LLC_LoanDocument__c')
                    {
                        LLC_BI__LLC_LoanDocument__c loandocUpdate = new LLC_BI__LLC_LoanDocument__c();
                        loandocUpdate.id = docIdMap.get(dataCon.ContentDocumentId);
                        loandocUpdate.EtranDocStatus__c = 'Sent to eTran';
                        loanDocToBeUpdated.add(loandocUpdate);
                    }else if(objectname == 'LLC_BI__AccountDocument__c')
                    {
                        LLC_BI__AccountDocument__c accDocUpdate = new LLC_BI__AccountDocument__c();
                        accDocUpdate.id = docIdMap.get(dataCon.ContentDocumentId);
                        accDocUpdate.EtranDocStatus__c = 'Sent to eTran';
                        accDocToBeUpdated.add(accDocUpdate);
                    }else if(objectname == 'LLC_BI__Document_Placeholder__c')
                    {
                        LLC_BI__Document_Placeholder__c docPlacUpdate = new LLC_BI__Document_Placeholder__c();
                        docPlacUpdate.id = docIdMap.get(dataCon.ContentDocumentId);
                        docPlacUpdate.EtranDocStatus__c = 'Sent to eTran';
                        docPlaceholderToBeUpdated.add(docPlacUpdate);
                    }
                    
                }
                if(greaterThan35MBFiles.size() > 0)
                    output.errors = 'The files are greater than 35MB file size and will not be processed to Etran.'+greaterThan35MBFiles;
                
                if(loanDocToBeUpdated.size() > 0)
                    update loanDocToBeUpdated;
                if(accDocToBeUpdated.size() > 0)
                    update accDocToBeUpdated;
                if(docPlaceholderToBeUpdated.size() > 0)
                    update docPlaceholderToBeUpdated;
            }
        }
        return output;
    }
    @future(callout=true)
    public static void docUploadRequestBuild(String FinanInstrumentNum, String FinanInstrumentType, 
                                             String DocumentTypeCd, String contenVerId, String fileName, Map<Id,Id> docIdMapFuture, String busCode, String objectName)
    {
        String recID = '';
        String errorMsg = '';
        String status = '';
        
        WS_eTranXMLWrapper.Map_x requestMap = new WS_eTranXMLWrapper.Map_x();
        WS_eTranXMLWrapper.mapItem mapItemCom;
        List<WS_eTranXMLWrapper.mapItem> mapItemList = new List<WS_eTranXMLWrapper.mapItem>();
        
        ContentVersion dataCon = [SELECT ContentDocumentId, VersionData FROM ContentVersion WHERE 
                                  Id =: contenVerId];
        
        CM_EtranConfigurationSetting__mdt metadataRec = WS_eTranServiceHelper.getMetadata();
        List<EtranCredential__c> credentials = WS_eTranServiceHelper.getCredentials();
        //Build the Upload Document Parameters.
        Map<String,String> reqStringMap = new Map<String,String>{'CLSUsername' => credentials[0].TECH_CLSUsername__c,
            'CLSPassword' => credentials[0].TECH_CLSPassword__c,
            'CLSPIN' => credentials[0].TECH_CLSPin__c,
            'LocationId' => metadataRec.TECH_LocationId__c,
            'SoftwareVendorName' => metadataRec.TECH_SoftwareVendorName__c,
            'SoftwareVendorCode' => metadataRec.TECH_SoftwareVendorCode__c,
            'BusProcessCode' => busCode,
            'FinanInstrumentType' => FinanInstrumentType,//Values are 'LoanNmb' for loan or 'LoanApp' for Application
            'FinanInstrumentNum' => FinanInstrumentNum,
            'FileName' => FileName,
            'DocumentTypeCd' => DocumentTypeCd};
                
                for(String mapLoop : reqStringMap.keySet()){
                    mapItemCom = new WS_eTranXMLWrapper.mapItem();
                    mapItemCom.key = mapLoop;
                    mapItemCom.value = reqStringMap.get(mapLoop);
                    mapItemList.add(mapItemCom);
                }
        requestMap.item = mapItemList;
        LLC_BI__LLC_LoanDocument__c loandocUpdate = new LLC_BI__LLC_LoanDocument__c();
        LLC_BI__AccountDocument__c accdocUpdate = new LLC_BI__AccountDocument__c();
        LLC_BI__Document_Placeholder__c docPlaceholderUpdate = new LLC_BI__Document_Placeholder__c();
        
        //loandocUpdate.id = docIdMapFuture.get(dataCon.ContentDocumentId);
        recID = docIdMapFuture.get(dataCon.ContentDocumentId);
        try{
            WS_eTranObjectUpload.objectUpload_cfc objUpl = new WS_eTranObjectUpload.objectUpload_cfc();
            System.debug('##requestMap :'+requestMap);
            WS_eTranXMLWrapper.Map_x responseMap = objUpl.SharedEntryPoint(requestMap, EncodingUtil.Base64Encode(dataCon.VersionData));
            System.debug('##responseMap :'+responseMap);
            if(responseMap != null && responseMap.item.size() > 0){
                for(WS_eTranXMLWrapper.mapItem rec : responseMap.item){
                    if(rec.key == 'ErrorMessageEnglish' && String.isnotBlank(rec.value)){
                        status = 'Error';
                        errorMsg = rec.value;
                        break;
                    }
                    else if(rec.key == 'ResponseData' && String.isnotBlank(rec.value)){
                        status = 'Uploaded successfully';
                        errorMsg = '';
                        break;
                    }
                }
            }
            if(objectName == 'LLC_BI__LLC_LoanDocument__c'){
                loandocUpdate.Id = recID;
                loandocUpdate.EtranDocStatus__c = status;
                loandocUpdate.EtranDocErrorMessage__c = errorMsg;
                update loandocUpdate;
            }else if(objectName == 'LLC_BI__AccountDocument__c')
            {
                accdocUpdate.Id = recID;
                accdocUpdate.EtranDocStatus__c = status;
                accdocUpdate.EtranDocErrorMessage__c = errorMsg;
                update accdocUpdate;
            }else if(objectName == 'LLC_BI__Document_Placeholder__c')
            {
                docPlaceholderUpdate.Id = recID;
                docPlaceholderUpdate.EtranDocStatus__c = status;
                docPlaceholderUpdate.EtranDocErrorMessage__c = errorMsg;
                update docPlaceholderUpdate;
            }
        }
        catch(Exception e){
            if(objectName == 'LLC_BI__LLC_LoanDocument__c'){
                loandocUpdate.Id = recID;
                loandocUpdate.EtranDocStatus__c = 'Error';
                loandocUpdate.EtranDocErrorMessage__c = e.getMessage();
                update loandocUpdate;
            }else if(objectName == 'LLC_BI__AccountDocument__c')
            {
                accdocUpdate.Id = recID;
                accdocUpdate.EtranDocStatus__c = 'Error';
                accdocUpdate.EtranDocErrorMessage__c = e.getMessage();
                update accdocUpdate;
            }else if(objectName == 'LLC_BI__Document_Placeholder__c')
            {
                docPlaceholderUpdate.Id = recID;
                docPlaceholderUpdate.EtranDocStatus__c = 'Error';
                docPlaceholderUpdate.EtranDocErrorMessage__c = e.getMessage();
                update docPlaceholderUpdate;
            }
        }
    }
}