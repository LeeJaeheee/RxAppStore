//
//  DetailViewModel.swift
//  RxAppStore
//
//  Created by 이재희 on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel: ViewModelType {
    
    let selectedModelData: SearchResult
    
    init(data: SearchResult) {
        self.selectedModelData = data
        print("========")
        print(selectedModelData)
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
}
