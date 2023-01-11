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
        self.fileDescriptor = try run {
            socket(family.rawValue, type.rawValue, socketProtocol.rawValue)
        }
    }
    
    /// Bind to a new port and address
    func bind(port: Port, address: String? = nil) throws {
        try bind(address: SocketAddress(port: port, address: address))
    }
    
    private func bind(address: SocketAddress) throws {
        var addr = address
        try run { OS.bind(fileDescriptor, &addr, socklen_t(MemoryLayout<SocketAddress>.size)) }
    }
    
    /// Returns the local port number to which the socket is bound.
    ///
    /// - Returns: Local port to which the socket is bound.
    func port() throws -> Port {
        var address = sockaddr_in()
        var len = socklen_t(MemoryLayout.size(ofValue: address))
        let addressptr = UnsafeMutableRawPointer(&address).assumingMemoryBound(to: sockaddr.self)

        try run { getsockname(fileDescriptor, addressptr, &len) }

        return Port(address.sin_port.bigEndian)
    }
    
    /// Close socket
    func close() throws {
        try run {
            OS.close(fileDescriptor)
        }
    }
}

@discardableResult
fileprivate func run<T: SignedInteger>(_ block: () -> T) throws -> T {
    let value = block()
    if value == -1 {
        throw SocketError(errno: errno)
    }
    
    return value
}
