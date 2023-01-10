//
//  SocketAddress.swift
//  
//
//  Created by Qustodio
//  

import Foundation

typealias SocketAddress = sockaddr

extension SocketAddress {
    init(port: Port, address: String? = nil) {
        var addr = sockaddr_in() //no need to memset 0. Swift does it
        #if !os(Linux)
            addr.sin_len = UInt8(MemoryLayout<sockaddr_in>.stride)
        #endif
        addr.sin_family = sa_family_t(AF_INET)
        addr.sin_port = port.bigEndian
        
        if let address = address {
            let r = inet_pton(AF_INET, address, &addr.sin_addr)
            assert(r == 1, "\(address) is not converted.")
        }
        
        self = withUnsafePointer(to: &addr) {
            UnsafePointer<SocketAddress>(OpaquePointer($0)).pointee
        }
    }
}
