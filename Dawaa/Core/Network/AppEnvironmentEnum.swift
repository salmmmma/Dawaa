//
//  File.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 11/05/2026.
//

import Foundation

enum AppEnvironmentEnum {
    case staging
    case development
    case production
    
    var baseDomain: String {
        switch self {
        case .staging:
            return "https://comtesapi.al-dawaa.com/"
            
        case .development:
            return "https://dev-api.dwademo.com/"
            
        case .production:
            return "https://stgprevapi.al-dawaa.com/"
        }
    }
}
