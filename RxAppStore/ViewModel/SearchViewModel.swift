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
    
    let disposeBag = DisposeBag()

    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
        let modelSelected: ControlEvent<SearchResult>
    }
    
    struct Output {
        let searchList: PublishRelay<[SearchResult]>
        let modelSelected: ControlEvent<SearchResult>
    }
    
    func transform(input: Input) -> Output {
        let searchList = PublishRelay<[SearchResult]>()
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .flatMap { 
                SearchAPIService.shared.fetchSearchData(query: $0)
            }
            .subscribe(with: self, onNext: { owner, result in
                switch result {
                case .success(let searchModel):
                    let data = searchModel.results
                    searchList.accept(data)
                case .failure(_):
                    print("========")
                    break
                }
            }, onError: { _, _ in
                print("TransformError")
            }, onCompleted: { _ in
                print("TransformCompleted")
            }, onDisposed: { _ in
                print("TransformDisposed")
            })
            .disposed(by: disposeBag)
        
        return Output(searchList: searchList, modelSelected: input.modelSelected)
    }
    
}
