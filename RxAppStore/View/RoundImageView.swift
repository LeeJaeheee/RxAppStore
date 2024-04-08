//
//  RoundImageView.swift
//  RxAppStore
//
//  Created by 이재희 on 4/7/24.
//

import UIKit

class RoundImageView: UIImageView {
    
    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        contentMode = .scaleAspectFit
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
