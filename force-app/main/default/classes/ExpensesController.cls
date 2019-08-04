public with sharing class ExpensesController {
    
    @AuraEnabled
    public static List<Expense__c> getExpenses() {
        
        // Check to make sure all fields are accessible to this user
        String[] fieldsToCheck = new String[] {
            'Id', 'Name', 'Amount__c', 'Client__c', 'Date__c', 
            'Reimbursed__c', 'Email__c', 'CreatedDate'
        };
        
        Map<String,Schema.SObjectField> fieldDescribeTokens = 
            Schema.SObjectType.Expense__c.fields.getMap();
        
        for(String field : fieldsToCheck) {
            if( ! fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }
        
        List<Expense__c> lLstExpenses = [SELECT Id, Name, Amount__c, Client__c, Date__c, 
                                         Reimbursed__c, Email__c, CreatedDate 
                                         FROM Expense__c];
        
        for(Expense__c iExpense : lLstExpenses) {
            if(String.isNotBlank(iExpense.Email__c)) {
                iExpense.Email__c = iExpense.Email__c.replaceAll('(^[^@]{3}|(?!^)\\G)[^@]', '$1*');                
            }
        }
        
        // OK, they're cool, let 'em through
        return lLstExpenses;
    }
    
    @AuraEnabled
    public static Expense__c saveExpense(Expense__c expense) {
        // Perform isUpdateable() checking first, then
        upsert expense;
        return expense;
    }
}