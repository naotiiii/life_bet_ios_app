//
//  BaseViewController.swift
//  life-bet
//
//  Created by naoto kojima on 2022/01/24.
//

import UIKit
import GoogleMobileAds

/// BaseViewController
class BaseViewController: UIViewController {
    // BannerView
    var bannerView: GADBannerView = GADBannerView()
    // Interstitial
    var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    public func okBtnAlert(message: String) {
        let okBtn: UIAlertAction = UIAlertAction.init(title: CommonWords.ok(), style: .default, handler: nil)
        let ac: UIAlertController = UIAlertController.init(title: CommonWords.empty(), message: message, preferredStyle: .alert)
        ac.addAction(okBtn)
        present(ac, animated: true, completion: nil)
    }
    
    // バーナ広告の設定
    //
    //
    public func setBottomBannerView() {
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height - self.bannerView.frame.height)
        bannerView.frame.size = CGSize(width: self.view.frame.width, height: 50)
        #if DEBUG
        bannerView.adUnitID = CommonWords.testBannerID()
        #else
        bannerView.adUnitID = CommonWords.bannerID()
        #endif

        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        self.view.addSubview(bannerView)
    }
    
    // インタースティシャル広告の設定
    //
    //
    public func setInterstitialView() {
        let request = GADRequest()
        var advertiseID: String = CommonWords.intersitialID()
        #if DEBUG
        advertiseID = CommonWords.testInterstitialID()
        #endif
        GADInterstitialAd.load(withAdUnitID: advertiseID, request: request) { (ad, error) in
            if let error = error {
                print("Failed to load interstitial ad with error:\(error.localizedDescription)")
                return
            } else {
                self.interstitial = ad
                self.interstitial?.fullScreenContentDelegate = self
            }
        }
    }
}

extension BaseViewController: GADFullScreenContentDelegate {
    
    
}
