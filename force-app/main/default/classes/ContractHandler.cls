/**
* @author Luis Bento
* @company Luis Bento
* @description Handler for Contract
*/
public class ContractHandler implements ITrigger {
    
    private final ContractHelper lHelper = new ContractHelper();

    public void beforeInsert() {
        lHelper.checkIfOpportunityAllReadyHasContract((List<Contract>) Trigger.new);
    }

    public void beforeUpdate() {}    
    public void beforeDelete() {}
    public void bulkBefore() {}
    
    public void afterInsert() {
        lHelper.setContractToOpportunity((List<Contract>) Trigger.new);
    }
    
    public void afterUpdate() {}
    public void afterDelete() {}
    public void bulkAfter() {}
    
    public void andFinally() {}
}