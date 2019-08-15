import UIKit
import BoxKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.d()
        let title = "Title Bow Wow".attributed
            .setForegroundColor(.red)
            .setBackgroundColor(.blue)
        self.titleLabel.attributedText = title
    }
}
