//
//  Networking.swift
//  WeatherApp
//
//  Created by Harsh Yadav on 15/01/22.
//

import Foundation

enum networkingError:Error{
    case invalidInput
    case invalidURL
    case badResponse
    case error
    case nilData
    
    case notFound
}

enum user:String{
    case invalidURL = ""
    case badResponse = "d"
    case error = "dsf"
    case nilData = "kjasd"
}

struct Networking{

    func Networking<T:Decodable>(city:String,completion:@escaping (Result<T,networkingError>)->()){
        //base url
        if city == ""{
            completion(.failure(.invalidInput))
        }
        
        let path = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=40e22274d96b307af48ca2883d88a538"
        print("the url is: \(path)")
        //creating url
        let url = URL(string: path)
        
        //checking if url is correct
        guard let url = url else {
            print("Error:Invalid url")
            completion(.failure(.invalidURL))
            return
        }
        
        //request & session
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error:\(String(describing: error?.localizedDescription))")
                completion(.failure(.error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse{
                print ("httpResponse.statusCode: \(httpResponse.statusCode)")
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 404{
                completion(.failure(.notFound))
                print("not found city")
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                let decodedData = try? decoder.decode(T.self, from: data)
                
                if decodedData == nil{
                    completion(.failure(.nilData))
                }
                if let decodedData = decodedData{                   //or we can force unwrap it also
                    completion(.success(decodedData))
                }
//                do{
//                    let finalData = try decoder.decode(T.self, from: data)
//                    completion(.success(finalData))
//                }
//                catch{
//                    print("errror agin")
//                    completion(.failure(.nilData))
//                }
            }
        }.resume()
    }
}
