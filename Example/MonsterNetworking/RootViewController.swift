//
//  RootViewController.swift
//  Monster_Example
//
//  Created by mac on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {
    
    override func viewDidLoad() {
        
        let homeVC = VideoListController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem.title = "斗鱼"
        
        let categoryVC = TodayViewController()
        let categoryNav = UINavigationController(rootViewController: categoryVC)
        categoryNav.tabBarItem.title = "虎牙"
        
        self.viewControllers = [homeNav, categoryNav]
    }
    
    
}
