//
//  APIClient.swift
//  JustPump
//
//  Created by Edward Fetzer on 31.10.22.
//

import Foundation

struct APIClient {
    
    func getMacros (searchItem: String, completion: @escaping(Macros) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "\(apiKey)",
            "X-RapidAPI-Host": "calorieninjas.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://calorieninjas.p.rapidapi.com/v1/nutrition?query=\(searchItem)")! as URL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error  in
            
            if (error != nil) {
                print(error!)
                
            } else {
                
                let decoder = JSONDecoder()
                do {
                    let macros = try decoder.decode(Macros.self, from: data!)
                    
                    
                    if macros.items!.isEmpty {
                        print("empty List")
                    } else {
                        
                        print(macros.items!)
                        completion(macros)
                        
                        
                    }
                    //
                } catch {
                    print("Error pasing JSON")
                }
            }
        })
        
        dataTask.resume()
    }
}
