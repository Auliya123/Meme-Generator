//
//  MemeData.swift
//  Meme-Generator
//
//  Created by Auliya Michelle Adhana on 16/02/24.
//

import UIKit

struct MemeData: Codable, Hashable {
    var success: Bool
    var data: Memes
}

struct Memes: Codable, Hashable {
    var memes: [Meme]
}
