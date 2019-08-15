import Foundation

public let Log = _LogService.shared

public class _LogService {
    
    static let shared: _LogService = _LogService()
    
    private var infoPrefix: String = "ℹ️ "
    private var debugPrefix: String = ""
    private var errorPrefix: String = "❌ "
    
    private init() {
        
    }
    
    public func setupPrefix(debug: String?, info: String?, error: String?) {
        if let info = info {
            self.infoPrefix = "\(info) "
        }
        if let debug = debug {
            self.debugPrefix = "\(debug) "
        }
        if let error = error {
            self.errorPrefix = "\(error) "
        }
    }
    
    public func i<T>(_ value: T, file: NSString = #file, line: Int = #line) {
        let fileName = file.lastPathComponent.ns.deletingPathExtension
        print("\(fileName)[\(line)]: \(self.infoPrefix)\(value)", terminator: "\n")
    }
    
    public func i(function: String = #function, file: NSString = #file, line: Int = #line) {
        let fileName = file.lastPathComponent.ns.deletingPathExtension
        print("\(fileName)[\(line)]: \(self.infoPrefix)\(function)", terminator: "\n")
    }
    
    public func d<T>(_ value: T, file: NSString = #file, line: Int = #line) {
        let fileName = file.lastPathComponent.ns.deletingPathExtension
        print("\(fileName)[\(line)]: \(self.debugPrefix)\(value)", terminator: "\n")
    }
    
    public func d(function: String = #function, file: NSString = #file, line: Int = #line) {
        let fileName = file.lastPathComponent.ns.deletingPathExtension
        print("\(fileName)[\(line)]: \(self.debugPrefix)\(function)", terminator: "\n")
    }
    
    public func e<T>(_ value: T, file: NSString = #file, line: Int = #line) {
        let fileName = file.lastPathComponent.ns.deletingPathExtension
        print("\(fileName)[\(line)]: \(self.errorPrefix)\(value)", terminator: "\n")
    }
}
