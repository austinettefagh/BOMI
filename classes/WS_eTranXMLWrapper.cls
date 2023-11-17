/** 
 * WSDL class for docuemnt upload
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This is the WSDL apex class for request and response schemas
*/

public class WS_eTranXMLWrapper {
    public class mapItem {
        public String key;
        public String value;
        private String[] key_type_info = new String[]{'key','http://xml.apache.org/xml-soap',null,'1','1','true'};
        private String[] value_type_info = new String[]{'value','http://xml.apache.org/xml-soap',null,'1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://xml.apache.org/xml-soap','true','false'};
        private String[] field_order_type_info = new String[]{'key','value'};
    }
    public class Map_x {
        public WS_eTranXMLWrapper.mapItem[] item = new WS_eTranXMLWrapper.mapItem[]{};
        private String[] item_type_info = new String[]{'item','http://xml.apache.org/xml-soap',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://xml.apache.org/xml-soap','true','false'};
        private String[] field_order_type_info = new String[]{'item'};
    }
}