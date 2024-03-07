//
//  CryptoListRouter.swift
//  Crypto
//
//  Created by chandru on 06/03/24.
//

import Foundation
import UIKit

typealias CryptoList = CryptoListViewProtocol & UIViewController

class CryptoListRouter: CryptoListRouterProtocol {
    
    var view: CryptoList?
    
    static func createModule() -> CryptoListRouterProtocol {
        let router = CryptoListRouter()
        var view: CryptoListViewProtocol = CryptoListView()
        var presenter: CryptoListPresenterProtocol = CryptoListPresenter()
        var interactor: CryptoListInteractorProtocol = CryptoListInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.view = view as? CryptoList
        
        return router
    }
    
    func showFilters(with delegate: CryptoListInteractorProtocol?) {
        let filtersVC = CryptoFiltersView()
        filtersVC.parentDelegate = delegate
        
        let navigation = UINavigationController(rootViewController: filtersVC)
        navigation.modalPresentationStyle = .pageSheet
        
        if let sheet = navigation.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        view?.present(navigation, animated: true, completion: nil)
    }
    
}
