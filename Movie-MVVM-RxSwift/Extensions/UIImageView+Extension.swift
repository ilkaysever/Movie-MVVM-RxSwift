//
//  UIImageView+Extension.swift
//  Movie-MVVM-RxSwift
//
//  Created by İlkay Sever on 27.08.2023.
//

import Kingfisher

extension UIImageView {
    
    func setImage(with urLString: String) {
        guard let url = URL.init(string: urLString) else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: urLString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
    
}
