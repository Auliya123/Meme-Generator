//
//  Meme.swift
//  Meme-Generator
//
//  Created by Auliya Michelle Adhana on 16/02/24.
//

import UIKit

struct Meme: Codable, Hashable {
    var id: String
    var name: String
    var url: String
    var width: Int
    var height: Int
}
