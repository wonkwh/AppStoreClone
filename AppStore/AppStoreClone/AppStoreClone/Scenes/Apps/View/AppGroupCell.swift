//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit
import Swifty

class AppGroupCell: UICollectionViewCell, Reusable {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App Section Title"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()

    let appsHorizontalController = AppsHorizontalController()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        let view = appsHorizontalController.view!
        VStackView(spacing: 10) {
            HStackView {
                Spacer().withWidth(16.0)
                titleLabel
            }
            view
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
