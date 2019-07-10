/**
* @author Luis Bento
* @company Luis Bento
* @description Handler for Quote
*/
public with sharing class QuoteHandler implements ITrigger {
    
    private final QuoteHelper lHelper = new QuoteHelper();

    public void beforeInsert() {}

    public void beforeUpdate() {
        lHelper.checkPermissionToUpdateExpirationDate((List<Quote>) Trigger.new, (Map<Id, Quote>) Trigger.oldmap);
    }
    
    public void beforeDelete() {}
    public void bulkBefore() {}
    
    public void afterInsert() {}    
    public void afterUpdate() {}
    public void afterDelete() {}
    public void bulkAfter() {}
    
    public void andFinally() {}

}