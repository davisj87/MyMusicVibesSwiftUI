//
//  ImageLoader.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import UIKit

class ImageLoader {
    private var loadedImages = NSCache<NSString, UIImage>()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ urlString: String, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        guard let url = URL(string: urlString) else { return nil }
        if let image = loadedImages.object(forKey: urlString as NSString){//loadedImages[url] {
            completion(.success(image))
            return nil
        }
        let uuid = UUID()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer {self.runningRequests.removeValue(forKey: uuid) }
          
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages.setObject(image, forKey: urlString as NSString)
                    //self.loadedImages[url] = image
                completion(.success(image))
                return
            }

            guard let error = error else { return }

            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        // the request was cancelled, no need to call the callback
        }
        task.resume()

        runningRequests[uuid] = task
        return uuid
    }

    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
    
}



