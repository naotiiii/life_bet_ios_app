//
//  PercentViewController.swift
//  life-bet
//
//  Created by naoto kojima on 2022/01/30.
//

import UIKit

/// プレイタイプ
public enum PlayType {
    case TWENTY
    case FIVE
    case FOUR
    case ONE
}

/// 確率画面
class PercentViewController: BaseViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var percentLabel: UILabel!
    
    /// アニメーション View
    @IBOutlet weak var animationView: UIView!
    /// 回る時の ImageView
    @IBOutlet weak var turnImageView: UIImageView!
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
    
    /// 機械設定種類
    var playType: PlayType?
    
    /// 固定で当たり番号付与
    let hitNum = 1
    
    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBottomBannerView()
        circleButton(button: turnButton)
        
        if denominator == nil {
            navigationController?.popViewController(animated: true)
        }
    
        let percent: Double = 100.00000 / Double(denominator!)
        print("percent: \(percent)")
        print("percent: \(100 / 200)")

        percentLabel.text = "\(denominator!)分の1 (\(percent)%の確率)"
    }
    
    // MARK: - @IBOutlet
    /// 回すボタンタップ処理
    /// ボタン内で、指が離れた
    @IBAction func touchUpInsideTurnButton(_ sender: UIButton) {
        turnButton.isEnabled = false
        specialHitNumberAnimate()
        let num = Int.random(in: 1...denominator!)
        print("output number: \(num)")
        if num == hitNum {
            // 当たり
            processHitNumber()
        } else {
            // ハズレ
            processLostNumber()
        }
    }
    
    /// ボタンに指が触れたら発生
    @IBAction func onTurnButtonTouchDown(_ sender: Any) {
        resultLabel.alpha = 0
    }
        
    /// 当たりの時の処理
    func processHitNumber() {
      //  specialHitNumberAnimate()
        // 当たり
        let num = Int.random(in: 0...10)
        let startSound: String
        if num < 8 {
            startSound = StartCorrectSounnds.drum.rawValue
        } else if num < 8 {
            startSound = StartCorrectSounnds.dragon.rawValue
        } else {
            startSound = StartCorrectSounnds.thunder.rawValue
        }
        playSound(resource: startSound)
        
        sleep(2)
        let sound = correct.randomElement()?.rawValue ?? CorrectSounds.sword.rawValue
        playSound(resource: sound)
        
        resultLabel.text = CommonWords.numberHit()
        turnButton.isEnabled = true
    }
    
    /// ハズレの時の処理
    func processLostNumber() {
        let startSound = StartSounds.drum.rawValue
        playSound(resource: startSound)

        sleep(2)
        resultLabel.text = CommonWords.numberLost()
        usualyStartAnimate()
        playSound(resource: "incorrect_answer")
        turnButton.isEnabled = true
    }

    /// 通常の当たり時のアニメーション
    func usualyStartAnimate() {
//        UIView.animate(withDuration: 1.0, delay: 0, options: .transitionFlipFromRight) {
//            self.turnImageView.alpha = 1
//        } completion: { _ in
//        }
    }
    
    /// 特別なアタリ
    func specialHitNumberAnimate() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.transitionFlipFromRight]) {
            self.resultLabel.alpha = 1
        } completion: { _ in
            
        }
    }
}
