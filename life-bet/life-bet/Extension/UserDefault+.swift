//
//  UserDefault+.swift
//  life-bet
//
//  Created by naoto kojima on 2022/02/23.
//

import Foundation

extension UserDefaults {

    static var settingInfo: SettingInfo? {
       
        get {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = UserDefaults.standard.data(forKey: UserDefaultsKey.settingInfoKey),
                  let info = try? jsonDecoder.decode(SettingInfo.self, from: data) else {
                      return SettingInfo()
                  }
            return info
        }
        set {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
            guard let data = try? jsonEncoder.encode(newValue) else {
                return
            }
            UserDefaults.standard.set(data, forKey: UserDefaultsKey.settingInfoKey)
        }
    }
}

struct UserDefaultsKey {
    static let settingInfoKey = "SettingInfo"
}
