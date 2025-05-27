//
//  NetworkManager.swift
//  SnakeGame
//
//  Created by Grigore on 05.03.2025.
//

import Network
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    var isConnected: Bool = true {
            didSet {
                if isConnected {
                    NotificationCenter.default.post(name: .internetRestored, object: nil)
                }
            }
        }
    
    private init() {
            monitor.pathUpdateHandler = { path in
                let previousState = self.isConnected
                self.isConnected = path.status == .satisfied
                if !previousState && self.isConnected {
                    print("Internet connection restored, retrying Ad load")
                }
            }
            
            monitor.start(queue: queue)
        }
    
    func showNoInternetAlert() {
        let alert = UIAlertController(
            title: "no_internet_title".localized,
            message: "no_internet_message".localized,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        if let rootVC = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?.rootViewController {
            rootVC.present(alert, animated: true)
        }
    }

}

extension Notification.Name {
    static let internetRestored = Notification.Name("internetRestored")
}
