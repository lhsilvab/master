/**
* @author Luis Bento
* @company Luis Bento
* @description Trigger for Contract
*/
trigger ContractTrigger on Contract (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	TriggerFactory.createHandler(Contract.SObjectType);
}