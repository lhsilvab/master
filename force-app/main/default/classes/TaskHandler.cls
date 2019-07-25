/**
* @author Luis Bento
* @company Luis
* @description Handler for Task
*/
public with sharing class TaskHandler implements ITrigger {
    
    private final TaskHelper lHelper = new TaskHelper();

    public void beforeInsert() {}
    public void beforeUpdate() {}    
    public void beforeDelete() {}
    public void bulkBefore() {}
    
    public void afterInsert() {}    
    public void afterUpdate() {
        lHelper.updateCasesWhenTaskAreDone((List<Task>) Trigger.new);
    }
    public void afterDelete() {}
    public void bulkAfter() {}
    
    public void andFinally() {}

}