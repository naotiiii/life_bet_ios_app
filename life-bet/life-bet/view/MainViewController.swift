//
//  ViewController.swift
//  life-bet
//
//  Created by naoto kojima on 2022/01/24.
//

import UIKit

enum GameType {
    case PERCENT
    case LOTTERY
}

/// MainViewContorller
class MainViewController: BaseViewController {

    
    // MARK: - IBOutlet
    // 数字を入力する TextField
    @IBOutlet weak var percentTextField: UITextField!
    // percentButton
    @IBOutlet weak var percentButton: UIButton!
    // 抽選ボタン
    @IBOutlet weak var lotteryButton: UIButton!
    // 入力値
    var number: String?
    
    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.setBottomBannerView()
        self.initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// 画面遷移時に値渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_percent" {
            let percent = segue.destination as? PercentViewController
            percent?.denominator = Int(percentTextField.text!)
        }
        else if segue.identifier == "segue_lottery" {
            let lottery = segue.destination as? NumberDecideViewController
            lottery?.number = Int(percentTextField.text!)
        }
    }
    
    // MARK: - private func
    // 初期画面設定
    private func initView() {
        // title 設定
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    /// 入力フィールドチェック
    private func validateText(type: GameType) -> Bool {
        /// バリデーション アラート表示
        func validateAlerat() {
            if type == .PERCENT {
                okBtnAlert(message: CommonWords.emptyValidationPercent())
            } else {
                okBtnAlert(message: CommonWords.emptyValidationLottery())
            }
        }
        
        guard let percent = percentTextField.text else {
            /// テキストが空
            validateAlerat()
            return false
        }
        
        let intPercent = Int(percent)
                
        if let intPercent = intPercent {
            if (intPercent <= 0) {
                validateAlerat()
                return false
            }

            if (20000 < intPercent) {
                validateAlerat()
                return false
            }
        } else {
            // intPercentがnullの場合
            validateAlerat()
            return false
        }
        return true
    }

    // MARK: - @IBAction
    @IBAction func onPercentButtonClicked(_ sender: UIButton) {
        if validateText(type: .PERCENT) {
            performSegue(withIdentifier: "segue_percent", sender: nil)
        }
    }
    
    @IBAction func onLotteryButtonTapped(_ sender: UIButton) {
        if validateText(type: .LOTTERY) {
            performSegue(withIdentifier: "segue_lottery", sender: nil)
        }
    }
}

// MARK: - extension UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    
    private func addToolbar(textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressd))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton, spaceButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        percentTextField.delegate = self
        percentTextField.inputAccessoryView = toolbar
    }

    @objc func donePressd() {
        self.view.endEditing(true)
    }
}
