//
//  CustomButton.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 28.08.2023.
//

import UIKit

protocol CustomButtonDelegate: AnyObject {
    func didTappedButton()
}

final class CustomButton: UIButton {
    
    private let buttonLabel: UILabel = {
        let buttonLabel = UILabel()
        buttonLabel.numberOfLines = 1
        buttonLabel.textAlignment = .center
        buttonLabel.textColor = AppColors.white
        buttonLabel.font = AppFonts.UbuntuBold16
        return buttonLabel
    }()
    
    private let buttonIcon: UIImageView = {
        let buttonIcon = UIImageView()
        buttonIcon.tintColor = AppColors.white
        buttonIcon.contentMode = .scaleAspectFill
        buttonIcon.clipsToBounds = true
        return buttonIcon
    }()
    
    weak var delegate: CustomButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(buttonIcon, buttonLabel)
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = AppColors.borderColor.cgColor
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureButton(with viewModel: IconTextButtonViewModel) {
        buttonIcon.image = viewModel.image
        buttonLabel.text = viewModel.text
        backgroundColor = viewModel.backgroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonLabel.sizeToFit()
        let iconSize: CGFloat = 10
        let iconRightPadding: CGFloat = 8
        let iconX: CGFloat = (frame.size.width - buttonLabel.frame.size.width - iconSize - iconRightPadding) / 2
        buttonIcon.frame = CGRect(x: iconX, y: (frame.size.height - iconSize) / 2, width: iconSize, height: iconSize)
        buttonLabel.frame = CGRect(x: iconX + iconSize + iconRightPadding, y: 0, width: buttonLabel.frame.size.width, height: frame.size.height)
    }
    
}
