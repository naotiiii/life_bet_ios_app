//
//  SettingViewController.swift
//  life-bet
//
//  Created by naoto kojima on 2022/02/23.
//

import Foundation
import UIKit

class SettingViewController: BaseViewController {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    /// 保存した値取得
    var settingInfo: SettingInfo = SettingInfo()
        
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        setBottomBannerView()
                
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 読み込み処理
        settingInfo = UserDefaults.settingInfo ?? SettingInfo()
        
        if settingInfo.slo == nil {
            settingInfo.slo = 30.0
        }

        if settingInfo.pati == nil {
            settingInfo.pati = 18.0
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 保存処理
        UserDefaults.settingInfo = settingInfo
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension SettingViewController: UITableViewDataSource {
    
    /// セクション
    enum SECTIONS: CaseIterable {
        case RotationUnit
    }
    
    /// セル
    enum CELLS: CaseIterable {
        case slo
        case pati
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return SECTIONS.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CELLS.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingInfoCell", for: indexPath)
        
        let title = cell.viewWithTag(1) as! UILabel
        let textField = cell.viewWithTag(2) as! UITextField

        if CELLS.allCases[indexPath.row] == CELLS.slo {
            title.text = CommonWords.settingSlo()
            textField.text = String(settingInfo.slo ?? 30.0)
        } else if CELLS.allCases[indexPath.row] == CELLS.pati {
            title.text = CommonWords.settingPati()
            textField.text = String(settingInfo.pati ?? 18.0)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingViewController: UITableViewDelegate {



}
