/**
 * @author Luis Bento
 */
@isTest
public class QuoteHelperTest {
    
    @testSetup
    static void setup() {
        Opportunity lOpp = new Opportunity();
        lOpp.CloseDate = date.today().addMonths(2);
        lOpp.Name = 'test opp';
        lOpp.StageName = 'IsWon';        
        
        insert lOpp;
    }
    
    @isTest
    static void checkPermissionForUpdateExpirationDate() {
        
        Quote lQuote = new Quote();
        lQuote.Name = 'teste';
        lQuote.OpportunityId = [SELECT Id FROM Opportunity LIMIT 1].Id;
        
        Test.startTest();
        
        insert lQuote;
        
        lQuote.ExpirationDate = Date.newInstance(1960, 2, 17);
        
        try {
            update lQuote;
        } catch(DMLException e) {            
            System.assert(e.getMessage().contains('Você não tem permissão para editar o campo Data de Validade'));
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }

        Test.stopTest();
    }
}