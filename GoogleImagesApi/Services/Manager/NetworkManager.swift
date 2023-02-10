//
//  NetworkManager.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()

    func fetchData(
        request: String,
        onCompletion: @escaping ((Result<[Photo], Error>) -> Void)
    ) {
        guard let url = createURLcomponents(request: request) else { return }

        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let result = try self.searchPhotoParseJSON(withData: data ?? Data()) {
                        onCompletion(.success(result))
                    }
                } catch {
                    onCompletion(.failure(error))
                }
            case .failure(let error):
                print(error)
                onCompletion(.failure(error))
            }
        }
    }

    func downloadImage(url: String, completion: @escaping ((UIImage) -> Void)) {
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func createURLcomponents(request: String) -> URL? {
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "serpapi.com"
        urlComponents.path = "/search.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "q", value: request),
            URLQueryItem(name: "tbm", value: "isch")
        ]
        return urlComponents.url
    }

    private func searchPhotoParseJSON(withData data: Data) throws -> [Photo]? {
        let decoder = JSONDecoder()
        let photoData = try decoder.decode(PhotoData.self, from: data)
        var photos: [Photo] = []
        guard let searchData = photoData.imagesResults else { return nil }
        for datum in searchData {
            guard let photo = Photo(photoData: datum) else { return nil }
            photos.append(photo)
        }
        return photos
    }
}
