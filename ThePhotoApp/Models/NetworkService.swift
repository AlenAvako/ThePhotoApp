//
//  NetworkService.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 23.06.2022.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    func request(searchterm: String, completion: @escaping ([PhotoCollection]) -> Void) {
        guard let url = prepareURL(searchTerm: searchterm) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeaders()
        print(request)
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, responce, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responce = try decoder.decode(SerchResult.self, from: data)
                let photos = responce.results
                
                DispatchQueue.main.async {
                    completion(photos)
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
    
    private func prepareURL(searchTerm: String) -> URL? {
        var urlComponents = URLComponents()
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(20)
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = "/search/photos"
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        return urlComponents.url
    }
}
