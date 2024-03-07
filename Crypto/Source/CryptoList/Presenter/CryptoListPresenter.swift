//
//  CryptoListPresenter.swift
//  Crypto
//
//  Created by chandru on 06/03/24.
//

import Foundation

class CryptoListPresenter : CryptoListPresenterProtocol {
    
    let cryptoCurrenciesURL = "https://run.mocky.io/v3/ac7d7699-a7f7-488b-9386-90d1a60c4a4b"
    var view: CryptoListViewProtocol?
    var router: CryptoListRouterProtocol?
    var interactor: CryptoListInteractorProtocol?
    
    
    // View Methods
    
    func updateCryptoList(with cryptoList: [CryptoCurrency]) {
        view?.updateCryptoList(with: cryptoList)
    }
    
    
    // Interactor Methods
    func fetchCryptoCurrencies() {
        interactor?.fetchCryptoCurrencies(from: cryptoCurrenciesURL, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let currencies):
                    self.updateCryptoList(with: currencies)
                case .failure(let error):
                    print("Error fetching cryptocurrencies: \(error)")
                }
            }
        })
    }
    
    func performCryptoSearch(for searchText: String) {
        interactor?.performCryptoSearch(for: searchText)
    }
    
    func cancelCryptoSearch() {
        interactor?.cancelCryptoSearch()
    }
    
    
    // Router Methods
    func showFilters() {
        router?.showFilters(with: interactor)
    }
}
