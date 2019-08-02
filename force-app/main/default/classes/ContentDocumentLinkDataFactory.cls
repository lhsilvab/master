/**
 * @author Luis Bento
 */
@isTest
public class ContentDocumentLinkDataFactory {
    
    public ContentDocumentLink createContentDocumentLink(String aShareType, String aVisibility) {
        return new ContentDocumentLink(
            ShareType = aShareType,
            Visibility = aVisibility
        );
    }

}