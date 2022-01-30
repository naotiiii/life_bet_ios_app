//
//  ViewController.swift
//  life-bet
//
//  Created by naoto kojima on 2022/01/24.
//

import UIKit

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
    
    // MARK: - func
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.setBottomBannerView()
        self.initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    // 初期画面設定
    private func initView() {
        // title 設定
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    // Startボタン タップ時
    @IBAction func tappedStartBtn(_ sender: Any) {
        // 人数がみ入力の場合
        guard let numberStr = self.number, number != CommonWords.empty() else {
            let okButton: UIAlertAction = UIAlertAction.init(title: CommonWords.ok(), style: .cancel, handler: nil)
            let ac: UIAlertController = UIAlertController.init(title: CommonWords.empty(), message: CommonWords.explainNumber(), preferredStyle: .alert)
            ac.addAction(okButton)
            self.present(ac, animated: true, completion: nil)
            return
        }
        
        let numberOfPeople = Int(numberStr)
        // nilチェック
        guard let number = numberOfPeople else {
            self.okBtnAlert(message: CommonWords.explainNumber())
            return
        }
        
        // 値の範囲 0<30
        guard number > 0, number <= 30 else {
            self.okBtnAlert(message: CommonWords.limitRangeNumber())
            self.percentTextField.text = CommonWords.empty()
            return
        }
        
   //     let sb = UIStoryboard.init(name: "Play", bundle: nil)
   //     let vc = sb.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
     //   vc.number = number
       // self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension MainViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

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
