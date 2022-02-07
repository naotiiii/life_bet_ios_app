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
    
    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - @IBOutlet
    /// 回すボタンタップ処理
    /// ボタン内で、指が離れた
    @IBAction func touchUpInsideTurnButton(_ sender: UIButton) {
        

    }
    
    /// ボタンに指が触れたら発生
    @IBAction func touchDownTurnButton(_ sender: UIButton) {

    }
}
