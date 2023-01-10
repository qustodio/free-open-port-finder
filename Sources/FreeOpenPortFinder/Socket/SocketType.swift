//
//  SocketType.swift
//  
//
//  Created by Qustodio
//  

import Foundation

struct SocketType: RawRepresentable {
    public let rawValue: Int32
    public init(rawValue: Int32) { self.rawValue = rawValue }
    
    public static let stream = SocketType(rawValue: SOCK_STREAM)
}

