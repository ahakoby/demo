//
//  Logger.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
struct Log {
    
    private static let debugLevelKey = "debug_level_enable"
    private static let infoLevelKey = "info_level_enable"
    private static let errorLevelKey = "error_level_enable"
    private static let networkInfoLevelKey = "network_info_level_enable"
    private static let memoryInfoLevelKey = "memory_info_level_enable"
    
    private static var isDebugEnable: Bool {
        return ProcessInfo.processInfo.environment[debugLevelKey] != nil
    }
    
    private static var isErrorEnable: Bool {
        return ProcessInfo.processInfo.environment[errorLevelKey] != nil
    }
    
    private static var isInfoEnable: Bool {
        return ProcessInfo.processInfo.environment[infoLevelKey] != nil
    }
    
    private static var isNetworkInfoEnable: Bool {
        return ProcessInfo.processInfo.environment[networkInfoLevelKey] != nil
    }
    
    private static var isMemoryInfoEnable: Bool {
        return ProcessInfo.processInfo.environment[memoryInfoLevelKey] != nil
    }
    
    static func network(_ item: Any?) {
        guard let item = item, isNetworkInfoEnable else {
            return
        }

        #if DEBUG
            print("🌐[NETWORK]: \(Date()) \n    \(item)")
        #endif
    }
    
    static func deinitOf(_ object: Any, filePath: String = #file) {
        guard isMemoryInfoEnable else {
            return
        }
        let className = String(describing: type(of: object))
        
        #if DEBUG
            print("💀[MEMORY]: \(Date()) \n    \(className) is deinit")
        #endif
    }
    
    static func initOf(_ object: Any, filePath: String = #file) {
        guard isMemoryInfoEnable else {
            return
        }
        let className = String(describing: type(of: object))
        
        #if DEBUG
            print("🐣[MEMORY]: \(Date()) \n    \(className) is initialized")
        #endif
    }
    
    
    static func debug(_ logText: CustomStringConvertible?, functionName: String = #function, filePath: String = #file) {
        guard let logText = logText, isDebugEnable else {
            return
        }
        let header = "******** \(functionName) ********"
        let footer = header.replaceAllChars(with: "*")
        
        #if DEBUG
            print("\n\(header)\n🔵[DEBUG]: \(Date()) \n    \(logText) \n\(footer)\n")
        #endif
    }
    
    static func error(_ logText: CustomStringConvertible?, functionName: String = #function, filePath: String = #file) {
        guard let logText = logText, isErrorEnable else {
            return
        }
        let header = "******** \(functionName) ********"
        let footer = header.replaceAllChars(with: "*")
        
        #if DEBUG
            print("\n\(header)\n🔴[ERROR]: \(Date()) \n    \(logText) \n\(footer)\n")
        #endif
    }
    
    static func info(_ logText: CustomStringConvertible?) {
        guard let logText = logText, isInfoEnable else {
            return
        }
        
        #if DEBUG
            print("ℹ️[INFO]: \(Date()) \n    \(logText)")
        #endif
    }
    
}


func fatalError(_ error: InnerError, file: StaticString = #file, line: UInt = #line) -> Never {
    fatalError(error.localizedDescription, file: file, line: line)
}
