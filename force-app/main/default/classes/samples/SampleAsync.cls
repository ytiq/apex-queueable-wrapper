public class SampleAsync extends AsyncApex{
    
    public SampleAsync() {
        super('sample async');
    }
    public override Object work() {
        List<Lead> leads = [SELECT Id, FirstName, LastName, Product__c FROM Lead];
        
        List<Account> newAccounts = (List<Account>) await (new SapConvertLeads(leads));
        AsyncApex.uow.registerNew(newAccounts);
        
        Set<Id> productIds = CollectionUtils.pickIds (leads, Lead.Product__c);
        List<Product2> products = [SELECT Id, Sap_Id__c FROM Product2 WHERE Id IN :productIds];
        
        Set<String> productSapIds = CollectionUtils.pickStrings(products, Product2.Sap_Id__c);
        List<SapProductWrapper> additionalInfo = (List<SapProductWrapper>) await (new SapGetProductInfos(productSapIds));
        
        List<Product2> updatedProducts = updateProducts(additionalInfo);
        
        System.debug('updatedProducts ' + updatedProducts);

        return updatedProducts; 
    }


    public class SapConvertLeads extends AsyncApex {
        List<Lead> leads;
        public SapConvertLeads(List<Lead> leads) {
            super('inner test');
            
            this.leads = leads;
        }
        public override Object work() {
            List<Account> accounts = new List<Account>();

            for (Lead l : this.leads) {
                accounts.add(new Account(Name = l.FirstName + ' ' + l.LastName));
            }

            return accounts;
        }
    }

    public class SapGetProductInfos extends AsyncApex {
        Set<String> sapIds;
        public SapGetProductInfos(Set<String> sapIds) {
            super('inner test');
            
            this.sapIds = sapIds;
        }
        public override Object work() {
            List<SapProductWrapper> wrappers = new List<SapProductWrapper>();
            
            for (String id : sapIds) {
                SapProductWrapper wrapper = new SapProductWrapper();
                wrapper.id = id;

                wrappers.add(wrapper);
            }

            return wrappers;
        }
    }

    public List<Product2> updateProducts(List<SapProductWrapper> wrappers) {
        List<Product2> products = new List<Product2>();
        for (SapProductWrapper wrapper : wrappers) {
            products.add(new Product2(Name = wrapper.id));
        }

        return products;
    }

    public class SapProductWrapper{
        String id;
    }


}
