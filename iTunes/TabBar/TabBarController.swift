//
//  TabBarController.swift
//  iTunes
//
//  Created by 전준영 on 8/9/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
        
        enum TabBase: Int, CaseIterable {
            case today, game, app, arcade, search
            
            var title: String {
                switch self {
                case .today: 
                    return "투데이"
                case .game: 
                    return "게임"
                case .app: 
                    return "앱"
                case .arcade: 
                    return "아케이드"
                case .search: 
                    return "검색"
                }
            }
            
            var image: UIImage? {
                switch self {
                case .today: 
                    return UIImage(systemName: "book")
                case .game:
                    return UIImage(systemName: "gamecontroller")
                case .app:
                    return UIImage(systemName: "square.stack.fill")
                case .arcade:
                    return UIImage(systemName: "star")
                case .search:
                    return UIImage(systemName: "magnifyingglass")
                }
            }
            
            var viewController: UIViewController {
                switch self {
                case .today: 
                    return TodayViewController()
                case .game: 
                    return GameViewController()
                case .app: 
                    return AppViewController()
                case .arcade: 
                    return ArcadeViewController()
                case .search: 
                    return SearchViewController()
                }
            }
        }
        
        let vc = TabBase.allCases.map { tabView in
            let navItem = UINavigationController(rootViewController: tabView.viewController)
            navItem.tabBarItem = UITabBarItem(title: tabView.title, image: tabView.image, tag: tabView.rawValue)
            return navItem
        }
        
        setViewControllers(vc, animated: true)
    }
}

