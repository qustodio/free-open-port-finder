//
//  Socket.swift
//  
//
//  Created by Qustodio
//  

import Foundation

typealias FileDescriptor = Int32

struct Socket {
    private let fileDescriptor: FileDescriptor
    

    init(_ family: Family, type: SocketType, socketProtocol: SocketProtocol) throws {
        self.fileDescriptor = try ing {
            socket(family.rawValue, type.rawValue, socketProtocol.rawValue)
        }
    }
                   
    func bind(port: Port, address: String? = nil) throws {
        try bind(address: SocketAddress(port: port, address: address))
    }
    
    private func bind(address: SocketAddress) throws {
        var addr = address
        try ing { OS.bind(fileDescriptor, &addr, socklen_t(MemoryLayout<SocketAddress>.size)) }
    }
    
    /// Returns the local port number to which the socket is bound.
    ///
    /// - Returns: Local port to which the socket is bound.
    func port() throws -> Port {
        var address = sockaddr_in()
        var len = socklen_t(MemoryLayout.size(ofValue: address))
        let pointer = UnsafeMutableRawPointer(&address).assumingMemoryBound(to: sockaddr.self)

        try ing { getsockname(fileDescriptor, pointer, &len) }

        return Port(address.sin_port.bigEndian)
    }
    
    func close() throws {
        try ing {
            OS.close(fileDescriptor)
        }
    }
}

@discardableResult
fileprivate func ing<T: SignedInteger>(_ block: () -> T) throws -> T {
    let value = block()
    if value == -1 {
        throw SocketError(errno: errno)
    }
    
    return value
}
