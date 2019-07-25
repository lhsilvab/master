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
        lHelper.updateCasesWhenTasksAreDone((List<Task>) Trigger.new);
    }
    public void afterDelete() {
        lHelper.updateCasesWhenTasksAreDone((List<Task>) Trigger.old);
    }
    public void bulkAfter() {}
    
    public void andFinally() {}

}