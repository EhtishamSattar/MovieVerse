//
//  NetworkErrorHandling.swift
//  MovieVerse
//
//  Created by Mac on 09/09/2024.
//

import Foundation

enum NetworkError: Error { // we are using Error so that it conform to Error Protocol and hence we can use that as error
    case badServerResponse
    case badUrl
    case badDataResonse
    
}
