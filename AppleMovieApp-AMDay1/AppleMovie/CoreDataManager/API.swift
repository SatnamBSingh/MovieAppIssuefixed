//
//  APImanager.swift
//  AppleMovie
//
//  Created by Captain on 31/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import Foundation
import CoreData

class API {
    
    enum movieCateogry: String{
        case nowPlayingMovies = "now_playing"
        case topRatedMovies = "top_rated"
        case popularMovies = "popular"
        case upcomingMovies = "upcoming"
    }
    
    let moviesURL = "https://api.themoviedb.org/3/movie/"
    let apiKey = "api_key=60af9fe8e3245c53ad9c4c0af82d56d6"
    let imageUrl = "https://image.tmdb.org/t/p/w200"
    
    private var databaseManager = DataBase()
    private var searchedMovies = [AppleMoviesData]()
    private var category: movieCateogry?


    
    func fetchResults(url: URL, completion: @escaping (Data)->()){
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let data = data{
                    completion(data)
                }
            }
        }
        
        dataTask.resume()
    }
    
    // fetch movies from url
    func fetchingMovies(movieLanguage: String, pageNumber: Int, category: movieCateogry){
        self.category = category
        var url = moviesURL+"now_playing?"+apiKey+"&language="+movieLanguage+"&page=\(pageNumber)"
        switch category{
        case .nowPlayingMovies:
            url = moviesURL+"now_playing?"+apiKey+"&language="+movieLanguage+"&page=\(pageNumber)"
            
        case .popularMovies:
            url = moviesURL+"popular?"+apiKey+"&language="+movieLanguage+"&page=\(pageNumber)"
            
        case .topRatedMovies:
            url = moviesURL+"top_rated?"+apiKey+"&language="+movieLanguage+"&page=\(pageNumber)"
            
        case .upcomingMovies:
            url = moviesURL+"upcoming?"+apiKey+"&language="+movieLanguage+"&page=\(pageNumber)"
        }
        
    }
    
    // save data from url
    func storeMoviedata(data: Data){
        
        do{
            let decoder = JSONDecoder()
            let movieDetails = try decoder.decode(AppleMoviesData.self, from: data)
            
        }
        catch(let error){
            print(error.localizedDescription)
        }
    }
    
}
