//
//  RecipeListModel.swift
//  RecipeList
//
//  Created by RLSUU210300 on 2022/02/07.
//

import Foundation
import ObjectMapper


class RecipeListModelMapObject: Mappable {
    
    var code:NSInteger?
    var data:[RecipeListMode]!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        code <- map["code"]
        data <- map["data"]
    }
}

class Thumbnail: Mappable {
    /// タイトル
    var title: String?
    /// サムネイルリンク
    var thumbnailLink: String?
    
    required init?(map: Map) {
    
    }
    func mapping(map: Map) {
        title <- map["title"]
        thumbnailLink <- map["thumbnail-square-url"]
    }
}


class RecipeListMode:  Mappable {
    /// id
    var id: String?
    /// タイプ
    var type: String?
    /// サムネイルリスト
    var thumbnails: Thumbnail?
    
    required init?(map: Map) {
    
    }
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        thumbnails <- map["attributes"]
        
    }
}
