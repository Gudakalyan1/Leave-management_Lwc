@Istest
public with sharing class OppcountTest {
    @isTest
    public static void testUpdateAcc() {
        list<Account> AccList = new list<Account> ();
        list<Opportunity> oppList = new list<Opportunity> ();
        List<OpportunityLineItem> OliList = new list <OpportunityLineItem> ();

        for(Integer i =1 ;  i<250 ;i++ ){
            Account Acc = new Account ();
            Acc.Name ='Kalyan '+ i ;
            AccList.add(Acc);
        }
        Insert AccList ;
        for(Integer i =1 ;  i<250 ;i++ ){
            Opportunity opp = new Opportunity ();
            opp.Name ='KALYAN '+i;
            opp.AccountId = AccList[i].Id;
            opp.CloseDate = System.today();
            opp.StageName ='Prospecting';
            OppList.add(opp);
    }
    Insert OppList;
       for(Opportunity opp : OppList){
        OpportunityLineItem oli = new OpportunityLineItem ();
        oli.Quantity = 4 ;
        oli.OpportunityId =opp.Id;

       }
       Insert OliList ;
       test.startTest();
       OpportunityCount.UpdateAcc(OliList);
       test.stopTest();
      list<Account> updatedAcc =[select Id ,Name ,List_price_50k__c from Account where Id IN :AccList[].Id];
      System.assertEquals(200, updatedAcc[0].List_price_50k__c, 'List_price_50k__c should be updated');

}
}