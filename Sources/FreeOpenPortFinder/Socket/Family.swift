//
//  Family.swift
//  
//
//  Created by Qustodio
//  

import Foundation

/// Address Family
/// Right now only `AF_INET` is available.
public struct Family: RawRepresentable {
    public let rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    /// Address family that is used to designate the type of addresses that your socket can communicate with (in this case, Internet Protocol v4 addresses)
    public static let inet = Family(rawValue: AF_INET)
}

