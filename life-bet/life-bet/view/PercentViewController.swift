//
//  PercentViewController.swift
//  life-bet
//
//  Created by naoto kojima on 2022/01/30.
//

import UIKit

/// プレイタイプ
public enum PlayType: CaseIterable {
    case TWENTY
    case FIVE
    case FOUR
    case ONE
}

/// 確率画面
class PercentViewController: BaseViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var percentLabel: UILabel!
    /// 試行回数 Label
    @IBOutlet weak var numberOfTrialsLabel: UILabel!
    /// 当たり回数 Label
    @IBOutlet weak var hitCountLabel: UILabel!
    
    /// アニメーション View
    @IBOutlet weak var animationView: UIView!
    /// 上部 回る時の ImageView1
    @IBOutlet weak var upperImageView1: UIImageView!
    /// 上部 回る時の ImageView2
    @IBOutlet weak var upperImageView2: UIImageView!
    /// 上部 回る時の ImageView3
    @IBOutlet weak var upperImageView3: UIImageView!
    /// 下部 回る時の ImageView1
    @IBOutlet weak var downImageView1: UIImageView!
    
    /// アタリ・ハズレ表示 Label
    @IBOutlet weak var resultLabel: UILabel! {
        didSet {
            resultLabel.alpha = 0
        }
    }
    /// 回す Button
    @IBOutlet weak var turnButton: UIButton!
    
    /// 確率母数
    var denominator: Int?
    /// プレイ種類
    var playType: PlayType?
    
    /// 固定で当たり番号付与
    final let hitNum = 1
    
    /// 回転数
    var trialCount = 0
    /// アタリ回数
    var hitCount = 0
    /// 広告表示回数
    var interstitialCount = 0

    /// 当たったかどうか
    var isCorrect = false
    
    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBottomBannerView()
        setInterstitialView()
        circleButton(button: turnButton)
        
        if denominator == nil {
            navigationController?.popViewController(animated: true)
        }
        
        let percent: Double = 100 / Double(denominator!)
        print("percent: \(percent)")
        
        let percentStr = String(format: "%.4f", percent)
        percentLabel.text = "\(denominator!)分の1 (\(percentStr)%の確率)"
        numberOfTrialsLabel.text = "\(trialCount)回"
        hitCountLabel.text = "\(hitCount)回"
    }
    
    // MARK: - @IBOutlet
    /// 回すボタンタップ処理
    /// ボタン内で、指が離れた
    @IBAction func touchUpInsideTurnButton(_ sender: UIButton) {
        trialCount += 1
        interstitialCount += 1
        if isCorrect {
            // アタリ
            processHitNumber()
            hitCount += 1
        } else {
            // ハズレ
            processLostNumber()
            
            if interstitialCount == 10 {
                if interstitial != nil {
                    interstitial?.present(fromRootViewController: self)
                }
                interstitialCount = 0
            }
        }
        // 回数更新表示
        numberOfTrialsLabel.text = "\(trialCount)回"
        hitCountLabel.text = "\(hitCount)回"
    }
    
    /// ボタンに指が触れたら発生
    @IBAction func onTurnButtonTouchDown(_ sender: Any) {
        resultLabel.alpha = 0
        setImageAlpha(alpha: 1.0)
        
        turnButton.isEnabled = false
        let num = Int.random(in: 1...denominator!)
        print("output number: \(num)")
        if num == hitNum {
            // 当たり
            let num = Int.random(in: 0...10)
            let startSound: String
            if num < 7 {
                startSound = StartCorrectSounnds.drum.rawValue
            } else if num < 9 {
                startSound = StartCorrectSounnds.dragon.rawValue
            } else {
                startSound = StartCorrectSounnds.thunder.rawValue
            }
            playSound(resource: startSound)
            isCorrect = true
        } else {
            // ハズレ
            playSound(resource: StartSounds.drum.rawValue)
            isCorrect = false
        }
    }
        
    /// 当たりの時の処理
    func processHitNumber() {
        // スペシャルアタリ
        sleep(2)
        var sound = correct.randomElement()?.rawValue ?? CorrectSounds.sword.rawValue
        let num = Int.random(in: 0...10)
        if num == 7 || num == 8 {
            sound = SpecialCorrectSounds.syakin.rawValue
        } else if num == 9 || num == 10 {
            sound = SpecialCorrectSounds.kyuin.rawValue
            specialHitNumberAnimate()
        }
        playSound(resource: sound)
        
        resultLabel.text = CommonWords.numberHit()
        startAnimationLabel()
        turnButton.isEnabled = true
    }
    
    /// ハズレの時の処理
    func processLostNumber() {
        sleep(2)
        resultLabel.text = CommonWords.numberLost()
        startAnimationLabel()
        playSound(resource: "incorrect_answer")
        turnButton.isEnabled = true
    }
    
    /// ラベル表示
    func startAnimationLabel() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.transitionFlipFromRight]) {
            self.resultLabel.alpha = 1
        } completion: { _ in
        }
    }

    /// 特別なアタリ
    func specialHitNumberAnimate() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .repeat) {
            self.setImageAlpha(alpha: 0.0)
        } completion: { _ in
            
        }
    }
    
    /// ImageのAplahを設定
    func setImageAlpha(alpha: CGFloat) {
        upperImageView1.alpha = alpha
        upperImageView2.alpha = alpha
        upperImageView3.alpha = alpha
        downImageView1.alpha = alpha
    }
}
