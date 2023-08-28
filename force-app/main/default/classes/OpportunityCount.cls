public with sharing class OpportunityCount {
    public static void UpdateAcc(list<OpportunityLineItem> newlineitem) {
        set<Id> LineitemId = new set<Id> ();
        map<Id,Decimal> oppmap = new map<Id,Decimal> ();
        list<Account> AcctoUpdate = new list<Account> ();
        for(OpportunityLineItem oli : newlineitem){
            if(oli.ListPrice !=null && oli.ListPrice >=50000){
                LineitemId.add(oli.OpportunityId);
            }
        }
       list<Opportunity> opplist = [select Id,Name,AccountId, (select Id,Name,ListPrice From OpportunityLineItems ) 
       From Opportunity Where Id IN : LineitemId ];

       IF(opplist !=null){
        for(Opportunity Opp : opplist){
            if(Opp.AccountId !=null){
             oppmap.put(Opp.AccountId,Opp.OpportunityLineItems.size());

            }
        }
       }
       list<Account> Acclist = [select Id ,Name From Account where Id IN : oppmap.keySet()];
       if(Acclist!=null){
         for(Account Acc : Acclist){
            if(oppmap !=null && oppmap.containsKey(Acc.Id)){
                Acc.List_price_50k__c = oppmap.get(Acc.Id) ;
                AcctoUpdate.add(Acc);
            }
         }
       }
       if (!AcctoUpdate.isEmpty()) {
          update AcctoUpdate;
        
       }
    }
}