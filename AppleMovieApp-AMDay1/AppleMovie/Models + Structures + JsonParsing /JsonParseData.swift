//
//  jsonFile.swift
//  AppleMovie
//
//  Created by Captain on 14/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import Foundation

public class JsonParseData{
    static let jsonMoviesData = JsonParseData()
    var moviesDataArray = [AppleMoviesData]()
    let imageurl =  "https://image.tmdb.org/t/p/w200"

    func jsonURLS( Moviescateogry: String, page: Int) {
        let pageNum = String(page)
       
        let pathkey = "?api_key=60af9fe8e3245c53ad9c4c0af82d56d6&language=en-US&page=\(pageNum)"
        let moviesURL = "https://api.themoviedb.org/3/movie/" + Moviescateogry + pathkey 
        
        if let url = URL(string: moviesURL) {
            if let data = try? Data(contentsOf: url){
                moviesJsonParsing(json: data)
            }
        }
    }
    func moviesJsonParsing(json: Data) {
        let decoder =  JSONDecoder()
        if let nowplayingMoviesJsonData = try? decoder.decode(AppleMoviesJsonModel.self, from: json){
            moviesDataArray = nowplayingMoviesJsonData.results
        }
        
    }
    
   
}
