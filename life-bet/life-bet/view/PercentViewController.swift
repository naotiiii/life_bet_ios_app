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


    }
    
    /// ボタンに指が触れたら発生
    @IBAction func touchDownTurnButton(_ sender: UIButton) {
        let num = Int.random(in: 1...denominator!)
        print("output number: \(num)")
        if num == hitNum {
            // 当たり
            okBtnAlert(message: "アタリ")
        } else {
            okBtnAlert(message: "ハズレ")
        }
    }


    ///
    func startAnimate() {
        
    }
}
