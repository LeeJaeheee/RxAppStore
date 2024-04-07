//
//  SearchTableViewCell.swift
//  RxAppStore
//
//  Created by 이재희 on 4/7/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Cosmos

final class SearchTableViewCellViewModel {

    let appName: String
    let appIconURL: URL
    let rating: Double
    let ratingCount: Int
    let artistName: String
    let genre: String

    let downloadButtonTap = PublishRelay<String>()
    
    init(searchResult: SearchResult) {
        self.appName = searchResult.trackName
        self.appIconURL = URL(string: searchResult.artworkUrl512)!
        self.rating = searchResult.averageUserRating
        self.ratingCount = searchResult.userRatingCount
        self.artistName = searchResult.artistName
        self.genre = searchResult.genres.first!
    }
    
}

final class SearchTableViewCell: UITableViewCell {
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let appIconImageView = RoundImageView(cornerRadius: 8)
    
    private let downloadButton: UIButton = {
        var configuration = UIButton.Configuration.gray()
        configuration.cornerStyle = .capsule
        configuration.title = "받기"
        return UIButton(configuration: configuration)
    }()
    
    private let ratingView: CosmosView = {
        let view = CosmosView()
        view.settings.updateOnTouch = false
        view.settings.starSize = 15
        view.settings.starMargin = 0.0
        view.settings.filledColor = .secondaryLabel
        view.settings.filledBorderColor = .secondaryLabel
        view.settings.emptyBorderColor = .secondaryLabel
        view.rating = 0
        return view
    }()
    
    private let ratingCountLabel = SubLabel()
    
    private let artistNameLabel = SubLabel()
    
    private let genreLabel = SubLabel(textAlignment: .right)
    
    var disposeBag = DisposeBag()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ratingView, ratingCountLabel])
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ratingStackView, artistNameLabel, genreLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .equalCentering
        return stackView
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        configure()
    }
     
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(appNameLabel)
        contentView.addSubview(appIconImageView)
        contentView.addSubview(downloadButton)
        contentView.addSubview(infoStackView)
        
        appIconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }

    }
    
    func bindViewModel(_ viewModel: SearchTableViewCellViewModel) {
        downloadButton.rx.tap
            .map { viewModel.appName }
            .bind(to: viewModel.downloadButtonTap)
            .disposed(by: disposeBag)
        
        appNameLabel.text = viewModel.appName
        ratingView.rating = viewModel.rating
        ratingCountLabel.text = "1만"
        artistNameLabel.text = viewModel.artistName
        genreLabel.text = viewModel.genre
    }
}
