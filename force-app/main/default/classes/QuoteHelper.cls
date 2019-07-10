/**
* @author Luis Bento
* @company Luis Bento
* @description Quote Helper
*/
public with sharing class QuoteHelper {
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public void checkPermissionToUpdateExpirationDate(List<Quote> aLstQuoteNew, Map<Id, Quote> aMapQuoteOld) {
        
        Map<Id, Profile> lMapProfiles = getAllProfiles();             
        Quote lQuoteOld;
        String lProfileName;
        
        for(Quote iQuote : aLstQuoteNew) {
            
            lQuoteOld = aMapQuoteOld.get(iQuote.Id);
            lProfileName = lMapProfiles.get(UserInfo.getProfileId()).Name;
            
            if('Administrador do sistema'.equals(lProfileName) && iQuote.ExpirationDate != lQuoteOld.ExpirationDate) {
                iQuote.addError('Você não tem permissão para editar o campo Data de Validade');
            }
        }
    }
    
    public Map<Id, Profile> getAllProfiles() {
 		return new Map<Id, Profile>([SELECT Id, Name FROM Profile]);       
    }
}