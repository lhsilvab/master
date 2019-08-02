/**
 * @author Luis Bento
 */
@isTest
public class ContentVersionDataFactory {
    
    public ContentVersion createContentVersion(String aContentLocation, String aPathOnClient, String aTitle, String aYourFiles) {
        return new ContentVersion(
            ContentLocation = aContentLocation, 
            PathOnClient = aPathOnClient, 
            Title = aTitle, 
            VersionData = EncodingUtil.base64Decode(aYourFiles)
        );
    }

}