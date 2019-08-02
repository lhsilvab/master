/**
* @author Luis Bento
*/
@isTest
public class CheckOpportunityHasAttachmentTest {
    
    @isTest
    static void checkIfHasNoAttachment() {
        
        String lName = 'nome';
        Date lDataFechamento = Date.newInstance(2019, 01, 01);
        
        Opportunity lOpp = new OpportunityDataFactory().createOpportunity(lName, 'Stand-by', lDataFechamento);
        lOpp.StageName = 'Negociação';
        
        Test.startTest();        
        
        insert lOpp;
        
        Test.stopTest();
        
        DMLException ex;
        
        try {
            lOpp.StageName = 'Desenvolvimento';
            update lOpp; 
        }
        catch (Exception e) {
            if (e instanceof DMLException) {
                ex = (DMLException) e;
            }
        }        
        
        System.assert(ex.getMessage().contains('Necessário anexar a documentação técnica do Cliente para concluir a fase de Negociação da Oportunidade.'));
        System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', ex.getDmlStatusCode(0));
    }
    
    @isTest
    static void checkIfHasAttachment() {
        
        String lName = 'nome';
        Date lDataFechamento = Date.newInstance(2019, 01, 01);
        String lYourFiles = 'testo';
        String lPathOnClient = 'caminho';
        String lTitle = 'titulo';
        
        Opportunity lOpp = new OpportunityDataFactory().createOpportunity(lName, 'Stand-by', lDataFechamento);
        lOpp.StageName = 'Negociação';
 
        ContentVersion lContentVersion = new ContentVersionDataFactory().createContentVersion('S', lPathOnClient + '.png', lTitle, lYourFiles);
        ContentDocumentLink lContentDocumentLink = new ContentDocumentLinkDataFactory().createContentDocumentLink('I', 'AllUsers');
        
        Test.startTest();        
        
        insert lOpp;
        insert lContentVersion;
        
		Id lContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :lContentVersion.Id].ContentDocumentId;
        lContentDocumentLink.ContentDocumentId = lContentDocumentId;
        lContentDocumentLink.LinkedEntityId = lOpp.Id;
        insert lContentDocumentLink;
        
        lOpp.StageName = 'Desenvolvimento';
        update lOpp;
        
        Test.stopTest();
        
        final List<Opportunity> lLstOpportunity = [SELECT Id FROM Opportunity];        
        final Opportunity lOriginalOpportunity = lLstOpportunity.get(0);        
        final List<ContentDocumentLink> lLstContentDocumentLink = [SELECT LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId = :lOriginalOpportunity.Id];
        final ContentDocumentLink lOriginalContentDocumentLink = lLstContentDocumentLink.get(0);
        
        System.assertEquals(lOriginalContentDocumentLink.LinkedEntityId, lOriginalOpportunity.Id);
    }
}