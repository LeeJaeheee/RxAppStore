//
//  SearchViewModel.swift
//  RxAppStore
//
//  Created by 이재희 on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: ViewModelType {

    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
        let modelSelected: ControlEvent<SearchResult>
    }
    
    struct Output {
        let searchList: PublishSubject<[SearchResult]>
        let modelSelected: ControlEvent<SearchResult>
    }
    
    func transform(input: Input) -> Output {
        var searchList = PublishSubject<[SearchResult]>()
        
        return Output(searchList: searchList, modelSelected: input.modelSelected)
    }
    
}
