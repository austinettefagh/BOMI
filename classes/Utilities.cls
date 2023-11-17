public with sharing class Utilities {

    public static void docStorageRetry(nFUSE.DocManAttachment att, Blob docContent){
        docStorageRetry(att, docContent, 5, 5); //Default to 5 retry, 5ms waitTime
    }

    public static void docStorageRetry(nFUSE.DocManAttachment att, Blob docContent, Integer remainingTries, Integer waitTime){

        try{
            
			att.storeDocument(docContent);

        } catch(Exception e) {

            handleRetryException(att, docContent, remainingTries - 1, waitTime, e);

        }
    }

    private static void handleRetryException(nFUSE.DocManAttachment att, Blob docContent, Integer remainingTries, Integer waitTime, Exception e){
        if(e.getMessage().containsIgnoreCase('unable_to_lock_row')) { //only attempt to retry with deadlocks
            if (remainingTries > 0) {
                wait(waitTime); //wait before retry
                docStorageRetry(att, docContent, remainingTries - 1, waitTime);
                return;
            } else { //if number of retries is higher then allowed
                throw e;
            }
        } else {
            throw e;
        }
    }

    private static void wait(Integer waitTime) {
		long stopTime = System.currentTimeMillis() + waitTime;
		while(true) {
			if(System.currentTimeMillis() > stopTime) {
				break;
			}
		}
	}

}