//
//  NetworkingProtocols.swift
//  WeatherApp
//
//  Created by Harsh Yadav on 06/10/22.
//

import Foundation

protocol NetworkingHelper{
    func makeRequest(url urlString:String)throws ->URLRequest
    func decodeData<T:Decodable>(data:Data,type:T.Type)throws->T
    func getPostString(params:[String:Any]) -> String
}

///GET Request
protocol NetworkingGET{
    func postJSON<E:Encodable, D:Decodable>(url urlString:String,requestData:E,responseType:D.Type)async throws->D
}

///POST Request
protocol NetworkingPOST{
    func postJSONFormData<D:Decodable>(url urlString:String,requestData:[String:Any],responseType:D.Type)async throws->D
    func getJSON<T:Decodable>(url urlString:String,type:T.Type)async throws -> T
}


///GET & POST Request
protocol Networking:NetworkingGET,NetworkingPOST{
    
}
