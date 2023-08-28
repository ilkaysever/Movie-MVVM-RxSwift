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
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Variables
    let viewModel = MovieViewModel()
    let disposeBag = DisposeBag()
    var moviList = [MovieItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
        configureTableView()
    }
    
    private func configureUI() {
        view.addSubviews(tableView, indicator)
        navigationTitle(title: "Movie List")
        createIndicator()
    }
    
    private func setupBindings() {
        fetchPopularMovies()
    }
    
    private func fetchPopularMovies() {
        viewModel.loading.bind(to: self.indicator.rx.isAnimating).disposed(by: disposeBag)
        viewModel.movieList.observe(on: MainScheduler.asyncInstance).subscribe { data in
            self.moviList = data
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        viewModel.error.observe(on: MainScheduler.asyncInstance).subscribe { errorMessage in
            print(errorMessage)
        }.disposed(by: disposeBag)
        viewModel.fetchPopularMovies()
    }
    
    // MARK: - TableView Configure
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = AppColors.backgroundColor
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
        return moviList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else { return UITableViewCell() }
        cell.fillMovieCell(with: moviList[indexPath.row])
        cell.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = moviList[indexPath.row].id else { return }
                let vc = MovieDetailViewController()
        vc.id = id
                //let detailData = viewModel.getProductList()[indexPath.row]
                //vc.detailData = detailData
                navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}

// MARK: - UI Components Constraints Extension
extension HomeViewController {
    
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
