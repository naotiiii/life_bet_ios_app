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
        
        // スペシャルアタリ
        specialHitNumberAnimate()
        playSound(resource: startSound)
        
        sleep(2)
        var sound = correct.randomElement()?.rawValue ?? CorrectSounds.sword.rawValue
        if num == 7 || num == 8 {
            sound = SpecialCorrectSounds.syakin.rawValue
        } else if num == 9 || num == 10 {
            sound = SpecialCorrectSounds.kyuin.rawValue
        }
        
        playSound(resource: sound)
        
        turnImageView.stopAnimating()
        
        resultLabel.text = CommonWords.numberHit()
        turnButton.isEnabled = true
    }
    
    /// ハズレの時の処理
    func processLostNumber() {
        let startSound = StartSounds.drum.rawValue
        playSound(resource: startSound)

        sleep(2)
        resultLabel.text = CommonWords.numberLost()
        playSound(resource: "incorrect_answer")
        turnButton.isEnabled = true
    }

    /// 特別なアタリ
    func specialHitNumberAnimate() {
        turnImageView.animationImages = [
            UIImage(named: "img_icon")!,
            UIImage(named: "img_white")!]
        turnImageView.animationDuration = 0.2
        UIView.animate(withDuration: 1, delay: 0, options: .transitionCurlUp) {
            self.turnImageView.startAnimating()
        } completion: { _ in
            
        }
    }
}
