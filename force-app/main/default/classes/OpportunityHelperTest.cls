/**
 * @author Luis Bento
 */
@isTest
public class OpportunityHelperTest {
    
    @isTest
    static void insertSimpleOpportunity() {
        
        Opportunity lOpp = new Opportunity();
        lOpp.CloseDate = date.today().addMonths(2);
        lOpp.Name = 'test opp';
        lOpp.StageName = 'IsWon';
        
        Test.startTest();        
        
        insert lOpp;

        Test.stopTest();
        
        final List<Opportunity> lLstOpportunity = [SELECT Id FROM Opportunity];        
        final Opportunity lOriginalOpportunity = lLstOpportunity.get(0);
        
        System.assertNotEquals(null, lOriginalOpportunity);
    }
    
    @isTest
    static void updateSimpleOpportunity() {
        
        Opportunity lOpp = new Opportunity();
        lOpp.CloseDate = date.today().addMonths(2);
        lOpp.Name = 'test opp';
        lOpp.StageName = 'IsWon';
        
        Test.startTest();        
        
        insert lOpp;
        
        lOpp.Name = 'update name';
        update lOpp;

        Test.stopTest();
        
        final List<Opportunity> lLstOpportunity = [SELECT Id FROM Opportunity];        
        final Opportunity lOriginalOpportunity = lLstOpportunity.get(0);
        
        System.assertNotEquals(null, lOriginalOpportunity);
    }
}