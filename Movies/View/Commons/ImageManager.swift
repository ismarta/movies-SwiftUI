//
//  ImageManager.swift
//  Movies
//
//  Created by Marta on 8/3/24.
//

import Foundation
import Combine
import UIKit

class ImageManager {
    static let shared = ImageManager()
    private var imageCache: [String: UIImage] = [:]
    
    private init() {}

    func loadImage(from urlString: String) -> AnyPublisher<UIImage?, Error> {
        if let cachedImage = imageCache[urlString] {
            return Just(cachedImage)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            return Fail(error: error).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let image = UIImage(data: data) else {
                    throw NSError(domain: "Invalid Image Data", code: 0, userInfo: nil)
                }
                return image
            }
            .handleEvents(receiveOutput: { [weak self] image in
                self?.imageCache[urlString] = image
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
