//
//  CryptoListProtocols.swift
//  Crypto
//
//  Created by chandru on 08/03/24.
//

import Foundation

protocol CryptoListRouterProtocol {
    var view: CryptoList? { get }
    
    func showFilters(with delegate: CryptoListInteractorProtocol?)
    static func createModule() -> CryptoListRouterProtocol
}

protocol CryptoListViewProtocol {
    var presenter: CryptoListPresenterProtocol? { get set }
    
    func updateCryptoList(with cryptoList: [CryptoCurrency])
}

protocol CryptoListPresenterProtocol {
    var view: CryptoListViewProtocol? { get set }
    var router: CryptoListRouterProtocol? { get set }
    var interactor: CryptoListInteractorProtocol? { get set }
    
    func showFilters()
    func cancelCryptoSearch()
    func fetchCryptoCurrencies()
    func performCryptoSearch(for searchText: String)
    func updateCryptoList(with cryptoList: [CryptoCurrency])
}

protocol CryptoListInteractorProtocol {
    var presenter: CryptoListPresenterProtocol? { get set }
    var selectedFilters: Set<CryptoCoinType> { get set }
    
    func cancelCryptoSearch()
    func performCryptoSearch(for searchText: String)
    func applyFilter(for filters: Set<CryptoCoinType>)
    func fetchCryptoCurrencies(from urlString: String, completion: @escaping (Result<[CryptoCurrency], Error>) -> Void)
}
