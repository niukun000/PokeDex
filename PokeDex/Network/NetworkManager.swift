//
//  NetworkManager.swift
//  PokeDex
//
//  Created by Kun Niu on 11/15/22.
//

import Foundation

class NetworkManager {
    let session : URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchPageResult(with url : URL, completion : @escaping(PageResult?) -> Void) {
        let task = self.session.dataTask(with: url){
            data, response, error in
            print("fetch pokemon data")
            guard let data = data else{
                print("no data from pages")
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let result = try decoder.decode(PageResult.self, from: data)
                
                completion(result)
            }
            catch {
                print("failed to decode")
                print(error)
                completion(nil)
//                return
            }
            
        }
        task.resume()
    }
    
    func fetchPokemon(with url : URL, completion : @escaping(Pokemon?) -> Void) {
        let temp = self.session.dataTask(with: url){            data, response, error in
            print("check\(url)")
            guard let data = data else{
                print("no data from pages")
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let result = try decoder.decode(Pokemon.self, from: data)
//                print("decoded data")
                completion(result)
            }
            catch {
                print("failed to decode")
                print(error)
                completion(nil)
//                return
            }
            
        }
        temp.resume()
    }
    func fetchRawData(url : URL, completion: @escaping(Data?) -> Void){
        let task = self.session.dataTask(with: url){
            data, response, error in
            if let _ = error{
                completion(nil)
                return
            }
            guard let data = data else {
                print("failed to fetch picture data \(url )")
                completion(nil)
                return
            }
            completion(data)
        }
        
        task.resume()
    }

}
