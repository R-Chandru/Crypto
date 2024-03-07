//
//  CryptoListInteractor.swift
//  Crypto
//
//  Created by chandru on 06/03/24.
//

import Foundation

class CryptoListInteractor: CryptoListInteractorProtocol {
    
    var presenter: CryptoListPresenterProtocol?
    var selectedFilters: Set<CryptoCoinType> = []
    
    private var cryptoList: [CryptoCurrency] = []
    private var filteredList: [CryptoCurrency] = []
    
    func fetchCryptoCurrencies(from urlString: String, completion: @escaping (Result<[CryptoCurrency], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CryptoResponse.self, from: data)
                self.cryptoList = response.cryptocurrencies
                completion(.success(self.cryptoList))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func performCryptoSearch(for searchText: String) {
        applyFilter(for: selectedFilters)
        let searchText = searchText.lowercased()
        let searchResults = filteredList.filter { crypto in
            return crypto.name.lowercased().contains(searchText) || crypto.symbol.lowercased().contains(searchText)
        }
        presenter?.updateCryptoList(with: searchResults)
    }
    
    func applyFilter(for filters: Set<CryptoCoinType>) {
        filteredList = cryptoList
        
        for filterType in filters {
            switch filterType {
            case .activeCoins:
                filteredList = filteredList.filter { $0.isActive }
            case .inactiveCoins:
                filteredList = filteredList.filter { !$0.isActive }
            case .onlyTokens:
                filteredList = filteredList.filter { $0.type == CryptoListConstants.token }
            case .onlyCoins:
                filteredList = filteredList.filter { $0.type == CryptoListConstants.coin }
            case .newCoins:
                filteredList = filteredList.filter { $0.isNew }
            }
        }
        
        selectedFilters = filters
        presenter?.updateCryptoList(with: filteredList)
    }
    
    func cancelCryptoSearch() {
        applyFilter(for: selectedFilters)
        presenter?.updateCryptoList(with: filteredList)
    }
    
}
