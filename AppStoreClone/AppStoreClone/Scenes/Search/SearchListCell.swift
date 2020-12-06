//
//  SearchListCell.swift
//  AppStoreClone
//
//  Created by kwanghyun.won` on 2020/01/05.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Nuke
import UIKit

class SearchListCell: UICollectionViewCell, Reusable {
    var appResult: SearchResult! {
        didSet {
            nameLabel.text = appResult.trackName
            categoryLabel.text = appResult.primaryGenreName
            ratingLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"

            if let url = URL(string: appResult.artworkUrl100) {
                Nuke.loadImage(with: url, into: appIconImageView)
            }

            if let url1 = URL(string: appResult.screenshotUrls[0]) {
                Nuke.loadImage(with: url1, into: screenshotImageView1)
            }

            if appResult.screenshotUrls.count > 1 {
                if let url1 = URL(string: appResult.screenshotUrls[1]) {
                    Nuke.loadImage(with: url1, into: screenshotImageView2)
                }
            }

            if appResult.screenshotUrls.count > 2 {
                if let url1 = URL(string: appResult.screenshotUrls[2]) {
                    Nuke.loadImage(with: url1, into: screenshotImageView3)
                }
            }
        }
    }

    let appIconImageView: UIImageView = {
        let view = UIImageView()
        view.withSize(64)
        view.setCorner(12)
        return view
    }()

    let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "AppName"
        return view
    }()

    let categoryLabel: UILabel = {
        let view = UILabel()
        view.text = "Category"
        return view
    }()

    let ratingLabel: UILabel = {
        let view = UILabel()
        view.text = "8.9"
        return view
    }()

    lazy var screenshotImageView1 = self.createScreenshotImageView()
    lazy var screenshotImageView2 = self.createScreenshotImageView()
    lazy var screenshotImageView3 = self.createScreenshotImageView()

    func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }

    let getButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.setCorner(16)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        let screenShotStack = HStackView(spacing: 5) {
            screenshotImageView1
            screenshotImageView2
            screenshotImageView3
        }.distribution(justify: .fillEqually)

        VStackView(spacing: 10) {
            HStackView(alignment: .center, spacing: 12.0) {
                appIconImageView
                VStackView {
                    nameLabel
                    categoryLabel
                    ratingLabel
                }
                Spacer()
                getButton.withWidth(70)
            }
            screenShotStack
        }.withMargins(.allSides(16))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
