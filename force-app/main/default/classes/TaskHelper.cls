/**
* @author Luis Bento
* @company Luis Bento
* @description Task Helper
*/
public with sharing class TaskHelper {
    
    /**
    * @author Luis Bento 
    * @description Update cases when tasks are done
    */
    public void updateCaseStatusWhenTasksAreDone(List<Task> aLstTaskNew) {
        if(aLstTaskNew == null || aLstTaskNew.isEmpty()) {
            return;
        }
        
        Set<Id> lSetCaseId = new Set<Id>();
        
        for(Task iTask : aLstTaskNew) {
            if('500'.equals(String.valueOf(iTask.WhatId).substring(0,3))) {                
                lSetCaseId.add(iTask.WhatId);
            }           
        }
        
        List<Case> lLstCases = [SELECT Id, Status FROM Case WHERE Id in: lSetCaseId];        
        List<Task> lLstAllTasksFromCases = [SELECT Id, Status, WhatId FROM Task WHERE WhatId IN: lSetCaseId];        
        List<Case> lLstCasesToUpdate = new List<Case>();        
        Integer lNumberOfTasksCompleted, lNumberOfTasksNotCompleted, lNumberOfTasks;
        
        for(Case iCase : lLstCases) {
            
            lNumberOfTasksCompleted = 0;
            lNumberOfTasks = 0;
            lNumberOfTasksNotCompleted = 0;
            
            for(Task iTask : lLstAllTasksFromCases) {
                if(iCase.Id == iTask.WhatId) {
                    lNumberOfTasks++;
                    if('Completed'.equals(iTask.Status)) {
                        lNumberOfTasksCompleted++;
                    } else {
                        lNumberOfTasksNotCompleted++;
                    }
                }
            }       
            
            if(lNumberOfTasksNotCompleted > 0 || lNumberOfTasks == 0) {
                iCase.Status = 'Working';
                lLstCasesToUpdate.add(iCase);
            } else if(lNumberOfTasksCompleted == lNumberOfTasks) {
                iCase.Status = 'Closed';
                lLstCasesToUpdate.add(iCase);
            }
        }
        
        if(!lLstCasesToUpdate.isEmpty()) {
            update lLstCasesToUpdate;
        }
    }
    
    /**
    * @author Luis Bento 
    * @description Update cases when tasks are done
    */
    public void fillOpportunityNameField(List<Task> aLstTaskNew) {
        if(aLstTaskNew == null || aLstTaskNew.isEmpty()) {
            return;
        }
        
        Set<Id> lSetCaseId = new Set<Id>();
        List<Task> lLstTaskWithCases = new List<Task>();
        Map<Id, List<Task>> lMapCaseWithTasks = new Map<Id, List<Task>>();
        
        for(Task iTask : aLstTaskNew) {
            if('500'.equals(String.valueOf(iTask.WhatId).substring(0,3))) {                
                lSetCaseId.add(iTask.WhatId);
                lLstTaskWithCases.add(iTask);
            }           
        }
        
        List<Case> lLstCases = [SELECT Id, Status, OpportunityName__c FROM Case WHERE Id in: lSetCaseId];
        
        for(Case iCase : lLstCases) {
            for(Task iTask : lLstTaskWithCases) {
                if(iCase.Id == iTask.WhatId) {
                    iTask.OpportunityName__c = iCase.OpportunityName__c;
                }
            }
        }
    }
}