//
//  TabBarController.swift
//  Weather
//
//  Created by Macbook on 19.12.2023.
//

import UIKit

class TabBarController: UITabBarController {
    //MARK: - Live cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTabBar()
    }
    //MARK: - Metods
    
    private func getTabBar() {
        let iconStartView = WeatherViewController()
        let iconCityList = CityListViewController()
        
        let navigationStartView = UINavigationController(rootViewController: iconStartView)
        let navigationCityView = UINavigationController(rootViewController: iconCityList)
        
        navigationStartView.tabBarItem = UITabBarItem(title: LocalConstants.startViewTitle, image: UIImage(systemName: LocalConstants.startViewIcon), tag: 1)
        navigationCityView.tabBarItem = UITabBarItem(title: LocalConstants.cityViewTitle, image: UIImage(systemName: LocalConstants.cityViewIcon), tag: 2)
        
        setViewControllers([navigationStartView, navigationCityView], animated: true)
    }
}
//MARK: - Extension
extension TabBarController {
    private struct LocalConstants{
        static let startViewTitle = "Погода где я"
        static let startViewIcon = "cloud.sun"
        static let cityViewTitle = "Погода по городам"
        static let cityViewIcon = "mappin.circle.fill"
    }
}
