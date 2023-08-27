//
//  MovieCell.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 27.08.2023.
//

import UIKit

final class MovieCell: UITableViewCell, ReusableView, NibLoadableView {
    
    // MARK: - UI Components
    private let containerView: UIView = UIView()
    private let movieImgView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let releaseLabel: UILabel = UILabel()
    private let rateImgView: UIImageView = UIImageView()
    private let rateLabel: UILabel = UILabel()
    
    // MARK: - Variables
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawCell()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Configure UI Elements
    private func configureUI() {
        contentView.addSubview(containerView)
        containerView.addSubviews(movieImgView, titleLabel, releaseLabel, rateImgView, rateLabel)
        
        containerView.addBorderView(width: 0.5, color: AppColors.borderColor)
        containerView.addCornerRadius(radius: 8)
        movieImgView.addCornerRadius(radius: 4)
    }
    
    private func drawCell() {
        DispatchQueue.main.async {
            self.contentView.backgroundColor = AppColors.backgroundColor
            self.createCellConstraints()
        }
    }
    
}

// MARK: - UI Components Constraints Extension
extension MovieCell {
    
    private func createCellConstraints() {
        // Cell Container View
        containerView.backgroundColor = AppColors.white
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        // Movie Poster Image
        movieImgView.image = UIImage(named: "splash")
        movieImgView.contentMode = .scaleAspectFill
        movieImgView.backgroundColor = .clear
        movieImgView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(8)
            make.bottom.equalTo(containerView.snp.bottom).offset(-8)
            make.left.equalTo(containerView.snp.left).offset(8)
            make.width.equalTo(90)
        }
        
        // Movie Title
        titleLabel.text = "The Shawshank Redepmption"
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        titleLabel.textColor = AppColors.navigationTitle
        titleLabel.font = AppFonts.UbuntuBold18
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(32)
            make.left.equalTo(movieImgView.snp.right).offset(8)
            make.right.equalTo(containerView.snp.right).offset(-8)
        }
        
        // Release Label
        releaseLabel.text = "1993"
        releaseLabel.textAlignment = .left
        releaseLabel.textColor = .lightGray
        releaseLabel.font = AppFonts.UbuntuMedium14
        releaseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(movieImgView.snp.right).offset(8)
            make.right.equalTo(containerView.snp.right).offset(-8)
        }
        
        // Rate Star Image
        rateImgView.image = UIImage(systemName: "star.fill")
        rateImgView.tintColor = .red
        rateImgView.contentMode = .scaleAspectFit
        rateImgView.backgroundColor = .clear
        rateImgView.snp.makeConstraints { (make) in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalTo(rateLabel.snp.centerY)
        }
        
        // Rate Label
        rateLabel.text = "6.5 / 10"
        rateLabel.textAlignment = .left
        rateLabel.textColor = .red
        rateLabel.font = AppFonts.UbuntuMedium12
        rateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(rateImgView.snp.right).offset(4)
            make.bottom.equalTo(containerView.snp.bottom).offset(-8)
            make.right.equalTo(containerView.snp.right).offset(-8)
        }
        
    }
    
}
