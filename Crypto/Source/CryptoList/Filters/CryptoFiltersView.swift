//
//  CryptoFiltersView.swift
//  Crypto
//
//  Created by chandru on 08/03/24.
//

import UIKit

class CryptoFiltersView: UIViewController {
    
    let filters = ["Active Coins", "Inactive Coins", "Only Tokens", "Only Coins", "New Coins"]
    let filterTypes: [CryptoCoinType] = [.activeCoins, .inactiveCoins, .onlyTokens, .onlyCoins, .newCoins]
    
    var selectedFilters: Set<CryptoCoinType> = []
    var parentDelegate: CryptoListInteractorProtocol? {
        didSet {
            selectedFilters = parentDelegate?.selectedFilters ?? []
            filtersView.reloadData()
        }
    }
    
    lazy var filtersView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(CryptoFiltersCell.self, forCellWithReuseIdentifier: CryptoFiltersCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = CryptoListConstants.filtersTitleName
        view.backgroundColor = .systemBackground
        filtersView.addViewTo(view, leftOffset: 15, rightOffset: 15)
    }
}

extension CryptoFiltersView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CryptoFiltersCell.identifier, for: indexPath) as? CryptoFiltersCell else {
            return UICollectionViewCell()
        }
        
        if selectedFilters.contains(filterTypes[indexPath.item]) {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            cell.isSelected = true
        }
        cell.configure(with: filters[indexPath.item])
        return cell
    }
}

extension CryptoFiltersView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CryptoFiltersCell else {
            return
        }
        
        cell.isSelected = true
        selectedFilters.insert(filterTypes[indexPath.item])
        parentDelegate?.applyFilter(for: selectedFilters)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CryptoFiltersCell else {
            return
        }
        
        cell.isSelected = false
        selectedFilters.remove(filterTypes[indexPath.item])
        parentDelegate?.applyFilter(for: selectedFilters)
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        
        return attributes
    }
}
