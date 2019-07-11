/**
* @author Luis Bento
* @company Luis Bento
* @description Contract Helper
*/
public class ContractHelper {
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public void checkIfOpportunityAllReadyHasContract(List<Contract> aLstContractNew) {        
        Set<Id> lSetOpportunityId = new Set<Id>();
        List<Contract> lLstContractWithOpportunity = new List<Contract>();
        
        for(Contract iContract : aLstContractNew) {
            if(String.isNotBlank(iContract.Opportunity__c)) {
                lSetOpportunityId.add(iContract.Opportunity__c);
                lLstContractWithOpportunity.add(iContract);
            }
        }
        
        Map<Id, Opportunity> lMapOpportunitiesFromContracts = getOpportunitiesFromContracts(lSetOpportunityId);
		Opportunity lOpportunity;
        
		for(Contract iContract : lLstContractWithOpportunity) {            
            lOpportunity = lMapOpportunitiesFromContracts.get(iContract.Opportunity__c);                        
            if(String.isNotBlank(lOpportunity.ContractId)) {
                iContract.addError('A oportunidade (' + lOpportunity.Name + ') já possui um contrato cadastrado, edite o contrato atual, ou remova e cadastre um novo.');
            }
        }
    }
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public void setContractToOpportunity(List<Contract> aLstContractNew) {
        Set<Id> lSetOpportunityId = new Set<Id>();
        List<Contract> lLstContractWithOpportunity = new List<Contract>();
        
        for(Contract iContract : aLstContractNew) {
            if(String.isNotBlank(iContract.Opportunity__c)) {
                lSetOpportunityId.add(iContract.Opportunity__c);
                lLstContractWithOpportunity.add(iContract);
            }
        }
        
        List<Opportunity> lLstOpportunitiesFromContracts = getOpportunitiesFromContracts(lSetOpportunityId).values();        
        List<Opportunity> lLstOpportunitiesToUpdate = getOpportunitiesToUpdate(lLstContractWithOpportunity, lLstOpportunitiesFromContracts);
        
        if(!lLstOpportunitiesToUpdate.isEmpty()) {
            update lLstOpportunitiesToUpdate;
        }
    }
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public Map<Id, Opportunity> getOpportunitiesFromContracts(Set<Id> aSetOpportunityId) {
        return new Map<Id, Opportunity>([SELECT Id, Name, ContractId FROM Opportunity WHERE Id in: aSetOpportunityId]);
    }
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public List<Opportunity> getOpportunitiesToUpdate(List<Contract> aLstContractWithOpportunity, List<Opportunity> aLstOpportunitiesFromContracts) {        
        List<Opportunity> lLstOpportunitiesToUpdate = new List<Opportunity>();        
        for(Contract iContract : aLstContractWithOpportunity) {
            for(Opportunity iOpp : aLstOpportunitiesFromContracts) {
                if(iContract.Opportunity__c == iOpp.Id && String.isBlank(iOpp.ContractId)) {
                    iOpp.ContractId = iContract.Id;
                    lLstOpportunitiesToUpdate.add(iOpp);
                }
            }
        }        
        return lLstOpportunitiesToUpdate;
    }
}