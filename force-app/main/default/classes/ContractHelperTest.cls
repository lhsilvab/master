/**
 * @author Luis Bento
 */
@isTest
public class ContractHelperTest {
    
    @isTest
    static void checkIfOpportunityAllReadyHasContract() {
        
        Opportunity lOpp = new Opportunity();
        lOpp.CloseDate = date.today().addMonths(2);
        lOpp.Name = 'test opp';
        lOpp.StageName = 'IsWon';
        
        Contract lContract = new Contract();
        lContract.Status = '';
        lContract.StartDate = date.today().addMonths(2);
        lContract.ContractTerm = 12;
        
        Account lAccount = new Account();
        lAccount.Name = 'teste acc';        
        
        Test.startTest();        
        
        insert lOpp;
        insert lAccount;
        
        lContract.AccountId = lAccount.Id;
        lContract.Opportunity__c = lOpp.Id;
        insert lContract;        

        Test.stopTest();
        
        lContract = new Contract();
        lContract.Status = '';
        lContract.StartDate = date.today().addMonths(2);
        lContract.ContractTerm = 12;
        lContract.AccountId = lAccount.Id;
        lContract.Opportunity__c = lOpp.Id;
        
        try {
            insert lContract;
        } catch(DmlException e) {
            System.assert(e.getMessage().contains('A oportunidade (' + lOpp.Name + ') já possui um contrato cadastrado, edite o contrato atual, ou remova e cadastre um novo.'));
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }
    }
    
    @isTest
    static void insertContractInOpportunity() {
        
        Opportunity lOpp = new Opportunity();
        lOpp.CloseDate = date.today().addMonths(2);
        lOpp.Name = 'test opp';
        lOpp.StageName = 'IsWon';
        
        Contract lContract = new Contract();
        lContract.Status = '';
        lContract.StartDate = date.today().addMonths(2);
        lContract.ContractTerm = 12;
        
        Account lAccount = new Account();
        lAccount.Name = 'teste acc';        
        
        Test.startTest();        
        
        insert lOpp;
        insert lAccount;
        
        lContract.AccountId = lAccount.Id;
        lContract.Opportunity__c = lOpp.Id;
        insert lContract;

        Test.stopTest();
        
        final List<Opportunity> lLstOpportunity = [SELECT Id, ContractId FROM Opportunity];        
        final Opportunity lOriginalOpportunity = lLstOpportunity.get(0);
        
        System.assertEquals(lContract.Id, lOriginalOpportunity.ContractId);
    }
}