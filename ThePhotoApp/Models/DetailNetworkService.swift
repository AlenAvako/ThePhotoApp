//
//  DetailNetworkService.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 24.06.2022.
//

import Foundation

class DetailNetworkService {
    static let shared = DetailNetworkService()
    
    func request(id: String, completion: @escaping (Photo) -> Void) {
        guard let url = prepareURL(id: id) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeaders()
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, responce, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responce = try decoder.decode(Photo.self, from: data)
                let photo = responce
                
                DispatchQueue.main.async {
                    completion(photo)
                }
            } catch let error {
                print("Сервер не отвечает: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func prepareHeaders() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID svkERLzac1MvcJlfTfRul_9xOMdBi-OcvY8qw8IwYfw"
        return headers
    }
    
    private func prepareURL(id: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = "/photos/\(id)"
        return urlComponents.url
    }
}
