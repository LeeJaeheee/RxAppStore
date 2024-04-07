//
//  ViewModelBindableType.swift
//  RxAppStore
//
//  Created by 이재희 on 4/6/24.
//

import UIKit

protocol ViewModelBindableType {
    associatedtype ViewModel: ViewModelType
    
    var viewModel: ViewModel! { get set }
    
    func bindViewModel()
}

// ViewModelBindableType 프로토콜을 채택한 타입 중에서 Self가 UIViewController일 때만 해당하는 extension을 추가
// 근데 왜 mutating 키워드를 요구할까?
// ViewModelBindableType에서 AnyObject를 채택하면 되긴 한데 이유를 모르겠다...
extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(viewModel: Self.ViewModel) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
