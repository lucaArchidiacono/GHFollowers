//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Luca Archidiacono on 24.11.20.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    let containerStackView = UIStackView()
    let itemStackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
    
    let user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
    }
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        containerStackView.axis = .vertical
        containerStackView.distribution = .fill
        containerStackView.spacing = 6
        
        containerStackView.addArrangedSubview(itemStackView)
        containerStackView.addArrangedSubview(actionButton)
        
        itemStackView.axis = .horizontal
        itemStackView.distribution = .fillEqually
        
        itemStackView.addArrangedSubview(itemInfoViewOne)
        itemStackView.addArrangedSubview(itemInfoViewTwo)
    }

    private func layoutUI() {
        view.addSubview(containerStackView)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            containerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
}
