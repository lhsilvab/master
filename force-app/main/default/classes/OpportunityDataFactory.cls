/**
 * @author Luis Bento
 */
@isTest
public class OpportunityDataFactory {
    
    public Opportunity createOpportunity(String name, String stageName, Date closeDate) {
        return new Opportunity(Name = name, StageName = stageName, CloseDate = closeDate);
    }
    
    public Opportunity createOpportunity(String name, String stageName, Date closeDate, Id accountId) {
        return new Opportunity(Name = name, StageName = stageName, CloseDate = closeDate, AccountId = accountId);
    }
    
    public Opportunity createOpportunityForQuote(String name, String stageName, Date closeDate, Id pricebook) {
        return new Opportunity(Name = name, StageName = stageName, CloseDate = closeDate, Pricebook2Id = pricebook);
    }
}