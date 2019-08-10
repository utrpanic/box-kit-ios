import UIKit
import BoxKit

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Log.d("current statusBarHeight: \(Device.currentStatusBarHeight)")
        Log.d("statusBarHeight: \(UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0)")
        Log.d(ViewController.className)
    }
}
