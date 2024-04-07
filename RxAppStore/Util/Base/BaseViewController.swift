//
//  BaseViewController.swift
//  RxAppStore
//
//  Created by 이재희 on 4/7/24.
//

import UIKit
import RxSwift

class BaseViewController<ViewModel: ViewModelType>: UIViewController {
    
    let viewModel: ViewModel
    
    let disposeBag = DisposeBag()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        configureHierarchy()
        configureLayout()
        configureView()
        bind()
    }
    
    func bind() { }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { }

}
