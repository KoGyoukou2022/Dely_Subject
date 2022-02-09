//
//  UserDefaultManager.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/09.
//

import Foundation
import ObjectMapper

class LocalStorageManager {
    
    static let identify = "favorites"
    
    //path for cache file
    static private func filePath(_ fileName: String) -> URL?{
        let manager = FileManager.default
        guard let cachePath = manager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let directory = cachePath.appendingPathComponent("ObjectMapperCache")
        if !manager.fileExists(atPath: directory.path){
            do{
                try manager.createDirectory(atPath: directory.path, withIntermediateDirectories: true, attributes: nil)
            }catch{
                return nil
            }
        }
        let path = directory.appendingPathComponent(fileName)
        return path
    }
    
    //save as array
    @discardableResult
    static public func setCache(array: [BaseMappable], for fileName: String = identify) -> Bool{
        return self.setCache(json: array.map({$0.toJSON()}), for: fileName)
    }
    
    //get array
    static public func cacheArray<T: BaseMappable>(for fileName: String = identify) -> Array<T>?{
        guard let jsonArray = cacheJson(for: fileName) as? [[String: Any]] else {return nil}
        return Mapper<T>().mapArray(JSONArray: jsonArray)
    }
    
    //save as json
    @discardableResult
    static public func setCache(json: Any, for fileName: String = identify) -> Bool{
        guard let filePath = filePath(fileName) else {return false}
        if let array = json as? [Any]{
            let jsonArray = NSArray(array: array)
            return jsonArray.write(to: filePath, atomically: true)
        }else if let dict = json as? [String: Any]{
            let jsonDict = NSDictionary(dictionary: dict)
            return jsonDict.write(to: filePath, atomically: true)
        }else {
            return false
        }
    }
    
    //get json
    static public func cacheJson(for fileName: String = identify) -> Any?{
        guard let filePath = filePath(fileName) else {return nil}
        if let jsonArray = NSArray(contentsOf: filePath){
            return jsonArray
        }else if let jsonDict = NSDictionary(contentsOf: filePath){
            return jsonDict
        }else{
            return nil
        }
    }
}

