//
//  APIHandler.swift
//  NoteApp
//
//  Created by כפיר פנירי on 26/03/2022.
//

import Foundation

class APIHandler{
    static let shared = APIHandler()
    
    func syncUsers(completion: @escaping (([User]?)-> Void)){
        var req = URLRequest(url: URL(string:
                                        "https://api.mockaroo.com/api/729a5c80?count=120&key=947b40d0")!)
        req.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: req,completionHandler: { data, response, error -> Void in
            print(response!)
            do{
                let model = try JSONDecoder().decode([UserServerModel].self, from: data!)
                var arr : [User] = []
                
                model.forEach {
                    guard let user =  $0.store() else {return}
                    arr.append(user)
                }
                completion(arr)
            } catch {
                print(error)
                completion(nil)
            }
        })
        task.resume()
    }
}

