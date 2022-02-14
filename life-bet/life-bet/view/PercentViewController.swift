//
//  PercentViewController.swift
//  life-bet
//
//  Created by naoto kojima on 2022/01/30.
//

import UIKit

/// 確率画面
class PercentViewController: BaseViewController {

    // MARK: - @IBOutlet
    
    /// 回る時の ImageView
    @IBOutlet weak var turnImageView: UIImageView!
    
    /// 回す Button
    @IBOutlet weak var turnButton: UIButton!
    
    /// 確率母数
    var denominator: Int?
    
    /// 固定で当たり番号付与
    let hitNum = 1
    
    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if denominator == nil {
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - @IBOutlet
    /// 回すボタンタップ処理
    /// ボタン内で、指が離れた
    @IBAction func touchUpInsideTurnButton(_ sender: UIButton) {
        turnButton.isSelected = true
    }
    
    /// ボタンに指が触れたら発生
    @IBAction func touchDownTurnButton(_ sender: UIButton) {
        let num = Int.random(in: 1...denominator!)
        print("output number: \(num)")
        if num == hitNum {
            // 当たり
            let num = Int.random(in: 0...10)
            let startSound: String
            if num < 7 {
                startSound = StartCorrectSounnds.drum.rawValue
            } else if num < 8 {
                startSound = StartCorrectSounnds.dragon.rawValue
            } else {
                startSound = StartCorrectSounnds.thunder.rawValue
            }
            playSound(resource: startSound)
            
            sleep(2)
            audioPlayer.stop()
            let sound = correct.randomElement()?.rawValue ?? CorrectSounds.sword.rawValue
            playSound(resource: sound)
            okBtnAlert(message: "アタリ")
        } else {
            // ハズレ
            let startSound = StartSounds.drum.rawValue
            playSound(resource: startSound)
            sleep(2)
            audioPlayer.stop()
            playSound(resource: "incorrect_answer")
            okBtnAlert(message: "ハズレ")
        }
        turnButton.isSelected = false
    }

    ///
    func startAnimate() {
        
    }
}
