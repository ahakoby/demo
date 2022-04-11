//
//  AppEnvironment.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import SwiftyUserDefaults

public struct AppEnvironment {
    
    fileprivate static var stack: [Environment] = []
    
    static func setup() {
        let env = fromStorage()
        self.stack.append(env)
    }
    
    // The most recent environment on the stack.
    public static var current: Environment! {
        return stack.last
    }
    
    // Push a new environment onto the stack.
    public static func pushEnvironment(_ env: Environment) {
        saveEnvironment(environment: env)
        stack.append(env)
    }
    
    // Saves some key data for the current environment
    internal static func saveEnvironment(environment env: Environment = AppEnvironment.current) {
    }
    
    static func fromStorage() -> Environment {
        return Environment()
    }
    
    static func log() {
        if let current = self.current {
            Log.info("Build Configuration: \(current.buildConfiguration) ")
        }
    }
}
