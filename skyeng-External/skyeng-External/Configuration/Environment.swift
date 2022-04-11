//
//  Environment.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import Foundation
import UIKit

public enum BuildConfiguration: String {
    case debug
    case release
}

public struct Environment {
    /// The configuration for which the app was built
    let buildConfiguration: BuildConfiguration
    
    /// The base URL that is used to perform network requests
    let baseURL: String
    
    /// The marketing version.
    let appVersion: String
    
    /// The client.
    var client: String
    
    /// The build number.
    var buildNumber: Int
    
    /// The device model.
    var deviceModel: String
    
    /// The system version.
    var deviceName: String
    
    /// The operating system version.
    var operatingSystemVersion: OperatingSystemVersion
    
    /// The operating system name.
    var osName: String
    
    /// The name of the executable. #dev Need more research. A.H
    var executable: String
    
    /// The name of the bundle
    var bundle: String
    
    /// The device locale language
    // Only thai & english available, therefore, if device language is not thai, then return english
    var systemLanguage: String {
        return Locale.current.languageCode ?? "en"
    }
    
    /// The identifierForVendor UUID String
    var deviceNotificationToken: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    init(baseURL: String? = nil) {
        
        let buildConfiguration: BuildConfiguration = { () -> BuildConfiguration in
            #if RELEASE
            return BuildConfiguration.release
            #else
            return BuildConfiguration.debug
            #endif
        }()
        
        self.buildConfiguration = buildConfiguration
        
        if let url = baseURL?.nilIfEmpty {
            self.baseURL = url
        }
        else {
            self.baseURL = Config.BASE_URL
        }
        
        let client: String = { () -> String in
            switch buildConfiguration {
            case .release:
                return "i"
            case .debug:
                return "i"
            }
        }()
        self.client = client
        
        let _info: [String: Any] = { () -> [String: Any] in
            guard let info = Bundle.main.infoDictionary else {
                return [:]
            }
            return info
        }()
        
        let executable: String = { () -> String in
            guard let executable = _info[kCFBundleExecutableKey as String] as? String else {
                return ""
            }
            return executable
        }()
        self.executable = executable
        
        let bundle: String = { () -> String in
            guard let bundle = _info[kCFBundleIdentifierKey as String] as? String else {
                return ""
            }
            return bundle
        }()
        self.bundle = bundle
        
        
        let appVersion: String = { () -> String in
            guard let appVersion = _info["CFBundleShortVersionString"] else {
                return ""
            }
            return "\(appVersion)"
        }()
        self.appVersion = appVersion
        
        let buildNumber: Int = { () -> Int in
            guard let bundleVersion = _info["CFBundleVersion"]
                , let buildNumber = Int("\(bundleVersion)") else {
                    return -1
            }
            return buildNumber
        }()
        self.buildNumber = buildNumber
        
        
        let deviceModel: String = UIDevice.current.model
        self.deviceModel = deviceModel
        
        let operatingSystemVersion: OperatingSystemVersion = ProcessInfo.processInfo.operatingSystemVersion
        self.operatingSystemVersion = operatingSystemVersion
        
        let osName: String = { () -> String in
            #if os(iOS)
            return "iOS"
            #elseif os(watchOS)
            return "watchOS"
            #elseif os(tvOS)
            return "tvOS"
            #elseif os(macOS)
            return "OS X"
            #elseif os(Linux)
            return "Linux"
            #else
            return "Unknown"
            #endif
        }()
        self.osName = osName
        
        let deviceName: String = UIDevice.current.name
        self.deviceName = deviceName
    }
}
