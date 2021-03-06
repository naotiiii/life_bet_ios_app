//
//  CommonWords.swift
//  life-bet
//
//  Created by naoto kojima on 2022/01/24.
//

import Foundation

/// CommonWords
class CommonWords {
    // MARK: - 共通
    public class func ok() -> String { return "OK" }
    public class func close() -> String { return "CLOSE"}
    public class func empty() -> String { return "" }
    public class func backBtnTitle() -> String { return "Back"}
    
    // MARK: - 広告
    // バナー広告
    public class func bannerID() -> String { return "ca-app-pub-8858591747711781/2228436889" }
    public class func testBannerID() -> String { return "ca-app-pub-3940256099942544/2934735716" }
    // インンタースティシャル
    public class func intersitialID() -> String { return "ca-app-pub-8858591747711781/1253238893" }
    public class func testInterstitialID() -> String { return "ca-app-pub-3940256099942544/4411468910" }
    
    
    // MainView
    public class func emptyValidationPercent() -> String { return "1~240000の範囲の数字で入力してください。"}
    public class func emptyValidationLottery() -> String { return "1~3000の範囲の数字で入力してください。"}
    
    // PlayView
    public class func numberLost() -> String { return "ハズレ" }
    public class func numberHit() -> String { return "アタリ" }

    
    // SettingView
    public class func settingSlo() -> String { return "20円・5円 1000円当たりの回転率"}
    public class func settingPati() -> String { return "4円・1円 1000円あたりの回転数"}
    
    
}
