//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Luca Archidiacono on 24.10.20.
//

import UIKit

class GFAlertVC: UIViewController {
    
    private let containerView = UIStackView()
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = GFBodyLabel(textAlignment: .center)
    private let actionButton = GFButton(backgroundColor: .systemPink, title: "Okay")
    
    private var alertTitle: String
    private var message: String
    private var buttonTitle: String
    
    private let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75) // opacity
        
        view.addSubview(containerView)
        
        configureContainerView()
        configureTitleLabel()
        configureMessageLabel()
        configureActionButton()
        
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(messageLabel)
        containerView.addArrangedSubview(actionButton)
    }
    
    private func configureContainerView() {
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        
        //UIStackView approach
        containerView.axis = NSLayoutConstraint.Axis.vertical
        containerView.distribution = UIStackView.Distribution.equalSpacing
        containerView.spacing = padding
        containerView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        containerView.isLayoutMarginsRelativeArrangement = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 220),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.text = alertTitle
    }
    
    private func configureMessageLabel() {
        messageLabel.text = message
        messageLabel.numberOfLines = 0
    }
    
    private func configureActionButton() {
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
