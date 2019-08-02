/**
* @author Luis Bento
* @company Luis Bento
* @description Opportunity Helper
*/
public with sharing class OpportunityHelper {
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public void beforeInsertEvent(List<Opportunity> aLstOpportunityNew) {
        if(aLstOpportunityNew == null || aLstOpportunityNew.isEmpty()) {
            return;
        }
        
        for(Opportunity iOpportunity : aLstOpportunityNew) {
            
            system.debug('iOpportunity: ' + iOpportunity);
            
        }
    }
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public void beforeUpdateEvent(List<Opportunity> aLstOpportunityNew, Map<Id, Opportunity> aMapOpportunityOld) {
        if(aLstOpportunityNew == null || aLstOpportunityNew.isEmpty()) {
            return;
        }
        
        Opportunity lOldOpportunity;
        
        for(Opportunity iOpportunity : aLstOpportunityNew) {
            
            system.debug('iOpportunity: ' + iOpportunity);
            
            lOldOpportunity = (Opportunity) aMapOpportunityOld.get(iOpportunity.Id);
            
        }
    }
    
    /**
    * @author Luis Bento 
    * @description check if Opportunity has at least one attachment
    */
    public void checkIfHasAttachment(List<Opportunity> aLstOpportunityNew, Map<Id, Opportunity> aMapOpportunityOld) {
        if(aLstOpportunityNew == null || aLstOpportunityNew.isEmpty()) {
            return;
        }        
        
        Set<Id> lSetIdOpportunities = new Set<Id>();
        List<Opportunity> lLstOpportunities = new List<Opportunity>();
        
        Opportunity lOppOld;
        
        for(Opportunity iOpp : aLstOpportunityNew) {
            lOppOld = aMapOpportunityOld.get(iOpp.Id);
            if('Negociação'.equals(lOppOld.StageName) && 
                ('Contrato'.equals(iOpp.StageName) || 'Desenvolvimento'.equals(iOpp.StageName) || 'Ativo'.equals(iOpp.StageName) || 'Cliente perdido'.equals(iOpp.StageName))) {
                lSetIdOpportunities.add(iOpp.Id);
                lLstOpportunities.add(iOpp);
            }
        }
        
        Set<Id> lLstLinkedEntityId = new Set<Id>();
        
        if(!lSetIdOpportunities.isEmpty()) {
            for(ContentDocumentLink iContentDocumentLink : [SELECT Id, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN: lSetIdOpportunities]) {
                lLstLinkedEntityId.add(iContentDocumentLink.LinkedEntityId);
            }            
            
            for(Opportunity iOpp : lLstOpportunities) {
                if(!lLstLinkedEntityId.contains(iOpp.Id)) {
                    iOpp.addError('Necessário anexar a documentação técnica do Cliente para concluir a fase de Negociação da Oportunidade.');
                }
            }            
        }        
    }
}