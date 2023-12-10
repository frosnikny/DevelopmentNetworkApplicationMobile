//
//  APIManager.swift
//  UltraDevelopmentServices
//
//  Created by Никита Рассказов on 05.12.2023.
//

import Foundation

var host: String = "127.0.0.1"
var hostServer: String = "http://\(host):8080/"

final class APIManager {

    private init() {}

    static let shared = APIManager()

    func getDevs(completion: @escaping (Result<[DevelopmentModel], APIError>) -> Void) {
        let urlString = hostServer + "api/devs"
        guard let url = URL(string: urlString) else {
            completion(.failure(.incorrectlyURL))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(.error(error)))
                }
                return
            }
            /// Приводим `response` к типу HTTPURLResponse
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.responseIsNil))
                }
                return
            }
            /// Провекра кода ответа
            guard (200..<300).contains(response.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.badStatusCode(response.statusCode)))
                }
                return
            }
            /// Распаковка дата
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.dataIsNil))
                }
                return
            }
            do {
                let collections = try JSONDecoder().decode(GetAllDevelopmentServicesResponse.self, from: data)
                /// Т.к в коллекциях у нас лежит массив, то мы перебираем массив и маппим их
                DispatchQueue.main.async {
                    completion(.success(collections.development_services.map { $0.mapper }))
                }
                return

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.error(error)))
                }
            }
        }.resume()
    }
    
    func getSearch(searchStr: String, completion: @escaping (Result<[DevelopmentModel], APIError>) -> Void) {
        let urlString = hostServer + "api/devs?name=\(searchStr)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.incorrectlyURL))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(.error(error)))
                }
                return
            }
            /// Приводим `response` к типу HTTPURLResponse
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.responseIsNil))
                }
                return
            }
            /// Провекра кода ответа
            guard (200..<300).contains(response.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.badStatusCode(response.statusCode)))
                }
                return
            }
            /// Распаковка дата
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.dataIsNil))
                }
                return
            }
            do {
                let collections = try JSONDecoder().decode(GetAllDevelopmentServicesResponse.self, from: data)
                /// Т.к в коллекциях у нас лежит массив, то мы перебираем массив и маппим их
                DispatchQueue.main.async {
                    completion(.success(collections.development_services.map { $0.mapper }))
                }
                return

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.error(error)))
                }
            }
        }.resume()
    }
    
    func getDetails(devDataId: String, completion: @escaping (Result<DevelopmentModel, APIError>) -> Void) {
        let urlString = hostServer + "api/devs/\(devDataId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.incorrectlyURL))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(.error(error)))
                }
                return
            }
            /// Приводим `response` к типу HTTPURLResponse
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.responseIsNil))
                }
                return
            }
            /// Провекра кода ответа
            guard (200..<300).contains(response.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.badStatusCode(response.statusCode)))
                }
                return
            }
            /// Распаковка дата
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.dataIsNil))
                }
                return
            }
            do {
                let developmentService = try JSONDecoder().decode(DevelopmentService.self, from: data)
                /// Т.к в коллекциях у нас лежит массив, то мы перебираем массив и маппим их
                DispatchQueue.main.async {
                    completion(.success(developmentService.mapper))
                }
                return

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.error(error)))
                }
            }
        }.resume()
    }
}

