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
        checkProfilePermissionToUpdateExpirationDate(aLstQuoteNew, aMapQuoteOld);        
    }
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public void checkProfilePermissionToUpdateExpirationDate(List<Quote> aLstQuoteNew, Map<Id, Quote> aMapQuoteOld) {
        
        Map<Id, Profile> lMapProfiles = getAllProfiles();             
        Quote lQuoteOld;
        String lProfileName;
        
        for(Quote iQuote : aLstQuoteNew) {
            
            lQuoteOld = aMapQuoteOld.get(iQuote.Id);
            lProfileName = lMapProfiles.get(UserInfo.getProfileId()).Name;
            
            if('Precificação'.equals(lProfileName) && iQuote.ExpirationDate != lQuoteOld.ExpirationDate) {
                iQuote.addError('Você não tem permissão para editar o campo Data de Validade');
            } else {
                checkWithCustomSettingGroupPermissionToUpdateExpirationDate(aLstQuoteNew, aMapQuoteOld);
        		checkWithCustomLabelGroupPermissionToUpdateExpirationDate(aLstQuoteNew, aMapQuoteOld);
            }
        }
    }
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public Map<Id, Profile> getAllProfiles() {
        return new Map<Id, Profile>([SELECT Id, Name FROM Profile]);       
    }
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public void checkWithCustomSettingGroupPermissionToUpdateExpirationDate(List<Quote> aLstQuoteNew, Map<Id, Quote> aMapQuoteOld) {
        
        List<String> lLstGroupsExpirationDate = new List<String>();        
        Quote__c aQuoteCustomSettings = Quote__c.getInstance();
        
        if(!String.isBlank(aQuoteCustomSettings.GroupsExpirationDate__c)) {
            
            if(aQuoteCustomSettings.GroupsExpirationDate__c.contains(',')) {
                lLstGroupsExpirationDate = aQuoteCustomSettings.GroupsExpirationDate__c.split(',');            
            } else {
                lLstGroupsExpirationDate.add(aQuoteCustomSettings.GroupsExpirationDate__c);
            }
            
            Set<Id> lSetIdGroups = new Set<Id>();
            for(String iGroupId : lLstGroupsExpirationDate) {
                lSetIdGroups.add((Id) iGroupId);
            }
            
            Map<Id, GroupMember> lMapGroupMembersWithPermission = getGroupMembers(lSetIdGroups);
            Set<Id> lSetIdGroupMembers = new Set<Id>();
            for(GroupMember iGroupMember : lMapGroupMembersWithPermission.values()) {
                lSetIdGroupMembers.add(iGroupMember.UserOrGroupId);
            }
            
            Quote lQuoteOld;
            for(Quote iQuote : aLstQuoteNew) {
                lQuoteOld = aMapQuoteOld.get(iQuote.Id);
                if(!lSetIdGroupMembers.contains(UserInfo.getUserId()) && iQuote.ExpirationDate != lQuoteOld.ExpirationDate) {
                    iQuote.addError('Este campo não pode ser editado, faça a solicitação para Planejamento Comercial.');
                }                            
            }
        }
    }
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public void checkWithCustomLabelGroupPermissionToUpdateExpirationDate(List<Quote> aLstQuoteNew, Map<Id, Quote> aMapQuoteOld) {
                
        List<String> lLstGroupsExpirationDate = new List<String>();        
        
        if(!String.isBlank(Label.GroupExpirationDate)) {
            
            if(Label.GroupExpirationDate.contains(',')) {
            	lLstGroupsExpirationDate = Label.GroupExpirationDate.split(',');            
            } else {
            	lLstGroupsExpirationDate.add(Label.GroupExpirationDate);
            }
            
            Set<Id> lSetIdGroups = new Set<Id>();
            for(String iGroupId : lLstGroupsExpirationDate) {
                lSetIdGroups.add((Id) iGroupId);
            }
            
            Map<Id, GroupMember> lMapGroupMembersWithPermission = getGroupMembers(lSetIdGroups);
            Set<Id> lSetIdGroupMembers = new Set<Id>();
            for(GroupMember iGroupMember : lMapGroupMembersWithPermission.values()) {
                lSetIdGroupMembers.add(iGroupMember.UserOrGroupId);
            }
            
            Quote lQuoteOld;
            for(Quote iQuote : aLstQuoteNew) {
                lQuoteOld = aMapQuoteOld.get(iQuote.Id);
                if(!lSetIdGroupMembers.contains(UserInfo.getUserId()) && iQuote.ExpirationDate != lQuoteOld.ExpirationDate) {
                    iQuote.addError('Este campo não pode ser editado, faça a solicitação para Planejamento Comercial.');
                }                            
            }
        }
    }
    
    /**
    * @author Luis Bento 
    * @description Undefined
    */
    public Map<Id, GroupMember> getGroupMembers(Set<Id> aSetIdGroups) {
        return new Map<Id, GroupMember>([SELECT Id, GroupId, UserOrGroupId FROM GroupMember WHERE GroupId in: aSetIdGroups]);       
    }
}