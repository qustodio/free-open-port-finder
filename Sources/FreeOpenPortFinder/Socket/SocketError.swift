//
//  SocketError.swift
//  
//
//  Created by Qustodio
//  

import Foundation


public struct SocketError: Error, Equatable, CustomStringConvertible {
    public let errno: Int32
    public init(errno: Int32) { self.errno = errno }
    
    public static func == (lhs: SocketError, rhs: SocketError) -> Bool {
        return lhs.errno == rhs.errno
    }
    
    public var description: String {
        return "POSIXError \(self.errno): \(String(cString: UnsafePointer(strerror(self.errno))))."
    }
}

