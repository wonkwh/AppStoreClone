//
// Created by kwanghyun.won
// Copyright © 2020 wonkwh. All rights reserved.
//

import UIKit

class PreviewCell: UICollectionViewCell, Reusable {
    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
    let horizontalController = PreviewScreenshotsController()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let view = horizontalController.view!
        VStackView(spacing: 10) {
            previewLabel.withHeight(24)
            view
        }.padLeft(20)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
