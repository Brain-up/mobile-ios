//
//  AlamofireNetworkService.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/18/22.
//

import Foundation
import Alamofire

class AlamofireNetworkService: NetworkService {
    func fetch<T>(_ request: Request, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable, T: Encodable {
        AF.request(request.baseURL+request.path, method: request.method.getAFHTTPMethod(),
                   parameters: request.queryItems,
                   encoding: request.encoding.getAFEncoding(),
                   headers: getAFHeaders(from: request.headers))
            .response {response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data ?? Data())
                        completion(Result.success(result))
                    } catch (let error) {
                        completion(Result.failure(error as Error))
                    }
                case .failure(let error):
                    completion(Result.failure(error as Error))
                }
            }
            
    }
    
    private func getAFHeaders(from headers: [String: String]) -> Alamofire.HTTPHeaders {
        var afHeaders = Alamofire.HTTPHeaders()
        for (key, value) in headers {
            afHeaders.add(name: key, value: value)
        }
        return afHeaders
    }
}

extension HTTPMethod {
    func getAFHTTPMethod() -> Alamofire.HTTPMethod {
        return Alamofire.HTTPMethod(rawValue: self.rawValue)
    }
}

extension Encoding {
    func getAFEncoding() -> ParameterEncoding {
        switch self {
        case .URLEncoding:
            return Alamofire.URLEncoding.default
        case .JSONEncoding:
            return Alamofire.JSONEncoding.default
        }
    }
}
