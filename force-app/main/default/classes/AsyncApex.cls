public abstract class AsyncApex extends QueueableBase {
    private AsyncApex parentJob;
    private static final Map<String, Object> staticResults = new Map<String, Object>();
    private final Map<String, Object> results = new Map<String, Object>();
    public static fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new List<SObjectType> {SObjectType.Account.getSObjectType()});


    public Object result;
    public AsyncApex currentJob;

    public AsyncApex(String name) {
        super(name);
    }

    protected abstract Object work();

    public override void doLogic() {
        try {
            System.debug('this results ' + this.results);
            this.result = this.work();
            staticResults.put(this.name, this.result);

            // still need a better way 
            if (this.parentJob == null) {
                System.debug('commit work');
                uow.commitWork();
                System.debug('method finished');
            }
        }
        catch(AsyncException e) {
            System.debug('message' + e.getMessage());
            this.currentJob.doLogic();

            System.debug('execute ' + this.currentJob.name);
            this.results.putAll(staticResults);
            this.currentJob = null;

            QueueableBase.enqueueJob(this);
        }
    }
    
    public Object await(AsyncApex job) {
        job.parentJob = this;
        if (!results.containsKey(job.name)) {
            this.currentJob = job;
            throw new AsyncException();
        }

        return results.get(job.name);
    }

    public class AsyncException extends Exception {

    }

/**
 * Example code:
 * 
 * List<Lead> leads = [SELECT Id, FirstName, LastName, Product__c FROM Lead]; // take non-converted
 * 
 * List<Account> newAccounts = (List<Account>) await (new SapConvertLeads(leads));
 * insert newAccounts;
 * 
 * Set<Id> productIds = CollectionUtils.pickIds(leads, Lead.Product__c);
 * List<Product2> products = [SELECT Id, Sap_Id__c FROM Product2 WHERE Id IN :productIds];
 * 
 * Set<String> productSapIds = CollectionUtils.pickStrings(products, Product2.Sap_Id__c);
 * List<SapProductWrapper> additionalInfo = (List<SapProductWrapper>) await (new SapGetProductInfos(productSapIds));
 * 
 * List<Product2> updatedProducts = updateProducts(additionalInfo);
 * 
 * return updatedProducts; 
 */
}
