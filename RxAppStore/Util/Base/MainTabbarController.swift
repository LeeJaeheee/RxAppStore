//
//  MainTabbarController.swift
//  RxAppStore
//
//  Created by 이재희 on 4/8/24.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let todayNavigation = configureNavigationController(controller: UIViewController(), title: "투데이", imageName: "doc.text.image")
        let gameNavigation = configureNavigationController(controller: UIViewController(), title: "게임", imageName: "gamecontroller")
        let appNavigation = configureNavigationController(controller: UIViewController(), title: "앱", imageName: "square.stack.3d.up.fill")
        let arcadeNavigation = configureNavigationController(controller: UIViewController(), title: "Arcade", imageName: "figure.play")
        let searchNavigation = configureNavigationController(controller: SearchViewController(viewModel: SearchViewModel()), title: "검색", imageName: "magnifyingglass")
        
        viewControllers = [todayNavigation, gameNavigation, appNavigation, arcadeNavigation, searchNavigation]
    }

    private func configureNavigationController(controller: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: controller)
        navigation.navigationBar.prefersLargeTitles = true
        controller.navigationItem.title = title
        controller.view.backgroundColor = .white
        navigation.tabBarItem.title = title
        navigation.tabBarItem.image = UIImage(systemName: imageName)
        return navigation
    }
}
