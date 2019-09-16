import Foundation

typealias Minute = Int

class Observation {
    private var behaviorsByMinute: Multimap<Minute, Behavior>

    init() {
        behaviorsByMinute = Multimap()
    }

    func behaviors(atMinute minute: Minute) -> [Behavior] {
        return behaviorsByMinute[minute]
    }

    func registerBehavior(_ behavior: Behavior, atMinute minute: Minute) {
        behaviorsByMinute.put(key: minute, value: behavior)
    }
}

extension Observation: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(behaviorsByMinute)
    }
}
