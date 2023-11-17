/** 
 * WSDL class for documents upload 
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This is the WSDL apex class and it has the request and response schema for uploading the documents
*/

public class WS_eTranObjectUpload {
    public class SharedEntryPoint_element {
        public WS_eTranXMLWrapper.Map_x Inputs;
        public String InputFile;
        private String[] Inputs_type_info = new String[]{'Inputs','http://ws.elend',null,'1','1','false'};
        private String[] InputFile_type_info = new String[]{'InputFile','http://ws.elend',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://ws.elend','true','false'};
        private String[] field_order_type_info = new String[]{'Inputs','InputFile'};
    }
    public class SharedEntryPointResponse_element {
        public WS_eTranXMLWrapper.Map_x SharedEntryPointReturn;
        private String[] SharedEntryPointReturn_type_info = new String[]{'SharedEntryPointReturn','http://ws.elend',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://ws.elend','true','false'};
        private String[] field_order_type_info = new String[]{'SharedEntryPointReturn'};
    }
    public class objectUpload_cfc {
        public String endpoint_x = 'https://catweb2.sba.gov/elend/ws/objectUpload.cfc';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x = 120000;
        private String[] ns_map_type_info = new String[]{'http://rpc.xml.coldfusion', 'WS_rpcXmlColdfusion', 'http://xml.apache.org/xml-soap', 'WS_xmlApacheOrgXmlSoap', 'http://ws.elend', 'WS_wsElend'};
        public WS_eTranXMLWrapper.Map_x SharedEntryPoint(WS_eTranXMLWrapper.Map_x Inputs,String InputFile) {
            WS_eTranObjectUpload.SharedEntryPoint_element request_x = new WS_eTranObjectUpload.SharedEntryPoint_element();
            request_x.Inputs = Inputs;
            request_x.InputFile = InputFile;
            WS_eTranObjectUpload.SharedEntryPointResponse_element response_x;
            Map<String, WS_eTranObjectUpload.SharedEntryPointResponse_element> response_map_x = new Map<String, WS_eTranObjectUpload.SharedEntryPointResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '',
              'http://ws.elend',
              'SharedEntryPoint',
              'http://ws.elend',
              'SharedEntryPointResponse',
              'WS_eTranObjectUpload.SharedEntryPointResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.SharedEntryPointReturn;
        }
    }
}