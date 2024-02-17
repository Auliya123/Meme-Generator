//
//  NetworkManager.swift
//  Meme-Generator
//
//  Created by Auliya Michelle Adhana on 16/02/24.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.imgflip.com/"
    let cache = NSCache<NSString, UIImage>()

    private init(){}

    func getMemes(completed: @escaping(Result<[Meme], ErrorMessage>) -> Void){
        let endpoint = baseUrl + "get_memes"

        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            // check if there's response then check the response status code
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase


                let memes = try decoder.decode(MemeData.self, from: data)

                completed(.success(memes.data.memes))
            } catch{
                completed(.failure(.invalidData ))
            }
        }
        task.resume()
    }

}
