//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Luca Archidiacono on 08.11.20.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let stackView = UIStackView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    
    var follower: Follower
    
    init(with follower: Follower) {
        self.follower = follower
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: follower.login) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.addChildVC(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.addChildVC(childVC: GFRepoItemVC(user: user), to: self.itemViewOne)
                    self.addChildVC(childVC: GFFollowerItemVC(user: user), to: self.itemViewTwo)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func layoutUI() {
        let padding: CGFloat = 20
        
        view.addSubview(headerView)
        view.addSubview(stackView)
        
        itemViews = [itemViewOne, itemViewTwo]
        
        for itemView in itemViews {
            stackView.addArrangedSubview(itemView)
        }
        
        //UIStackView approach
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    private func addChildVC(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
