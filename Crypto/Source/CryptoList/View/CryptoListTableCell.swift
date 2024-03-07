//
//  CyptoListTableCell.swift
//  Crypto
//
//  Created by chandru on 06/03/24.
//

import UIKit

class CryptoListTableCell: UITableViewCell {
    
    static let identifier = "CyptoListTableCell"
    
    private let cellPadding: CGFloat = 10
    private let newCoinImageSize: CGFloat = 30
    private let coinTypeImageSize: CGFloat = 40
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var coinTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var newCoinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: CryptoListImageConstants.newCoin)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addNameLabel()
        addSymbolLabel()
        addNewImageView()
        addCoinTypeImageView()
    }
    
    private func addNameLabel() {
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: cellPadding),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func addSymbolLabel() {
        addSubview(symbolLabel)
        
        NSLayoutConstraint.activate([
            symbolLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: cellPadding),
            symbolLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -cellPadding),
            symbolLabel.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func addNewImageView() {
        addSubview(newCoinImageView)
        
        NSLayoutConstraint.activate([
            newCoinImageView.topAnchor.constraint(equalTo: topAnchor),
            newCoinImageView.widthAnchor.constraint(equalToConstant: newCoinImageSize),
            newCoinImageView.heightAnchor.constraint(equalToConstant: newCoinImageSize),
            newCoinImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func addCoinTypeImageView() {
        addSubview(coinTypeImageView)
        
        NSLayoutConstraint.activate([
            coinTypeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            coinTypeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            coinTypeImageView.widthAnchor.constraint(equalToConstant: coinTypeImageSize),
            coinTypeImageView.heightAnchor.constraint(equalToConstant: coinTypeImageSize)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCryptoDetails(with crypto: CryptoCurrency) {
        nameLabel.text = crypto.name
        symbolLabel.text = crypto.symbol
        newCoinImageView.isHidden = !crypto.isNew
        
        if crypto.isActive {
            coinTypeImageView.image = crypto.type == CryptoListConstants.token ?
                UIImage(named: CryptoListImageConstants.token) :
                UIImage(named: CryptoListImageConstants.activeCoin)
        } else {
            coinTypeImageView.image = UIImage(named: CryptoListImageConstants.inactiveCoin)
        }
    }

}
