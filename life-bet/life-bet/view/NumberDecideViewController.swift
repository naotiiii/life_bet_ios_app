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
    @IBOutlet weak var thousandNumberLabel: UILabel! {
        didSet {
            thousandNumberLabel.alpha = 0
        }
    }

    /// 百くらいの数
    @IBOutlet weak var hundredNumberLabel: UILabel! {
        didSet {
            hundredNumberLabel.alpha = 0
        }
    }

    /// 十くらいの数
    @IBOutlet weak var tenNumberLabel: UILabel! {
        didSet {
            tenNumberLabel.alpha = 0
        }
    }
    
    /// 一くらいの数
    @IBOutlet weak var oneNumberLabel: UILabel! {
        didSet {
            oneNumberLabel.alpha = 0
        }
    }
    
    // 抽選するボタン
    @IBOutlet weak var turnButton: UIButton!
    
    var number: Int?
    
    // 抽選番号 配列
    var numArray: [Int] = []
    
    /// 広告表示カウント
    var interstitialCount = 0

    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBottomBannerView()
        circleButton(button: turnButton)

        if number == nil {
            navigationController?.popViewController(animated: true)
            return
        }
        
        numArray = [Int](1..<(number! + 1))
        print("抽選番号: \(numArray)")
    }
    
    
    // MARK: - @IBOutlet func

    @IBAction func onLotteryButtonTouchDown(_ sender: UIButton) {
        thousandNumberLabel.text = "0"
        hundredNumberLabel.text = "0"
        tenNumberLabel.text = "0"
        oneNumberLabel.text = "0"
        
        setLabelAlpha()
        
        turnButton.isSelected = true
        let startSound = StartSounds.drum.rawValue
        playSound(resource: startSound)
       // playSound(resource: StartSounds.tap_button.rawValue)
    }

    /// 抽選ボタンタップ時の処理
    ///
    /// - Parameters ボタン
    @IBAction func onLotteryButtonTapped(_ sender: UIButton) {
        interstitialCount += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.startAnimation()
            if let outputNumnber = self.numArray.randomElement() {
                self.showNumber(outputNumnber: outputNumnber)
            } else {
                /// 番号を全て表示した時
                let ac = UIAlertController(title: "", message: "全ての番号が出ました。", preferredStyle: .alert)
                let button = UIAlertAction(title: CommonWords.backBtnTitle(), style: .cancel) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
                ac.addAction(button)
                self.present(ac, animated: true, completion: nil)
            }
            if self.interstitialCount == 10 {
                if self.interstitial != nil {
                    self.interstitial?.present(fromRootViewController: self)
                }
                self.interstitialCount = 0
            }
        }
    }
    
    /// 番号表示
    func showNumber(outputNumnber: Int) {
        audioPlayer.stop()
        let strNum = String(format: "%04d", outputNumnber)
        let strArray = Array(strNum)
        thousandNumberLabel.text = String(strArray[0])
        hundredNumberLabel.text = String(strArray[1])
        tenNumberLabel.text = String(strArray[2])
        oneNumberLabel.text = String(strArray[3])
        
        // アタリの音を流す
        if outputNumnber == 1 {
            // キュイン
            playSound(resource: SpecialCorrectSounds.kyuin.rawValue)
        } else if outputNumnber <= 3 {
            // シャキン
            playSound(resource: SpecialCorrectSounds.syakin.rawValue)
        } else if outputNumnber <= 10 {
            let random = Int.random(in: 0...(correct.count - 1))
            playSound(resource: correct[random].rawValue)
        } else {
            playSound(resource: ResultSounds.do_don.rawValue)
        }
        
        // 既に表示した番号を削除
        if let index = numArray.firstIndex(of: outputNumnber) {
            print("delete index: \(index)")
            numArray.remove(at: index)
        }
    }
    
    /// 文字表示のアニメーション
    func startAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.transitionFlipFromRight]) {
            self.thousandNumberLabel.alpha = 1
            self.hundredNumberLabel.alpha = 1
            self.tenNumberLabel.alpha = 1
            self.oneNumberLabel.alpha = 1
        } completion: { _ in
            
        }
    }
    
    
    
    func setLabelAlpha() {
        self.thousandNumberLabel.alpha = 0
        self.hundredNumberLabel.alpha = 0
        self.tenNumberLabel.alpha = 0
        self.oneNumberLabel.alpha = 0
    }
}
