//
//  BaseViewController.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 27.08.2023.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.backButtonTitle = ""
        view.backgroundColor = AppColors.backgroundColor
        view.alpha = 1.0
    }
    
    func navigationTitle(title: String?) {
        guard let title = title else { return }
        navigationItem.title = title
    }
    
    func addRightButton(selector: Selector?, image: String? = nil)  {
        if image != nil {
            let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
            imageview.image = UIImage(named: "\(image ?? "")")
            imageview.contentMode = .center
            imageview.isUserInteractionEnabled = true
            
            let rightButton = UIBarButtonItem(customView: imageview)
            let tapGesture = UITapGestureRecognizer(target: self, action: selector)
            navigationItem.rightBarButtonItem = rightButton
            rightButton.customView?.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func didTappedDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
