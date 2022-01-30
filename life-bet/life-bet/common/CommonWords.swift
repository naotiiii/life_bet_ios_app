//
//  CommonWords.swift
//  life-bet
//
//  Created by naoto kojima on 2022/01/24.
//

import Foundation

/// CommonWords
class CommonWords: NSObject {
    // MARK: - 共通
    public class func ok() -> String { return "OK" }
    public class func close() -> String { return "CLOSE"}
    public class func empty() -> String { return "" }
    
    // MARK: - 広告
    // バナー広告
    public class func bannerID() -> String { return "ca-app-pub-8858591747711781/2228436889" }
    public class func testBannerID() -> String { return "ca-app-pub-3940256099942544/2934735716" }
    // インンタースティシャル
    public class func intersitialID() -> String { return "ca-app-pub-8858591747711781/4132828653" }
    public class func testInterstitialID() -> String { return "ca-app-pub-3940256099942544/4411468910" }
    
    
    // MainView
    public class func mainViewNavigationTitle() -> String { return "Kingdom Gama" }
    public class func mainViewLabelTitle() -> String { return "Kingdom Game\n~王様ゲーム~" }
    public class func explainLabelText() -> String { return "Plese enter the number of peolple!\n~人数を入れてね！~"}
    public class func explainNumber() -> String { return "Plese enter the number of peolple!\n入力フォームに人数を入れてね!" }
    public class func limitRangeNumber() -> String { return "Please enter between 1 and 30\n1から30の間で入れてね!" }
    public class func startBtnTitle() -> String { return "START\n開始" }
    
    // PlayView
    public class func backBtnTitle() -> String { return "Back" }
    public class func headderTitle() -> String { return "Please select one\nひとつ選択してくだい。" }
    public class func finishGameTitle() -> String { return "Who is the King??\n王様だ〜れだ??" }
    public class func collectionTitle() -> String { return "King\nor\nCitizen" }
    public class func selectedCellTitle() -> String { return "Selected\n選択済" }
    public class func forExampleText() -> String { return "お題の例：\n・The first person shakes hands with the second person\n１番の人が、2番の人と握手。" }
    public class func everyoneNumber () -> String { return "それぞれの番号は" }
    public class func king() -> String { return "KING ~王様~" }

    public class func explainDisplayNumber() -> String { return "Display the number↓↓\nボタンタップで、番号を表示します↓↓" }
    public class func displayNumberBtnTitle() -> String { return "Correct Number" }
    
    // KingdomView
    public class func kingdomViewTitle() -> String { return "You are the King\nあなたは、王様です。" }
    public class func explainKingdom() -> String {
        return "Let's think about the theme\nテーマを考えておきましょう。"
    }
    
    
    // CitizenView
    public class func citizenViewTitle(number: Int) -> String { return "You are No.\(number)\nあなたは、\(number)番です。" }
    public class func explainCitizen() -> String { return "Check the number and press the button\n番号を確認し、ボタンを押してください。" }
    public class func confirmation() -> String { return "Confirmed\n確認済" }
}
