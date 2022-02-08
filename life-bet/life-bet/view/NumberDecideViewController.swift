//
//  NumberDecideViewController.swift
//  life-bet
//
//  Created by naoto kojima on 2022/02/03.
//

import UIKit

/// 番号決め画面 NumberDecideViewController
class NumberDecideViewController: BaseViewController {

    // MARK: - paramters
    /// 千くらいの数
    @IBOutlet weak var thousandNumberLabel: UILabel!

    /// 百くらいの数
    @IBOutlet weak var hundredNumberLabel: UILabel!

    /// 十くらいの数
    @IBOutlet weak var tenNumberLabel: UILabel!
    
    /// 一くらいの数
    @IBOutlet weak var oneNumberLabel: UILabel!
    
    // 抽選するボタン
    @IBOutlet weak var turnButton: UIButton!
    
    var number: Int?
    
    // 抽選番号 配列
    var numArray: [Int] = []

    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()

        if number == nil {
            navigationController?.popViewController(animated: true)
            return
        }
        
        numArray = [Int](1..<(number! + 1))
        print("抽選番号: \(numArray)")
    }
    
    
    // MARK: - @IBOutlet func

    /// 抽選ボタンタップ時の処理
    ///
    /// - Parameters ボタン
    @IBAction func onLotteryButtonTapped(_ sender: UIButton) {
        if let outputNumnber = numArray.randomElement() {
            okBtnAlert(message: String(outputNumnber))
            // 既に表示した番号を削除
            if let index = numArray.firstIndex(of: outputNumnber) {
                print("delete index: \(index)")
                numArray.remove(at: index)
            }
        } else {
            /// 番号を全て表示した時
            let ac = UIAlertController(title: "", message: "全ての番号が出ました。", preferredStyle: .alert)
            let button = UIAlertAction(title: CommonWords.backBtnTitle(), style: .cancel) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            ac.addAction(button)
            present(ac, animated: true, completion: nil)
        }
    }
}
