//
//  SubLabel.swift
//  RxAppStore
//
//  Created by 이재희 on 4/7/24.
//

import UIKit

class SubLabel: UILabel {
    init(textAlignment: NSTextAlignment = .left) {
        super.init(frame: .zero)
        
        self.textAlignment = textAlignment
        textColor = .secondaryLabel
        font = .systemFont(ofSize: 13, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
