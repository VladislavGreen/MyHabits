//
//  TabBarController.swift
//  MyHabits
//
//  Created by Vladislav Green on 9/26/22.
//
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let habitsViewController = UINavigationController (rootViewController: HabitsViewController())
        let infoViewController = UINavigationController (rootViewController: InfoViewController())
        
        self.viewControllers = [habitsViewController, infoViewController]
        
        let item1 = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        let item2 = UITabBarItem(title: "Информация", image:  UIImage(systemName: "info.circle.fill"), tag: 1)

        habitsViewController.tabBarItem = item1
        infoViewController.tabBarItem = item2
        
        UITabBar.appearance().backgroundColor = .white
    }
    
}
