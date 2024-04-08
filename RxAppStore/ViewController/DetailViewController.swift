//
//  DetailViewController.swift
//  RxAppStore
//
//  Created by 이재희 on 4/6/24.
//

import UIKit

final class DetailViewController: BaseViewController<DetailViewModel> {
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let appIconImageView = RoundImageView(cornerRadius: 15)
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let artistNameLabel: UILabel = SubLabel()
    
    private let downloadButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        var titleAttr = AttributedString.init("받기")
        titleAttr.font = .systemFont(ofSize: 16, weight: .bold)
        configuration.attributedTitle = titleAttr
        return UIButton(configuration: configuration)
    }()
    
    private let newLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 소식"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let versionLabel = SubLabel()
    
    private let releaseNoteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let horizontalScrollView = UIScrollView()
    private let imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func bind() {
        
    }
    
    override func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [appIconImageView, appNameLabel, artistNameLabel, downloadButton, newLabel, versionLabel, releaseNoteLabel, horizontalScrollView, descriptionLabel]
            .forEach { contentView.addSubview($0) }
        
        horizontalScrollView.addSubview(imageStackView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.verticalEdges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
        }
        
        appIconImageView.snp.makeConstraints {
            $0.size.equalTo(90)
            $0.top.leading.equalToSuperview().offset(16)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(appIconImageView).offset(8)
        }
        
        downloadButton.snp.makeConstraints {
            $0.leading.equalTo(appNameLabel)
            $0.bottom.equalTo(appIconImageView)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        
        artistNameLabel.snp.makeConstraints {
            $0.leading.equalTo(appNameLabel)
            $0.bottom.equalTo(downloadButton.snp.top).offset(-4)
        }
        
        newLabel.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.bottom).offset(16)
            $0.leading.equalTo(appIconImageView)
        }
        
        versionLabel.snp.makeConstraints {
            $0.leading.equalTo(newLabel)
            $0.top.equalTo(newLabel.snp.bottom).offset(8)
        }
        
        releaseNoteLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(versionLabel.snp.bottom).offset(16)
        }
        
        horizontalScrollView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(releaseNoteLabel.snp.bottom).offset(16)
            $0.height.equalTo(300)
        }
        
        imageStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(horizontalScrollView)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(horizontalScrollView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    override func configureView() {
        horizontalScrollView.showsHorizontalScrollIndicator = false
        
        let data = viewModel.selectedModelData
        appIconImageView.kf.setImage(with: data.appIconUrl)
        appNameLabel.text = data.trackName
        artistNameLabel.text = data.artistName
        versionLabel.text = data.version
        releaseNoteLabel.text = data.releaseNotes
        descriptionLabel.text = data.description
        
        for screenshotUrl in data.screenshotUrls {
            let imageView = RoundImageView(cornerRadius: 15)
            imageView.kf.setImage(with: URL(string: screenshotUrl))
            imageView.contentMode = .scaleAspectFill
            imageView.snp.makeConstraints { make in
                make.width.equalTo(160)
            }
            imageStackView.addArrangedSubview(imageView)
        }
    }
}
