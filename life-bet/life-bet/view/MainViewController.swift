//
//  ViewController.swift
//  life-bet
//
//  Created by naoto kojima on 2022/01/24.
//

import UIKit

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
    
    // MARK: - private func
    // 初期画面設定
    private func initView() {
        // title 設定
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    // MARK: - @IBAction
    @IBAction func onPercentButtonClicked(_ sender: UIButton) {
        


    }
    
    @IBAction func onLotteryButtonTapped(_ sender: UIButton) {
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
