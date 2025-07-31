//
//  UIImageView+URLLoad.swift
//  AdvanceApp
//
//  Created by 서광용 on 7/31/25.
//

import UIKit
import Kingfisher

extension UIImageView {
  func setImage(urlString: String?) {
    guard let urlString = urlString,
          let url = URL(string: urlString) else { // String -> URL
      self.image = UIImage(named: "Placeholder")
      return
    }
    self.kf.setImage(with: url)
  }
}
