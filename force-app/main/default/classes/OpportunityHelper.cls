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
    public void beforeEvent(List<Opportunity> aLstOpportunityNew, Map<Id, Opportunity> aMapOpportunityOld) {
        if(aLstOpportunityNew == null || aLstOpportunityNew.isEmpty()) {
            return;
        }
        
        Opportunity lOldOpportunity;
        
        for(Opportunity iOpportunity : aLstOpportunityNew) {
            
            lOldOpportunity = (Opportunity) aMapOpportunityOld.get(iOpportunity.Id);
            
        }
    }
}