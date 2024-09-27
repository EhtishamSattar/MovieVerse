//
//  RouterProtocol.swift
//  MovieVerse
//
//  Created by Mac on 20/09/2024.
//

import Foundation
import Alamofire

protocol RouterProtocol : URLRequestConvertible {
    var path: String { get }
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: [String: String]? { get }
}


extension RouterProtocol {
    func asURLRequest() throws -> URLRequest {
     //   let url = try baseURL.asURL().appendingPathComponent(path).asURL()
        
        var url = baseURL + path
        url = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? url
        
        print("@@@@@@@@",url)
       // var request = URLRequest(url: url)
        var request = URLRequest(url: try url.asURL())
        request.method = method
        request.headers = headers ?? HTTPHeaders()
        if let parameters = parameters {
            request = try URLEncoding.default.encode(request, with: parameters)
        }
        return request
    }
}
