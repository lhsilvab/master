/**
* @author Luis Bento
* @company Luis Bento
* @description Handler for Quote
*/
public with sharing class QuoteHandler implements ITrigger {
    
    private final QuoteHelper helper = new QuoteHelper();

    public void beforeInsert() {}

    public void beforeUpdate() {
        //helper.beforeEvent((List<Opportunity>) Trigger.new, (Map<Id, Opportunity>) Trigger.oldmap);
    }
    
    public void beforeDelete() {}
    public void bulkBefore() {}
    
    public void afterInsert() {}    
    public void afterUpdate() {}
    public void afterDelete() {}
    public void bulkAfter() {}
    
    public void andFinally() {}

}