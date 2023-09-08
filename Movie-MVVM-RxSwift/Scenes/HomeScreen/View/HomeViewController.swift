//
//  ViewController.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 27.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    
    // MARK: - UI Components
    private let tableView: UITableView = UITableView()
    private let buttonView = CustomButton()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Variables
    let viewModel = MovieViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings(pageCount: viewModel.initialPageCount)
        configureTableView()
    }
    
    private func configureUI() {
        view.addSubviews(tableView, buttonView, indicator)
        navigationTitle(title: "Movie List")
        createIndicator()
        createButton()
        buttonView.addTarget(self, action: #selector(didTappedLoad), for: .touchUpInside)
        buttonView.configureButton(with: IconTextButtonViewModel(image: UIImage(systemName: "plus"), text: "Custom Button", backgroundColor: AppColors.borderColor))
    }
    
    private func setupBindings(pageCount: Int) {
        fetchPopularMovies(pageCount: pageCount)
    }
    
    private func fetchPopularMovies(pageCount: Int) {
        viewModel.loading.bind(to: self.indicator.rx.isAnimating).disposed(by: disposeBag)
        viewModel.movieResponse.observe(on: MainScheduler.asyncInstance).subscribe { data in
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        viewModel.error.observe(on: MainScheduler.asyncInstance).subscribe { errorMessage in
            print(errorMessage)
        }.disposed(by: disposeBag)
        viewModel.fetchPopularMovies(pageCount: pageCount)
    }
    
    @objc func didTappedLoad() {
        print("basıldı...")
    }
    
    // MARK: - TableView Configure
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = AppColors.backgroundColor
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        self.tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
}

// MARK: - TableView Extensions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else { return UITableViewCell() }
        cell.fillMovieCell(with: viewModel.movies[indexPath.row])
        cell.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel.movies[indexPath.row].id else { return }
        let vc = MovieDetailViewController()
        vc.id = id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movies.count - 1 && viewModel.initialPageCount <= viewModel.totalPageCount {
            viewModel.initialPageCount += 1
            setupBindings(pageCount: viewModel.initialPageCount)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}

// MARK: - UI Components Constraints Extension
extension HomeViewController {
    
    private func createButton() {
        buttonView.addCornerRadius(radius: 8)
        buttonView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
    }
    
    private func createIndicator() {
        indicator.backgroundColor = AppColors.backgroundColorDark
        indicator.color = AppColors.white
        indicator.alpha = 0.8
        indicator.hidesWhenStopped = true
        indicator.addCornerRadius(radius: 8)
        indicator.snp.makeConstraints { make in
            make.centerY.equalTo(tableView.snp.centerY)
            make.centerX.equalTo(tableView.snp.centerX)
            make.height.width.equalTo(70)
        }
    }
    
}
