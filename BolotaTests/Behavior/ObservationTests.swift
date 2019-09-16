import XCTest

@testable import Bolota

class ObservationTests: XCTestCase {

    var observation: Observation = Observation()

    override func setUp() {
        observation = Observation()
    }

    func testRetriveBehaviorsObservedAtGivenMinute() {
        observation.registerBehavior(.a, atMinute: 0)
        observation.registerBehavior(.b, atMinute: 1)
        observation.registerBehavior(.c, atMinute: 2)
        observation.registerBehavior(.ch, atMinute: 2)

        XCTAssert(observation.behaviors(atMinute: 0) == [.a])
        XCTAssert(observation.behaviors(atMinute: 1) == [.b])
        XCTAssert(observation.behaviors(atMinute: 2) == [.c, .ch])
    }

    func testEncodeObservationAsJSONString() {
        let encoder: JSONEncoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]

        observation.registerBehavior(.a, atMinute: 0)
        observation.registerBehavior(.b, atMinute: 0)
        observation.registerBehavior(.c, atMinute: 1)
        observation.registerBehavior(.ch, atMinute: 1)

        let data = try? encoder.encode(observation)

        if let data = data {
            let jsonString = String(data: data, encoding: .utf8)

            XCTAssert(jsonString == "{\"0\":[\"a\",\"b\"],\"1\":[\"c\",\"ch\"]}")
        } else {
            XCTFail()
        }
    }
}
