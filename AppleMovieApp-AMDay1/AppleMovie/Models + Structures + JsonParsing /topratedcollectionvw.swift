//
//  topratedcollectionvw.swift
//  AppleMovie
//
//  Created by Captain on 17/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import Foundation
public class topratedcollectionvw {
    static let JsonMoviesData = topratedcollectionvw()
    var MoviesDataArray = [TopRatedMovies]()
    func JsonURLS( Moviescateogry: String, page: Int) -> (){
        let PageNum = String(page)

        let Pathkey = "api_key=60af9fe8e3245c53ad9c4c0af82d56d6&language=en-US&page=\(PageNum)"
        let moviesURL = "https://api.themoviedb.org/3/movie/" + Moviescateogry + Pathkey
        
        if let url = URL(string: moviesURL) {
            if let data = try? Data(contentsOf: url){
                MoviesJsonParsing(json: data)
                
            }
        }
    }
    func MoviesJsonParsing(json: Data) {
        let decoder =  JSONDecoder()
        if let TopRatedMovies = try? decoder.decode(PopularMoviesModel.self, from: json){
            MoviesDataArray = TopRatedMovies.results
        }
        
    }
    
}
