//
//  EventBus.swift
//  BoxKit
//
//  Created by box-jeon on 2020/01/23.
//

import Foundation

public class EventBus {
    
    private let dataKey: String = "data"
    private lazy var encoder: JSONEncoder = JSONEncoder()
    private lazy var decoder: JSONDecoder = JSONDecoder()
    private var observers: [NSObjectProtocol] = []
    
    public init() {
        // do nothing.
    }
    
    deinit {
        self.observers.forEach { (observer) in
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    public func observe<T: LocalEvent>(_ eventType: T.Type, then action: @escaping (T) -> Void) {
        let center = NotificationCenter.default
        let name = Notification.Name(T.typeName)
        let observer = center.addObserver(forName: name, object: nil, queue: nil) { [weak self] (notification) in
            guard let weakSelf = self else { return }
            guard let userInfo = notification.userInfo else { return }
            guard let data = userInfo[weakSelf.dataKey] as? Data else { return }
            guard let event = try? weakSelf.decoder.decode(T.self, from: data) else { return }
            action(event)
        }
        self.observers.append(observer)
    }
    
    func post<T: LocalEvent>(_ event: T) {
        guard let data = try? self.encoder.encode(event) else { return }
        let name = Notification.Name(T.typeName)
        let notification = Notification(name: name, object: nil, userInfo: [self.dataKey: data])
        NotificationCenter.default.post(notification)
    }
}

public protocol LocalEvent: HasTypeName, Codable {
    
}

extension LocalEvent {
    
    public func notify() {
        EventBus().post(self)
    }
}
