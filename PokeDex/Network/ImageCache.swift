//
//  ImageCache.swift
//  PokeDex
//
//  Created by Kun Niu on 11/16/22.
//

import Foundation

final class ImageCache{
    static let shared = ImageCache()
    
    private let cache: NSCache<NSString, Cach> = NSCache<NSString, Cach>()
    
    init(){
        
    }
}

final class Cach{
    var name : String
    var types : String
    var data : Data
    init(name : String,types : String,data : Data){
        self.name = name
        self.types = types
        self.data = data
    }
}
extension ImageCache {
    func get(name: String) -> Cach?{
//        let key = NSNumber(value: name)
        guard let obj : Cach = self.cache.object(forKey: name as NSString)
        else{
            return nil
        }
        print("get cache for \(name)")
        return obj
        
        
    }
    func set(name : String, data : Cach){
        let key = NSString(string: name)
//        let data = NSData(data: data)
        
        self.cache.setObject(data, forKey: key)
    }
}
