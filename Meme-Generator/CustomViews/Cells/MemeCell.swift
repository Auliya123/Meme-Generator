//
//  MemeCell.swift
//  Meme-Generator
//
//  Created by Auliya Michelle Adhana on 16/02/24.
//

import UIKit

class MemeCell: UICollectionViewCell {
    static let reuseID = "MemeCell"


    let memeImageView = MMImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(meme: Meme ){
        memeImageView.downloadImage(from: meme.url)
    }

    private func configure(){

        addSubview(memeImageView)

        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            memeImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            memeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            memeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            memeImageView.heightAnchor.constraint(equalTo: memeImageView.widthAnchor),
        ])
    }
}
