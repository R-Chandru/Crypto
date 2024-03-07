//
//  CryptoListView.swift
//  Crypto
//
//  Created by chandru on 06/03/24.
//

import UIKit

class CryptoListView: UIViewController, CryptoListViewProtocol {
    
    var presenter: CryptoListPresenterProtocol?
    
    private var cryptoList: [CryptoCurrency] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var cryptoTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 50
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .regular, scale: .large)
        button.setImage(UIImage(systemName: "slider.horizontal.3", withConfiguration: imageConfig) , for: UIControl.State.normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(filterButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        addFilterButton()
        addCryptoTableView()
        addLoadingView()
        presenter?.fetchCryptoCurrencies()
    }
    
    private func configureNavBar() {
        title = CryptoListConstants.titleName
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: CryptoListConstants.titleName, style: UIBarButtonItem.Style.plain, target: self, action: nil)
        
        // Search Bar Related
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: CryptoListConstants.searchPlaceholder)
        searchController.searchBar.delegate = self
    }
    
    private func addFilterButton() {
        NSLayoutConstraint.activate([
            filterButton.widthAnchor.constraint(equalToConstant: 28),
            filterButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
    }
    
    private func addCryptoTableView() {
        cryptoTableView.addSaveViewTo(view, leftOffset: 16, rightOffset: 16)
    }
    
    private func addLoadingView() {
        loadingView.addCenterAlignedViewTo(view)
    }

    func updateCryptoList(with cryptoList: [CryptoCurrency]) {
        self.cryptoList = cryptoList
        self.loadingView.removeFromSuperview()
        self.cryptoTableView.reloadData()
    }
    
    @objc func filterButtonClicked() {
        presenter?.showFilters()
    }
}


//MARK: Table Delegate Methods
extension CryptoListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CryptoListTableCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: CryptoListTableCell.identifier) as? CryptoListTableCell {
            cell = reuseCell
        } else {
            cell = CryptoListTableCell(style: .default, reuseIdentifier: CryptoListTableCell.identifier)
        }
        
        if let cryptoCurrency = cryptoList[safe: indexPath.row] {
            cell.updateCryptoDetails(with: cryptoCurrency)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


//MARK: Search Delegate Methods
extension CryptoListView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.performCryptoSearch(for: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.cancelCryptoSearch()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        updateCryptoList(with: [])
    }
    
}
