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
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public void updateOpportunityName(List<Opportunity> aLstOpportunityNew) {
        if(aLstOpportunityNew == null || aLstOpportunityNew.isEmpty()) {
            return;
        }
        
        Set<Id> lSetIdAccounts = new Set<Id>();
        
        for(Opportunity iOpportunity : aLstOpportunityNew) {
            
            if(String.isNotBlank(iOpportunity.AccountId)) {
                lSetIdAccounts.add(iOpportunity.AccountId);
            }
        }
        
        Map<Id, Account> lMapAccountsFromOpportunities = new Map<Id, Account>([SELECT Id, Name FROM Account WHERE Id in :lSetIdAccounts]);
        
        String lAccountName, lProduct, lCampaign;
        Account lAccountFromOpportunity;
        
        for(Opportunity iOpportunity : aLstOpportunityNew) {
            
            lAccountFromOpportunity = lMapAccountsFromOpportunities.get(iOpportunity.AccountId);
            
            if(lAccountFromOpportunity != null) {
                lAccountName = lAccountFromOpportunity.Name;
            }
            
            if(String.isNotBlank(iOpportunity.Product__c)) {
                lProduct = iOpportunity.Product__c;
            }
            
            if(String.isNotBlank(iOpportunity.Campaign__c)) {
                lCampaign = iOpportunity.Campaign__c;
            }
            
            iOpportunity.Name = String.isNotBlank(lAccountName) ? lAccountName : '';
            iOpportunity.Name += String.isNotBlank(lAccountName) ? ' - ' + lProduct : lProduct;
            iOpportunity.Name += String.isNotBlank(lProduct) || String.isNotBlank(lAccountName) ? ' - ' + lCampaign : lCampaign;
        }
    }
}