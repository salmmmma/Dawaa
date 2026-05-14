//
//  PagesModel.swift
//  AlDwaaNewApp
//
//  Created by Eslam ALi on 28/04/2025.
//

import Foundation
import SwiftUI

struct PagesModel: Codable {
    var uid, uuid, title, template: String?
    var typeCode, name, robotTag: String?
    var defaultPage: Bool?
    var contentSlots: ContentSlots?
    var label: String?
}
struct ContentSlots: Identifiable,Codable {
    var id:String? = UUID().uuidString
    var contentSlot: [ContentSlot]?
}

// MARK: - ContentSlot
struct ContentSlot: Identifiable,Codable {
    var id:String? = UUID().uuidString
    var slotID, slotUUID, position, name: String?
    var slotShared: Bool?
    var components: Components?

    enum CodingKeys: String, CodingKey {
        case slotID = "slotId"
        case slotUUID = "slotUuid"
        case position, name, slotShared, components
    }
}
struct Components: Identifiable, Codable {
    var id:String? = UUID().uuidString
    var component: [ComponentModel]?
}
