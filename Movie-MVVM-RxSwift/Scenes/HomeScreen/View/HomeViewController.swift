//
//  ViewController.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 27.08.2023.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: - UI Components
    private let tableView: UITableView = UITableView()
    
    // MARK: - Variables
//    let viewModel = ProductViewModel()
//    var group = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        navigationTitle(title: "Movie List")
    }
    
    // MARK: - TableView Configure
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = AppColors.backgroundColor
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        DispatchQueue.main.async {
            self.tableView.snp.makeConstraints { make in
                make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
                make.left.right.equalTo(self.view.safeAreaLayoutGuide)
            }
        }
    }

}

// MARK: - TableView Extensions
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
        //return viewModel.getProductList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else { return UITableViewCell() }
        cell.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
//        let vc = ProductDetailViewController()
//        let detailData = viewModel.getProductList()[indexPath.row]
//        vc.detailData = detailData
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}
