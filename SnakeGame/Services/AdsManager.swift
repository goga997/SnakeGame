//
//  AdsManager.swift
//  SnakeGame
//
//  Created by Grigore on 05.03.2025.
//

import GoogleMobileAds

//singleton class
class AdsManager {
    
    static let shared = AdsManager()
    weak var delegate: FullScreenContentDelegate?
    
    //just for testing
    private let adUnitId = "ca-app-pub-3940256099942544/1712485313"
    
    private var rewardedAd: RewardedAd?
    
    private var rootViewController: UIViewController? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.rootViewController
    }
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleInternetRestored), name: .internetRestored, object: nil)
    }
    
    @objc private func handleInternetRestored() {
        print("Internet restored, reloading ad...")
        loadAd()
    }
    
    func loadAd() {
        let request = Request()
        RewardedAd.load(with: adUnitId, request: request) { ad, error in
            if let error = error {
                print("Ad failed to load: \(error.localizedDescription)")
                
                // if error is about networking then going to reload again and again
                if (error as NSError).code == -1009 {
                    print("No internet connection, retrying in 3 seconds...")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.loadAd()
                    }
                }
                return
            }
            print("Ad succesfully loaded")
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self.delegate
        }
    }
    
    func showAd() {
        HapticsManager.shared.selectionVibrate()
        
        //first verify if is there any internet connection
        if !NetworkManager.shared.isConnected {
            DispatchQueue.main.async {
                NetworkManager.shared.showNoInternetAlert()
            }
        }
        
        guard let rewardedAd = rewardedAd else {
            print("No ad available, trying to reload...")
            loadAd()
            return
        }
        
        guard let rootVC = rootViewController else {
            print("No root view controller available")
            return
        }
        
        rewardedAd.present(from: rootVC) {
            print("User watched the ad, granting reward")
            HeartManager.hearts += 1
            NotificationCenter.default.post(name: HeartManager.heartsUpdatedNotification, object: nil)
            self.loadAd() // Renew another ad automatically here
        }
    }
    
}
