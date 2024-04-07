//
//  SearchViewController.swift
//  RxAppStore
//
//  Created by 이재희 on 4/6/24.
//

import UIKit
import SnapKit

final class SearchViewController: BaseViewController<SearchViewModel> {
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.definesPresentationContext = true
        
       return searchController
    }()
    
    let tableView = UITableView()
    
    override func bind() {
        let input = SearchViewModel.Input(
            searchButtonTap: searchController.searchBar.rx.searchButtonClicked,
            searchText: searchController.searchBar.rx.text.orEmpty, 
            modelSelected: tableView.rx.modelSelected(SearchResult.self)
        )
        
        let output = viewModel.transform(input: input)
        
        output.searchList
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                let cellViewModel = SearchTableViewCellViewModel(searchResult: element)
                cellViewModel.downloadButtonTap
                    .bind(with: self) { owner, value in
                        print("\(value)앱 받기 버튼을 눌렀습니다.")
                    }
                    .disposed(by: cell.disposeBag)
                cell.bindViewModel(cellViewModel)
            }
            .disposed(by: disposeBag)
        
        output.modelSelected
            .bind(with: self) { owner, value in
                print(value)
            }
            .disposed(by: disposeBag)
        
        output.searchList.onNext([SearchResult(screenshotUrls: [], artworkUrl512: "aa", artistViewURL: "aa", currentVersionReleaseDate: Date(), releaseNotes: "", artistName: "이름이름", genres: ["장르"], trackName: "앱이름", description: "설명", averageUserRating: 4.7, userRatingCount: 111)])
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        navigationItem.title = "검색"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }

}
