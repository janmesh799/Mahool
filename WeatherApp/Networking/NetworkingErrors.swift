//
//  NetworkingErrors.swift
//  WeatherApp
//
//  Created by Harsh Yadav on 06/10/22.
//

import Foundation
enum NetworkingError:Error{
    case badURL
    case badResponse
    case decodingFailed
    case unknownError
    
    case invalidInput
    
    case encodingFailed
}
