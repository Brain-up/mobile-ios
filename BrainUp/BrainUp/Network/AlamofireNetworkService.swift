//
//  AlamofireNetworkService.swift
//  BrainUp
//
//  Created by Evgenii Zhigunov on 2/18/22.
//

import Foundation
import Alamofire

class AlamofireNetworkService: NetworkService {
    func fetch<T>(_ request: Request, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        AF.request(request.baseURL+request.path, method: request.method.getAFHTTPMethod(),
                   parameters: request.parameters,
                   encoding: request.encoding.getAFEncoding(),
                   headers: getAFHeaders(from: request.headers))
            .response {response in
                switch response.result {
                case .success(let data):
                    do {
//                        let result1 = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
//                        print(result1)
                        let result = try JSONDecoder().decode(T.self, from: data ?? Data())
                        completion(Result.success(result))
                    } catch let error {
                        completion(Result.failure(error as Error))
                    }
                case .failure(let error):
                    completion(Result.failure(error as Error))
                }
            }
            
    }

    private func getAFHeaders(from headers: [String: String]) -> Alamofire.HTTPHeaders {
        var afHeaders = Alamofire.HTTPHeaders()
        let token = Token.shared.getToken() ?? ""
        for (key, value) in headers {
            afHeaders.add(name: key, value: value)
        }
        afHeaders.add(.authorization(bearerToken: token))
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
