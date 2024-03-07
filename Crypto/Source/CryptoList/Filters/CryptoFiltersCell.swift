//
//  File.swift
//  Crypto
//
//  Created by chandru on 08/03/24.
//

import Foundation
import UIKit

class CryptoFiltersCell: UICollectionViewCell {
    
    static let identifier = "FilterCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .tertiarySystemFill
        layer.masksToBounds = true
        layer.cornerRadius = 5
        titleLabel.addSaveViewTo(self, topOffset: 10, leftOffset: 10, rightOffset: 10, bottomOffset: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .orange
                titleLabel.textColor = .label
            } else {
                backgroundColor = .tertiarySystemFill
                titleLabel.textColor = .label
            }
        }
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
