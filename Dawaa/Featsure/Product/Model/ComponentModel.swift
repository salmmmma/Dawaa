import Foundation

extension ComponentModel: CardSliderProtocol {
    
    var imageURL: String? {
        media?.mobile?.url ??
        media?.desktop?.url ??
        media?.widescreen?.url ??
        media?.url
    }
    
    var mobileLinkUrl: String? {
        mobilelLinkUrl ?? urlLink
    }
}