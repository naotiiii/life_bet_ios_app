//
//  BaseViewController.swift
//  life-bet
//
//  Created by naoto kojima on 2022/01/24.
//

import UIKit
import GoogleMobileAds
import AVFoundation

/// 開始音
enum StartSounds: String, CaseIterable {
    case drum = "drum_roll"
}

/// 開始音 アタリ
enum StartCorrectSounnds: String, CaseIterable {
    case drum = "drum_roll"
    case dragon = "dragon_roar"
    case thunder = "lightning_strike"
}

/// 正解の音
enum CorrectSounds: String, CaseIterable {
    case applause = "cheers_and_applause"
    case sword = "cut_sword"
}

/// 不正解音
enum IncorrectSounds: String, CaseIterable {
    case incorrect = "incorrect_answer"
}

/// BaseViewController
class BaseViewController: UIViewController {
    // BannerView
    var bannerView: GADBannerView = GADBannerView()
    // Interstitial
    var interstitial: GADInterstitialAd?
    
    // sound player
    var audioPlayer: AVAudioPlayer!
    /// 開始音楽配列
    let start: Array<StartSounds> = StartSounds.allCases
    /// 正解音楽配列
    let correct: Array<CorrectSounds> = CorrectSounds.allCases
    /// 不正解音楽配列
    let inCorrect: Array<IncorrectSounds> = IncorrectSounds.allCases
    
    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = CommonWords.backBtnTitle()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
        
    // MARK: - function

    /// OKボタンアラート
    ///
    /// - Parameters message メッセージ
    public func okBtnAlert(message: String) {
        let okBtn: UIAlertAction = UIAlertAction.init(title: CommonWords.ok(), style: .default, handler: nil)
        let ac: UIAlertController = UIAlertController.init(title: CommonWords.empty(), message: message, preferredStyle: .alert)
        ac.addAction(okBtn)
        present(ac, animated: true, completion: nil)
    }
    
    /// 丸ボタン
    ///
    /// - Parameters button UIButton
    public func circleButton(button: UIButton) {
        button.layer.cornerRadius = button.bounds.width/2
        button.layer.masksToBounds = true
    }
    
    /// バーナ広告の設定
    ///
    ///
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
    
    /// インタースティシャル広告の設定
    ///
    ///
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

// MARK: - extension AVAudioPlayerDelegate
extension BaseViewController: AVAudioPlayerDelegate {
    
    /// サウンド再生
    ///
    /// - Parameters resource
    func playSound(resource: String) {
        guard let path = Bundle.main.path(forResource: resource, ofType: "mp3") else {
            print("Nothing Sound File")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.delegate = self
            
            audioPlayer.play()
        } catch {
            print("Nothing Sound File")
        }
    }
}

extension BaseViewController: GADFullScreenContentDelegate {
    
    
}
