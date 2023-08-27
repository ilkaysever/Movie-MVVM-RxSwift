//
//  SplachScreen.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 27.08.2023.
//

import UIKit

final class SplashScreen: UIViewController {
    
    // MARK: - UI Components
    private let splashImg: UIImageView = UIImageView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configure UI Elements
    private func configureUI() {
        view.addSubviews(splashImg, indicator)
        drawDesign()
    }
    
    private func drawDesign() {
        self.indicator.startAnimating()
        self.createSplashImg()
        self.createIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.indicator.stopAnimating()
            self.navigateToMainPage()
        })
        
    }
    
    private func navigateToMainPage() {
        AppDelegate.shared?.openHomePage()
    }
    
}

// MARK: - UI Components Constraints Extension
extension SplashScreen {
    
    private func createSplashImg() {
        splashImg.backgroundColor = AppColors.backgroundColor
        splashImg.image = UIImage(named: "splash")
        splashImg.contentMode = .scaleAspectFill
        splashImg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func createIndicator() {
        indicator.backgroundColor = AppColors.backgroundColorDark
        indicator.color = AppColors.white
        indicator.alpha = 0.8
        indicator.addCornerRadius(radius: 8)
        indicator.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.width.equalTo(56)
        }
    }
    
}
