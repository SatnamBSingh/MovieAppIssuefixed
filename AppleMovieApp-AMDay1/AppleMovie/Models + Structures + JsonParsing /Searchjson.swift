//
//  Searchjson.swift
//  AppleMovie
//
//  Created by Captain on 17/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import Foundation

public class Searchjson {
    static let SearchMoviesData = Searchjson()
    func JsonURLS(string: String, page: Int, completetion : (Bool, searchmodel?) -> ()) {
        let PageNum = String(page)

        let Pathkey = "?api_key=60af9fe8e3245c53ad9c4c0af82d56d6&language=en-US&page=\(PageNum)&query=\(string)"
        let moviesURL = "https://api.themoviedb.org/3/search/movie" + Pathkey
        
        if let url = URL(string: moviesURL) {
            if let data = try? Data(contentsOf: url){
                guard let model =  MoviesJsonParsing(json: data) else {
                    completetion(false, nil)
                    return
                }
                completetion(true, model)
            }
        }
    }
    func MoviesJsonParsing(json: Data) -> searchmodel?{
        let decoder =  JSONDecoder()
        var searchmovies: searchmodel?
        if let SearchMoviesJsonData = try? decoder.decode(searchmodel.self, from: json){
            searchmovies = SearchMoviesJsonData
        }
        return searchmovies

    }
   
}
//let Pathkey = "?api_key=60af9fe8e3245c53ad9c4c0af82d56d6&language=en-US&page=1&query=Endgame"
//let moviesURL = "https://api.themoviedb.org/3/search/movie" + Moviescateogry + Pathkey
