//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Luca Archidiacono on 24.11.20.
//

import UIKit

enum ItemInfoType {
    case repos, gists, following, followers
}

class GFItemInfoView: UIView {
    fileprivate let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 6
        return stack
    }()
    
    fileprivate let topStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 12
        return stack
    }()
    
    let symbolImageView = UIImageView()
    
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(containerStackView)
        
        symbolImageView.contentMode = .scaleAspectFit
        symbolImageView.tintColor = .label
        //stackview needs to be .fill. none other distribution types.
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        symbolImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        topStackView.addArrangedSubview(symbolImageView)
        topStackView.addArrangedSubview(titleLabel)
        
        containerStackView.addArrangedSubview(topStackView)
        containerStackView.addArrangedSubview(countLabel)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
}
