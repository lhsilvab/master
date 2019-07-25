/**
* @author Luis Bento
* @company Luis
* @description Handler for Opportunity
*/
public with sharing class OpportunityHandler implements ITrigger {

 	private final OpportunityHelper lHelper = new OpportunityHelper();

    public void beforeInsert() {
        lHelper.beforeInsertEvent((List<Opportunity>) Trigger.new);
    }

    public void beforeUpdate() {
        lHelper.beforeUpdateEvent((List<Opportunity>) Trigger.new, (Map<Id, Opportunity>) Trigger.oldmap);
        lHelper.checkIfHasAttachment((List<Opportunity>) Trigger.new);
    }
    
    public void beforeDelete() {}
    public void bulkBefore() {}
    
    public void afterInsert() {}    
    public void afterUpdate() {}
    public void afterDelete() {}
    public void bulkAfter() {}
    
    public void andFinally() {}
}