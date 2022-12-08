// delete [SELECT Id FROM Product2 WHERE Sap_Id__c = 'aaaa'];
// delete [SELECT Id FROM Lead WHERE Company = 'Home'];
// delete [SELECT Id FROM Account WHERE Name = 'Test Double'];
// Product2 product = new Product2(Name = 'test', Sap_Id__c = 'aaaa');
// insert product;

// insert new Lead(FirstName = 'Test', LastName = 'Double', Product__c = product.Id, Company='Home');

// System.enqueueJob(new SampleAsync());

System.enqueueJob(new TestAsyncInception());