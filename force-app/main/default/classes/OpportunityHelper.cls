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
}