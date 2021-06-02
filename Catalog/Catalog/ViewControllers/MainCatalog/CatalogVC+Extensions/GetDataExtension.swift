//
//  getDataExtension.swift
//  Catalog
//
//  Created by Artur Radziukhin on 2.06.21.
//

import UIKit

extension CatalogVC {
    func getCatalogData() {
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        setLoadingView()
        NetworkManager.shared.getCatalogData { [self] (result) in
            DataManager.shared.catalogData = result
            DataManager.shared.filteredCatalogProducts = result.products
            let favoriteProductsIDs = RealmManager.shared.readFromFavorites()
            let cartProductsIDs = RealmManager.shared.readFromCart()
            for product in DataManager.shared.filteredCatalogProducts  {
                for favoriteID in favoriteProductsIDs {
                    if product.uid == favoriteID {
                        product.isInFavorite = true
                        DataManager.shared.favoriteProducts.append(product)
                    }
                }
                for cartID in cartProductsIDs {
                    if product.uid == cartID.uid {
                        product.isInCart = true
                        product.amountInCart = cartID.amount
                        DataManager.shared.cartProducts.append(product)
                    }
                }
            }
            collectionView.reloadData()
            loadingView.isHidden = true
            navigationController?.isNavigationBarHidden = false
            tabBarController?.tabBar.isHidden = false
        } failure: { error in
            print(error)
        }
    }
}
