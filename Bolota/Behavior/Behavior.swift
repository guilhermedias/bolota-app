import Foundation

enum Behavior: String {
    case a = "a"
    case b = "b"
    case c = "c"
    case l = "l"
    case p = "p"
    case v = "v"
    case ch = "ch"
    case le = "le"
    case bar = "bar"
}

extension Behavior: Encodable {
}
