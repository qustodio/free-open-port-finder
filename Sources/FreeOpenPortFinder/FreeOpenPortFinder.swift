import Foundation

public typealias Port = in_port_t

/// Get an available port given by the system
///
/// How to use?
/// ```
/// let freeOpenPort = try FreeOpenPortFinder(family: .inet)
///
/// let port = freeOpenPort.port
/// ```
public struct FreeOpenPortFinder {
    let port: Port
    
    public init(family: Family) throws {
        let socket = try Socket(family, type: .stream, socketProtocol: .tcp)
        try socket.bind(port: 0)
        self.port = try socket.port()
        try socket.close()
    }
}
