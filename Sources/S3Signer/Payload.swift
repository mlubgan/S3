import Vapor
import Crypto

public enum Payload {
    case bytes(Data)
    case none
    case unsigned
}

extension Payload {
    internal var bytes: Data {
        switch self {
        case .bytes(let bytes): return bytes
        default: return "".convertToData()
        }
    }
    
    internal func hashed() throws -> String {
        switch self {
        case .bytes(let bytes): return try SHA256.hash(bytes).hexEncodedString()
        case .none: return try SHA256.hash("".convertToData()).hexEncodedString()
        case .unsigned: return "UNSIGNED-PAYLOAD"
        }
    }
    
    internal var isBytes: Bool {
        switch self {
        case .bytes( _), .none: return true
        default: return false
        }
    }
    
    internal func size() -> String {
        switch self {
        case .bytes, .none: return self.bytes.count.description
        case .unsigned: return "UNSIGNED-PAYLOAD"
        }
    }
    
    internal var isUnsigned: Bool {
        switch self {
        case .unsigned: return true
        default: return false
        }
    }
}
