import UIKit

class ViewController: UIViewController {
    private var clock: Clock = Clock(0)
    private var observation: Observation = Observation()

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var saveBehaviorsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        disableSaveBehaviorsButton()
    }

    @IBAction func startStopClock(_ sender: Any) {
        if(clock.isRunning()) {
            clock.stop()
            startStopButton.setTitle("Start", for: .normal)
            enableSaveBehaviorsButton()
        } else {
            observation = Observation()

            clock.start {
                self.display.text = self.clock.timeString()
            }

            startStopButton.setTitle("Stop", for: .normal)
            disableSaveBehaviorsButton()
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
            presentActivity(withData: jsonString)
        } else {
            print("Error saving the file")
        }
    }

    private func enableSaveBehaviorsButton() {
        saveBehaviorsButton.isEnabled = true
        saveBehaviorsButton.alpha = 1.0
    }

    private func disableSaveBehaviorsButton() {
        saveBehaviorsButton.isEnabled = false
        saveBehaviorsButton.alpha = 0.5
    }

    private func presentActivity(withData jsonString: String) {
        let activity = UIActivityViewController(activityItems: [jsonString], applicationActivities: nil)
        activity.setValue("Bolota App", forKey: "Subject")
        present(activity, animated: true, completion: nil)
    }
}
