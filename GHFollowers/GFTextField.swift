//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Luca Archidiacono on 21.10.20.
//

import UIKit

class GFTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false // uses autolayout
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label //cursor color
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title1)
        adjustsFontSizeToFitWidth = true //font auto-shrinks if username is big
        minimumFontSize = 12 // minimum font size
        
        backgroundColor = .tertiarySystemGroupedBackground
        autocorrectionType = .no // no autocorrection
        
        placeholder = "Enter a username"
    }
    
}
