//
//  SocketProtocol.swift
//  
//
//  Created by Qustodio
//  

import Foundation


struct SocketProtocol: RawRepresentable {
    public let rawValue: Int32
    public init(rawValue: Int32) { self.rawValue = rawValue }
    
    public static let tcp = SocketProtocol(rawValue: Int32(IPPROTO_TCP))
}

