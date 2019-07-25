/**
 * @author Luis Bento
 */
@isTest
public class TaskHelperTest {
    
    @isTest
    static void updateCaseStatusWhenTasksAreDone() {
        
        Profile lProfile = [SELECT Id from Profile WHERE Name = 'Precificação'];
        
        User lUser = new User(
            Alias = 'tstprec',
            Email='testeprecificacao@testorg.com',
            EmailEncodingKey='UTF-8',
            LastName='Testing',
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US',
            ProfileId = lProfile.Id, 
            TimeZoneSidKey='America/Los_Angeles',
            UserName='testeprecificacao@testorg.com'
        );
        
        Case lCase = new Case();
        lCase.Status = 'New';
        lCase.Origin = 'Phone';
        
        Task lTask = new Task();
        lTask.WhoId = lUser.Id;
        lTask.Status = 'Not Started';
        lTask.Subject = 'teste';
        lTask.Priority = 'Normal';
        
        Test.startTest();        
        
        insert lCase;
        lTask.WhatId = lCase.Id;
        insert lTask;
        lTask.Status = 'Completed';
        update lTask;

        Test.stopTest();
    }
    
    @isTest
    static void updateCaseStatusWhenTasksAreNotDone() {
        
        Profile lProfile = [SELECT Id from Profile WHERE Name = 'Precificação'];
        
        User lUser = new User(
            Alias = 'tstprec',
            Email='testeprecificacao@testorg.com',
            EmailEncodingKey='UTF-8',
            LastName='Testing',
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US',
            ProfileId = lProfile.Id, 
            TimeZoneSidKey='America/Los_Angeles',
            UserName='testeprecificacao@testorg.com'
        );
        
        Case lCase = new Case();
        lCase.Status = 'New';
        lCase.Origin = 'Phone';
        
        List<Task> lLstTaskToInsert = new List<Task>();
        
        Task lTask = new Task();
        lTask.WhoId = lUser.Id;
        lTask.Status = 'Not Started';
        lTask.Subject = 'teste';
        lTask.Priority = 'Normal';
        
        Task lTaskB = new Task();
        lTaskB.WhoId = lUser.Id;
        lTaskB.Status = 'Not Started';
        lTaskB.Subject = 'teste';
        lTaskB.Priority = 'Normal';
        
        Test.startTest();        
        
        insert lCase;
        
        lTask.WhatId = lCase.Id;
        lTaskB.WhatId = lCase.Id;
        
        lLstTaskToInsert.add(lTask);
        lLstTaskToInsert.add(lTaskB);
        
        insert lLstTaskToInsert;
        
        lTask.Status = 'Completed';
        update lTask;

        Test.stopTest();
    }
    
    @isTest
    static void updateCaseStatusWhenTasksAreDeleted() {
        
        Profile lProfile = [SELECT Id from Profile WHERE Name = 'Precificação'];
        
        User lUser = new User(
            Alias = 'tstprec',
            Email='testeprecificacao@testorg.com',
            EmailEncodingKey='UTF-8',
            LastName='Testing',
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US',
            ProfileId = lProfile.Id, 
            TimeZoneSidKey='America/Los_Angeles',
            UserName='testeprecificacao@testorg.com'
        );
        
        Case lCase = new Case();
        lCase.Status = 'New';
        lCase.Origin = 'Phone';
        
        Task lTask = new Task();
        lTask.WhoId = lUser.Id;
        lTask.Status = 'Not Started';
        lTask.Subject = 'teste';
        lTask.Priority = 'Normal';
        
        Test.startTest();        
        
        insert lCase;
        lTask.WhatId = lCase.Id;
        insert lTask;
        lTask.Status = 'Completed';
        update lTask;
        
        delete lTask;

        Test.stopTest();
    }
}