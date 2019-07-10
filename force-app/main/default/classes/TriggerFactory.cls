/**
* Used to instantiate and execute Trigger Handlers associated with sObjects.
*/
public with sharing class TriggerFactory {
    
    /**
    * Creates and executes a trigger handler
    *
    * @param soType Object type to process (SObject.sObjectType)
    * @throws TriggerException if no handler has been coded.
    */
    public static void createHandler(Schema.sObjectType soType) {
        ITrigger handler = getHandler(soType);
        if (handler == null) {
            throw new TriggerFactoryException('No Trigger Handler registered for Object Type: ' + soType);
        }
        
        execute(handler);
    }
    
    private static void execute(ITrigger handler) {
        
        if (Trigger.isBefore) {
            
            handler.bulkBefore();
            
            if (Trigger.isInsert) { handler.beforeInsert(); }
            else if (Trigger.isUpdate) { handler.beforeUpdate(); }
            else if (Trigger.isDelete) { handler.beforeDelete(); }
        }
        
        if (Trigger.isAfter) {
            handler.bulkAfter();
            
            if (Trigger.isInsert) { handler.afterInsert(); }
            else if (Trigger.isUpdate) { handler.afterUpdate(); }
            else if (Trigger.isDelete) { handler.afterDelete(); }            
        }
        
        handler.andFinally();
    }
    
    private static ITrigger getHandler(Schema.sObjectType soType) {
        if (soType == Opportunity.sObjectType) {
            return new OpportunityHandler();
        }
        if (soType == Quote.sObjectType) {
            return new QuoteHandler();
        }
        return null;
    }
    
    public class TriggerFactoryException extends Exception {}
}