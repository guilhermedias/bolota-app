import Foundation

typealias TickAction = () -> Void

class Clock {
    private var timer: Timer?
    private var running: Bool
    private var decisecondsElapsed: Int

    init(_ decisecondsElapsed: Int) {
        timer = nil
        running = false
        self.decisecondsElapsed = decisecondsElapsed
    }

    func start(_ tickAction: @escaping TickAction) {
        running = true

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.decisecondsElapsed += 1
            tickAction()
        })
    }

    func  stop() {
        running = false
        timer?.invalidate()
        decisecondsElapsed = 0
    }

    func getMinutesCount() -> Minute {
        return decisecondsElapsed / 600
    }

    func timeString() -> String {
        let time = decisecondsElapsed / 10

        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format:"%02d:%02d:%02d", hours, minutes, seconds)
    }

    func isRunning() -> Bool {
        return running
    }
}
