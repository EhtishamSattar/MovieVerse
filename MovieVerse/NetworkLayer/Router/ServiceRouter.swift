import Foundation
import Alamofire

enum ServiceRouter: RouterProtocol {
    
    case getUpcomingMovies(Int)
    case getMovies(Int)
    case searchMovies(String)
    
    var baseURL: String {
        switch self {
        case .getMovies:
            return Constants.baseApiUrl
        case .getUpcomingMovies:
            return Constants.upComingMoviesUrl
        case .searchMovies:
            return Constants.baseSearchApiUrl
        }
    }
    
    var path: String {
        switch self {
        case .getUpcomingMovies(let page):
            return ""//"&page=\(page)"
        case .getMovies(let page):
            return "&page=\(page)"
        case .searchMovies(let query):
            return "&query=\(query)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUpcomingMovies, .getMovies, .searchMovies:
            return .get  
        }
    }
    
    var headers: HTTPHeaders? {
        var headers: HTTPHeaders = HTTPHeaders()
        switch self {
        case .getUpcomingMovies, .getMovies, .searchMovies:
            headers.add(HTTPHeader(name: "Content-Type", value: "application/json"))
        }
        return headers
    }
    
    var parameters: [String : String]? {
        switch self {
        case .getUpcomingMovies(let page):
            return [
                "page": "\(page)",
                "api_key" : "2869a4ca70a9ba43c2c594b9310f0c75"
            ]
        case .getMovies(let page):
            return [
                "page": "\(page)"
            ]
        case .searchMovies(let query):
            return [
                "query": query
            ]
        }
        
    }
    
}
