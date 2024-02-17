//
//  MemeView.swift
//  Meme-Generator
//
//  Created by Auliya Michelle Adhana on 16/02/24.
//

import UIKit

class MemeView: UIView {
    
    let memeImage = MMImageView(frame: .zero)
    let additionalText = UILabel()
    let additionalImage = UIImageView()

    private var isDraggingText = false
    private var isDraggingImage = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureImage()
        configureAdditionalText()
        configureAdditionalImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(additionalText: String){
        self.additionalText.text = additionalText
    }

    func setImageUrl(imageUrl: String){
        memeImage.downloadImage(from: imageUrl)
    }


    func configureImage(){
        addSubview(memeImage)
        
        NSLayoutConstraint.activate([
            memeImage.topAnchor.constraint(equalTo: self.topAnchor),
            memeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            memeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            memeImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    
    func configure(){
        self.backgroundColor = .systemBackground
    }
    
    func configureAdditionalText(){
        addSubview(additionalText)
        
        additionalText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            additionalText.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            additionalText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            additionalText.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    func configureAdditionalImage(){
        additionalImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(additionalImage)

        NSLayoutConstraint.activate([
            additionalImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            additionalImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            additionalImage.heightAnchor.constraint(equalToConstant: 100),
            additionalImage.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}

extension MemeView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first  else { return }
        
        let locationText =  touch.location(in: additionalText)

        if additionalText.bounds.contains(locationText) {
            isDraggingText = true
        }

        let locationImage =  touch.location(in: additionalImage)

        if additionalImage.bounds.contains(locationImage) {
            isDraggingImage = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first  else { return }

        let location = touch.location(in: self)

        let topBounds = memeImage.frame.minY + 12
        var bottomBounds = memeImage.frame.maxY
        let leadingBounds = memeImage.frame.minX + 8
        var trailingBounds = memeImage.frame.maxX

        if isDraggingText {

            bottomBounds -= 12
            trailingBounds -= 8

            if (additionalText.frame.origin.y < topBounds) {
                isDraggingText = false
                additionalText.frame.origin.y = topBounds
                return
            }

            if (additionalText.frame.origin.y > bottomBounds) {
                isDraggingText = false
                additionalText.frame.origin.y = bottomBounds
                return
            }

            if (additionalText.frame.origin.x < leadingBounds) {
                isDraggingText = false
                additionalText.frame.origin.x = leadingBounds
                return
            }

            if (additionalText.frame.origin.x > trailingBounds) {
                isDraggingText = false
                additionalText.frame.origin.x = trailingBounds
                return
            }

            additionalText.frame.origin.x =  location.x - (additionalText.frame.size.width / 2)
            additionalText.frame.origin.y =  location.y - (additionalText.frame.size.height / 2)
        } else if isDraggingImage{

            bottomBounds -= 100
            trailingBounds -= 100

            if (additionalImage.frame.origin.y < topBounds) {
                isDraggingImage = false
                additionalImage.frame.origin.y = topBounds
                return
            }

            if (additionalImage.frame.origin.y > bottomBounds) {
                isDraggingImage = false
                additionalImage.frame.origin.y = bottomBounds
                return
            }

            if (additionalImage.frame.origin.x < leadingBounds) {
                isDraggingImage = false
                additionalImage.frame.origin.x = leadingBounds
                return
            }

            if (additionalImage.frame.origin.x > trailingBounds) {
                isDraggingImage = false
                additionalImage.frame.origin.x = trailingBounds
                return
            }

            additionalImage.frame.origin.x =  location.x - (additionalImage.frame.size.width / 2)
            additionalImage.frame.origin.y =  location.y - (additionalImage.frame.size.height / 2)
        } else {
            return
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDraggingText = false
        isDraggingImage = false
    }
    
    
}



