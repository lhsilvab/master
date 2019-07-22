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
    static void checkProfilePermissionForUpdateExpirationDate() {
        
        Quote lQuote = new Quote();
        lQuote.Name = 'teste';
        lQuote.OpportunityId = [SELECT Id FROM Opportunity LIMIT 1].Id;
        
        Profile lProfile = [SELECT Id from Profile WHERE Name = 'Precificação'];
        
        User lUser = new User(
            Alias = 'tstprec',
            Email='testeprecificacao@testorg.com',
            EmailEncodingKey='UTF-8',
            LastName='Testing',
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US',
            ProfileId = lProfile.Id, 
            TimeZoneSidKey='America/Los_Angeles',
            UserName='testeprecificacao@testorg.com'
        );
        
        Test.startTest();
        
        insert lQuote;
        
        lQuote.ExpirationDate = Date.newInstance(1960, 2, 17);
        
        System.runAs(lUser) {
            try {
                update lQuote;
            } catch(DMLException e) {
                system.debug('check profile: ' + e.getMessage());
                System.assert(e.getMessage().contains('Você não tem permissão para editar o campo Data de Validade'));
                System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
            }
        }

        Test.stopTest();
    }
    
    @isTest
    static void checkWithOneGroupPermissionForUpdateExpirationDate() {
        
        Group lFirstGroup = new Group(
            Name = 'Comercial'
        );
        insert lFirstGroup;
        
        Quote__c lQuoteCustomSetting = new Quote__c(
            GroupsExpirationDate__c = lFirstGroup.Id
        );        
        insert lQuoteCustomSetting;
        
        Quote lQuote = new Quote();
        lQuote.Name = 'teste';
        lQuote.OpportunityId = [SELECT Id FROM Opportunity LIMIT 1].Id;
        
        Test.startTest();
        
        insert lQuote;
        
        lQuote.ExpirationDate = Date.newInstance(1960, 2, 17);
        
        try {
            update lQuote;
        } catch(DMLException e) {
			system.debug('check one: ' +e.getMessage());            
            System.assert(e.getMessage().contains('Este campo não pode ser editado, faça a solicitação para Planejamento Comercial.'));
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }

        Test.stopTest();
    }
    
    @isTest
    static void checkWithTwoGroupsPermissionForUpdateExpirationDate() {
        
        Group lFirstGroup = new Group(
            Name = 'First Comercial'
        );
        insert lFirstGroup;
        
        Group lSecondGroup = new Group(
            Name = 'Second Comercial'
        );
        insert lSecondGroup;
        
        Quote__c lQuoteCustomSetting = new Quote__c(
            GroupsExpirationDate__c = String.valueOf(lFirstGroup.Id + ',' + lSecondGroup.Id)
        );        
        insert lQuoteCustomSetting;
        
        Quote lQuote = new Quote();
        lQuote.Name = 'teste';
        lQuote.OpportunityId = [SELECT Id FROM Opportunity LIMIT 1].Id;
        
        Test.startTest();
        
        insert lQuote;
        
        lQuote.ExpirationDate = Date.newInstance(1960, 2, 17);
        
        try {
            update lQuote;
        } catch(DMLException e) {
            system.debug('check two: ' + e.getMessage());
            System.assert(e.getMessage().contains('Este campo não pode ser editado, faça a solicitação para Planejamento Comercial.'));
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }

        Test.stopTest();
    }
    
    @isTest
    static void checkWithCustomLabelPermissionForUpdateExpirationDate() {

        Quote lQuote = new Quote();
        lQuote.Name = 'teste';
        lQuote.OpportunityId = [SELECT Id FROM Opportunity LIMIT 1].Id;
        
        Test.startTest();
        
        insert lQuote;
        
        lQuote.ExpirationDate = Date.newInstance(1960, 2, 17);
        
        try {
            update lQuote;
        } catch(DMLException e) {
            System.assert(e.getMessage().contains('Este campo não pode ser editado, faça a solicitação para Planejamento Comercial.'));
            System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0));
        }

        Test.stopTest();
    }
}