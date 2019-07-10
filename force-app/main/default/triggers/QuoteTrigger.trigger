/**
* @author Luis Bento
* @company Luis Bento
* @description Trigger for Quote
*/
trigger QuoteTrigger on Quote (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	TriggerFactory.createHandler(Quote.SObjectType);
}