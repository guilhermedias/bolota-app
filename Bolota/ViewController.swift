import UIKit

class ViewController: UIViewController {
    private var clock: Clock = Clock(0)
    private var observation: Observation = Observation()

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var saveBehaviorsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startStopClock(_ sender: Any) {
        if(clock.isRunning()) {
            clock.stop()

            startStopButton.setTitle("Start", for: .normal)
        } else {
            observation = Observation()

            clock.start {
                self.display.text = self.clock.timeString()
            }

            startStopButton.setTitle("Stop", for: .normal)
        }
    }

    @IBAction func registerBehavior(_ sender: UIButton) {
        if(clock.isRunning()) {
            let observedBehavior = Behavior(rawValue: sender.title(for: .normal)!.lowercased())!
            observation.registerBehavior(observedBehavior, atMinute: clock.getMinutesCount())
        }
    }

    @IBAction func saveBehaviors(_ sender: Any) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]

        let data = try? encoder.encode(observation)

        if let data = data, let jsonString = String(data: data, encoding: .utf8) {
            let activity = UIActivityViewController(activityItems: [jsonString], applicationActivities: nil)
            present(activity, animated: true, completion: nil)
        } else {
            print("Error saving the file")
        }
    }
}
