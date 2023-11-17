public with sharing class AC_Account_Controller {
    public String OpptyId{get;set;}
   
    public AC_Account_Controller(){
        OpptyId = ApexPages.currentPage().getParameters().get('id');
                    
    }
     
    

    
}