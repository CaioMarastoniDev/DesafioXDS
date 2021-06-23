//
//  NetworkingService.swift
//  TesteXDS
//
//  Created by Caio Marastoni on 21/06/21.
//

import Foundation

enum MyResult<T, E: Error> {
    
    case success(T)
    case failure(E)
}

class NetworkingService {
    
    let baseUrl = "https://p3teufi0k9.execute-api.us-east-1.amazonaws.com/v1"
    
    //MARK: - Login
    func requestLogin(endpoint: String,
                      loginObject: Login,
                      completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        
        do {
            let loginData = try JSONEncoder().encode(loginObject)
            request.httpBody = loginData
            
        } catch {
            completion(.failure(NetworkingError.badEncoding))
        }
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        handleLoginResponse(for: request, completion: completion)
        
    }
    
    func handleLoginResponse(for request: URLRequest,
                             completion: @escaping (Result<User, Error>) -> Void) {
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                guard let unwrappedResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkingError.badResponse))
                    return
                }
                
                print(unwrappedResponse.statusCode)
                
                switch unwrappedResponse.statusCode {
                
                case 200 ..< 300:
                    print("success")
                    
                default:
                    print("failure")
                }
                
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                
                if let unwrappedData = data {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        print(json)
                        
                        if let user = try? JSONDecoder().decode(User.self, from: unwrappedData) {
                            completion(.success(user))
                            
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            completion(.failure(errorResponse))
                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }
    
    //MARK: - CARDS
    func requestCard(endpoint: String,
                     completion: @escaping (Result<[CardResponse], Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        handleCardResponse(for: request, completion: completion)
        
    }
    
    func handleCardResponse(for request: URLRequest,
                            completion: @escaping (Result<[CardResponse], Error>) -> Void) {
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                guard let unwrappedResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkingError.badResponse))
                    return
                }
                
                print(unwrappedResponse.statusCode)
                
                switch unwrappedResponse.statusCode {
                
                case 200 ..< 300:
                    print("success")
                    
                default:
                    print("failure")
                }
                
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                
                if let unwrappedData = data {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        print(json)
                        
                        if let card = try? JSONDecoder().decode([CardResponse].self, from: unwrappedData)  {
                            completion(.success(card))
                            
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            completion(.failure(errorResponse))
                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }

}

enum NetworkingError: Error {
    case badUrl
    case badResponse
    case badEncoding
}

