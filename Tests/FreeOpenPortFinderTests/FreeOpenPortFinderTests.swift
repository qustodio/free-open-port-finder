import XCTest
@testable import FreeOpenPortFinder

final class FreeOpenPortFinderTests: XCTestCase {
    
    func testGetOSFreeOpenPort() throws {
        // MARK: Given
        
        let port = try FreeOpenPortFinder(family: .inet).port
        
        // MARK: Then
        
        XCTAssertTrue(port > 0)
    }
    
    func testPortProvidedIsFreed() throws {
        // MARK: Given
        
        let port = try FreeOpenPortFinder(family: .inet).port
        let socket = try Socket(.inet, type: .stream, socketProtocol: .tcp)
        
        // MARK: When
        
        try socket.bind(port: port)
        
        // MARK: Then
        
        XCTAssertEqual(try socket.port(), port)
        XCTAssertTrue(try socket.port() > 0)
        
        try socket.close()
    }
    
    func testCheckIsThreadSafe() throws {
        
        DispatchQueue.concurrentPerform(iterations: 1000_000) { _ in
            let port = try? FreeOpenPortFinder(family: .inet).port
            
            XCTAssertTrue((port ?? 0) > 0)
        }
        
    }
}
