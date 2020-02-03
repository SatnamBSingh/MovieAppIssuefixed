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
    private var databaseManager = DataBase()
    private var searchedMovies = [AppleMoviesData]()


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
