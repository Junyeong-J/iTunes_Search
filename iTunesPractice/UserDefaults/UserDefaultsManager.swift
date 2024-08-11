//
//  UserDefaultsManager.swift
//  iTunesPractice
//
//  Created by 전준영 on 8/11/24.
//

import Foundation

final class UserDefaultsManager {
    
    private enum UserDefaultsKey: String {
        case searchWordKey = "searchWord"
    }
    
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    var recentWord: [String] {
        
        get {
            return UserDefaults.standard.array(forKey: UserDefaultsKey.searchWordKey.rawValue) as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.searchWordKey.rawValue)
        }
        
    }
}
