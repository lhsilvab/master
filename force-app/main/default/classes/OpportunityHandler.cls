/**
* @author Luis Bento
* @company Luis
* @description Handler for Opportunity
*/
public with sharing class OpportunityHandler implements ITrigger{

 	private final OpportunityHelper helper = new OpportunityHelper();

    public void beforeInsert() {}

    public void beforeUpdate() {
        helper.beforeEvent((List<Opportunity>) Trigger.new, (Map<Id, Opportunity>) Trigger.oldmap);
    }
    
    public void beforeDelete() {}
    public void bulkBefore() {}
    
    public void afterInsert() {}    
    public void afterUpdate() {}
    public void afterDelete() {}
    public void bulkAfter() {}
    
    public void andFinally() {}
}