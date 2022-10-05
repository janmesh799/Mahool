//
//  Networking.swift
//  WeatherApp
//
//  Created by Harsh Yadav on 15/01/22.
//

import Foundation

class NetworkingManager{
    
    func postJSON<E:Encodable, D:Decodable>(url urlString:String,requestData:E,responseType:D.Type)async throws->D{
        do{
            //Request
            var request = try makeRequest(url: urlString)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = try encodeData(requestData: requestData)
            
            //URL Session..
            let (data,response) = try await URLSession.shared.data(for: request)
            guard let res = response as? HTTPURLResponse, (200..<300).contains(res.statusCode) else{
                print(">>Bad Response")
                throw NetworkingError.badResponse
            }
            print(">>Response: \(res.statusCode)")
            
            //Decoding Data
            let decodedData = try decodeData(data: data, type: D.self)
            return decodedData
        }
        catch(let error){
            throw error
        }
    }
    
    
    func postJSONFormData<D:Decodable>(url urlString:String,requestData:[String:Any],responseType:D.Type,token:String = "")async throws->D{
        do{
            //Request
            var request = try makeRequest(url: urlString)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            if !token.isEmpty{
                request.setValue( "\(token)", forHTTPHeaderField: "Token")
            }
            

            let postString = getPostString(params: requestData)
            request.httpBody = postString.data(using: .utf8)
            
            //URL Session..
            let (data,response) = try await URLSession.shared.data(for: request)
            guard let res = response as? HTTPURLResponse, (200..<300).contains(res.statusCode) else{
                print(">>Bad Response")
                throw NetworkingError.badResponse
            }
            print(">>Response: \(res.statusCode)")
            
            //Decoding Data
            let decodedData = try decodeData(data: data, type: D.self)
            return decodedData
        }
        catch(let error){
            throw error
        }
    }
    
    func getJSON<T:Decodable>(url urlString:String,type:T.Type)async throws -> T{
        
        do{
            let request = try makeRequest(url: urlString)
            
            let (data,response) = try await URLSession.shared.data(for: request)
            
            guard let res = response as? HTTPURLResponse, (200..<300).contains(res.statusCode) else{
                print(">>Bad Response")
                throw NetworkingError.badResponse
            }
            
            print(">>Response: \(res.statusCode)")
            
            let decodedData = try decodeData(data: data, type: T.self)
            return decodedData
        }
        
        catch(let error){
            print(">>Error Occured: \(error.localizedDescription)")
            throw error
        }
    }
}




extension NetworkingManager{
    
    ///Make Networking Request
    private func makeRequest(url urlString:String)throws ->URLRequest {
        guard let url = URL(string: urlString)
        else {
            print(">>Bad URL")
            throw NetworkingError.badURL
        }
        
        return URLRequest(url: url)
    }
    
    ///Encode Data
    private func encodeData<E:Encodable>(requestData:E)throws->Data{
        let encoder = JSONEncoder()
        do{
            let encodedData = try encoder.encode(requestData)
            return encodedData
        }
        catch{
            throw NetworkingError.encodingFailed
        }
    }
    
    ///Decode Data
    private func decodeData<T:Decodable>(data:Data,type:T.Type)throws->T{
        let decoder = JSONDecoder()
        do{
            
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        }
        catch{
            print(">>Decoding Failed")
            throw NetworkingError.decodingFailed
        }
    }
    

    private func getPostString(params:[String:Any]) -> String{
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
}



