//
//  ErrorMessage.swift
//  Meme-Generator
//
//  Created by Auliya Michelle Adhana on 16/02/24.
//

import UIKit

enum ErrorMessage: String, Error {
    case invalidURL = "The current URL is wrong"
    case unableToComplete = "Unable to complete your request"
    case invalidResponse = "Invalid response from the server"
    case invalidData = "The data from the server was invalid. please try again"
}
