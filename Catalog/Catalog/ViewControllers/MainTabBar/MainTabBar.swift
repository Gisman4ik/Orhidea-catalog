//
//  MainTabBar.swift
//  Catalog
//
//  Created by Artur Radziukhin on 21.05.21.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor(named: "CatalogWhiteColor")
        self.tabBar.tintColor = UIColor.black
        self.tabBar.unselectedItemTintColor = .systemGray2
        self.viewControllers = getVCs()
    }

    func getVCs() -> [UIViewController] {
        var controllers = [UIViewController]()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let mainCatalogVC = storyboard.instantiateViewController(withIdentifier: String(describing: CatalogVC.self)) as? CatalogVC else {
            return controllers
        }
        mainCatalogVC.title = "Каталог"
        mainCatalogVC.tabBarItem = UITabBarItem(title: "Каталог", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        let mainCatalogVCNav = UINavigationController(rootViewController: mainCatalogVC)
        mainCatalogVCNav.navigationBar.barTintColor = UIColor(named: "CatalogWhiteColor")
        
        guard let favoriteVC = storyboard.instantiateViewController(withIdentifier: String(describing: FavoriteVC.self)) as? FavoriteVC else {
            return controllers
        }
        favoriteVC.title = "Избранное"
        favoriteVC.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart"), tag: 1)
        favoriteVC.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        let favoriteVCNav = UINavigationController(rootViewController: favoriteVC)
        favoriteVCNav.navigationBar.barTintColor = UIColor(named: "CatalogWhiteColor")
        
        guard let profileVC = storyboard.instantiateViewController(withIdentifier: String(describing: ProfileVC.self)) as? ProfileVC else {
            return controllers
        }
        profileVC.title = "Профиль"
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 3)
        profileVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        let profileVCNav = UINavigationController(rootViewController: profileVC)
        profileVCNav.navigationBar.barTintColor = UIColor(named: "CatalogWhiteColor")
        
        guard let cartVC = storyboard.instantiateViewController(withIdentifier: String(describing: CartVC.self)) as? CartVC else {
            return controllers
        }
        cartVC.title = "Корзина"
        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), tag: 2)
        cartVC.tabBarItem.selectedImage = UIImage(systemName: "cart.fill")
        let cartVCNav = UINavigationController(rootViewController: cartVC)
        cartVCNav.navigationBar.barTintColor = UIColor(named: "CatalogWhiteColor")
        
        controllers.append(mainCatalogVCNav)
        controllers.append(favoriteVCNav)
//        controllers.append(profileVCNav)
        controllers.append(cartVCNav)
        
        return controllers
    }
}
