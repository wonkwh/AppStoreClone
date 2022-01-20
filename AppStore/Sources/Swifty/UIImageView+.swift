//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import Nuke
import UIKit

public extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }

    // setImage(with: URL(string: app?.artworkUrl100 ?? ""))
    func setImage(with urlString: String) {
        let imageUrlString = URL(string: urlString)!
        Nuke.loadImage(with: imageUrlString, into: self)
    }
}

public extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        setTitle(title, for: .normal)
    }
}
