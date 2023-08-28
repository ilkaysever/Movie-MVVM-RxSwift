//
//  ViewController.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 28.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class MovieDetailViewController: BaseViewController {
    
    // MARK: - UI Components
    private let containerView: UIView = UIView()
    private let moviePoster: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let descLabel: UILabel = UILabel()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Variables
    var id: Int = 0
    let viewModel = MovieDetailViewModel()
    let disposeBag = DisposeBag()
    var movieItem = MovieItem() {
        didSet {
            navigationTitle(title: movieItem.originalTitle)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings(id: self.id)
    }
    
    // MARK: - Configure UI Elements
    private func configureUI() {
        view.addSubview(containerView)
        containerView.addSubviews(moviePoster, titleLabel, descLabel, indicator)
        drawDesign()
    }
    
    private func drawDesign() {
        mainView()
        productInfo()
        createIndicator()
    }
    
    private func fillDetailScreen() {
        let imgUrl = Constants.imgBaseURL + (movieItem.backdropPath ?? "")
        titleLabel.text = movieItem.originalTitle
        descLabel.text = movieItem.overview
        moviePoster.setImage(with: imgUrl)
    }
    
    private func setupBindings(id: Int) {
        fetchMovieDetail(id: id)
    }
    
    private func fetchMovieDetail(id: Int) {
        viewModel.loading.bind(to: self.indicator.rx.isAnimating).disposed(by: disposeBag)
        viewModel.movieItem.observe(on: MainScheduler.asyncInstance).subscribe { data in
            self.movieItem = data
            self.fillDetailScreen()
        }.disposed(by: disposeBag)
        viewModel.error.observe(on: MainScheduler.asyncInstance).subscribe { errorMessage in
            print(errorMessage)
        }.disposed(by: disposeBag)
        viewModel.fetchMovieDetail(id: id)
    }
    
}

// MARK: - UI Components Constraints Extension
extension MovieDetailViewController {
    
    private func mainView() {
        // ContainerView
        containerView.backgroundColor = AppColors.backgroundColor
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        // Product Image
        moviePoster.contentMode = .scaleAspectFit
        moviePoster.backgroundColor = .clear
        moviePoster.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top)
            make.left.equalTo(containerView.snp.left)
            make.right.equalTo(containerView.snp.right)
            make.height.equalTo(view.frame.height / 3.8)
        }
        
    }
    
    private func productInfo() {
        
        // Movie Title
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.textColor = AppColors.backgroundColorDark
        titleLabel.font = AppFonts.UbuntuMedium20
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(moviePoster.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        // Desc Label
        descLabel.textAlignment = .left
        descLabel.numberOfLines = 0
        descLabel.textColor = AppColors.backgroundColorDark
        descLabel.font = AppFonts.UbuntuMedium14
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.lessThanOrEqualTo(containerView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
    }
    
    private func createIndicator() {
        indicator.backgroundColor = AppColors.backgroundColorDark
        indicator.color = AppColors.white
        indicator.alpha = 0.8
        indicator.hidesWhenStopped = true
        indicator.addCornerRadius(radius: 8)
        indicator.snp.makeConstraints { make in
            make.centerY.equalTo(containerView.snp.centerY)
            make.centerX.equalTo(containerView.snp.centerX)
            make.height.width.equalTo(70)
        }
    }
    
}
