//
//  ComponentElement.swift
//  AlDwaaNewApp
//

import Foundation

struct ComponentElement: Identifiable, Codable {
    let component: ComponentModel?
    let status: String?
    
    var id: String {
        component?.uid ??
        component?.name ??
        component?.urlLink ??
        UUID().uuidString
    }
}

struct ComponentModel: Codable, Identifiable {
    let uid: String?
    let uuid: String?
    let typeCode: String?
    let title: String?
    let banners: String?
    let media: Media?
    let componentType: String?
    let name: String?
    let urlLink: String?
    let mobilelLinkUrl: String?
    let bannerType: String?
    
    var id: String {
        uid ??
        name ??
        urlLink ??
        UUID().uuidString
    }
}

struct Media: Codable {
    var desktop: Desktop?
    var mobile: Desktop?
    var widescreen: Desktop?
    var url: String?
}

struct Desktop: Codable {
    var code: String?
    var mime: String?
    var altText: String?
    var url: String?
}
