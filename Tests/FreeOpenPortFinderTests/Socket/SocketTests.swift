//
//  SocketTests.swift
//  
//
//  Created by Qustodio
//  

import Foundation
import XCTest
@testable import FreeOpenPortFinder

final class SocketTests: XCTestCase {
    
    func testVerifyBindSuccessFully() throws {
        // MARK: Given
        let socket = try Socket(.inet, type: .stream, socketProtocol: .tcp)
        
        // MARK: When
        
        try socket.bind(port: 8000, address: nil)
        
        // MARK: Then
        
        XCTAssertEqual(try socket.port(), 8000)
        
        try socket.close()
    }
    
    func testVerifyOSGivesFreePort() throws {
        // MARK: Given
        let socket = try Socket(.inet, type: .stream, socketProtocol: .tcp)
        
        // MARK: When
        
        try socket.bind(port: 0, address: "0.0.0.0")
        
        // MARK: Then
        
        XCTAssertTrue(try socket.port() > 0)
        
        try socket.close()
    }
    
    func testVerifyIfPortIsAlreadyBusyThrowsError() throws {
        // MARK: Given
        let socket = try Socket(.inet, type: .stream, socketProtocol: .tcp)
        try socket.bind(port: 9000)
        
        let socket1 = try Socket(.inet, type: .stream, socketProtocol: .tcp)
        
        do {
            
            // MARK: When
            try socket1.bind(port: 9000)
        } catch let error as SocketError {
            
            // MARK: Then
            XCTAssertEqual(error.errno, 48)
            return
        }
        
        XCTFail("Should fail as POSIXError 48: Address already in use.")
        
        try socket.close()
        try socket1.close()
    }
    
    func testVerifyPortIsFreeAfterClosingSocket() throws {
        // MARK: Given
        
        let socket = try Socket(.inet, type: .stream, socketProtocol: .tcp)
        try socket.bind(port: 8001)
        try socket.close()
        
        let socket1 = try Socket(.inet, type: .stream, socketProtocol: .tcp)
        
        // MARK: When
        
        try socket1.bind(port: 8001)
        
        // MARK: Then
        
        XCTAssertEqual(try socket1.port(), 8001)

        try socket1.close()
    }
}
