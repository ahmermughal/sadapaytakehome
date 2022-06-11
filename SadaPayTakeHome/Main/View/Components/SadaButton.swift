//
//  SadaButton.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import UIKit

class SadaButton: UIButton {
    
    init(borderColor : UIColor, title: String) {
        super.init(frame: .zero)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 8
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        self.setTitleColor(borderColor, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
