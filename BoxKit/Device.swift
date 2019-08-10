
public struct Device {
    
    public static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    public static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public static var isLandscape: Bool {
        // 바닥에 내려놓은 경우 .faceUp
        // 누워서 들고 있는 경우 .faceDown
        // isLandscape이 false임.
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            return false
        case .landscapeLeft, .landscapeRight:
            return true
        default:
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    
    public static var currentStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    public static var safeAreaTopInset: CGFloat {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0
    }
    
    public static var safeAreaBottomInset: CGFloat {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
    }
}
