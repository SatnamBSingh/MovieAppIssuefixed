//
//  DataBase.swift
//  AppleMovie
//
//  Created by Captain on 31/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class DataBase {
    
    enum movieCateogry: String{
        case nowPlayingMovies = "now_playing"
        case topRatedMovies = "top_rated"
        case popularMovies = "popular"
        case upcomingMovies = "upcoming"
    }
    
    static let manager = DataBase()
    static var nowPlayingMovies1 = [AppleMoviesData]()
    static var topRatedMovies1 = [TopRatedMovies]()
    static var popularMovies1 = [AppleMoviesData]()
    static var upcomingMovies1 = [AppleMoviesData]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var moviesData:AppleMoviesData?
    

    //Insert into coredata
    func insertData(movies: [AppleMoviesData],category : movieCateogry){
        let context = appDelegate.persistentContainer.viewContext
        let moviObj:NSObject = NSEntityDescription.insertNewObject(forEntityName: "AppleMovies", into: context)
        // moviObj.setValue(self.orginal.text, forKey: "AppleMovies")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppleMovies")
        do
        {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                let populrty = data.value(forKey: "popularity") as! Double
                let votecnt = String(data.value(forKey: "vote_count") as! Double)
                let orgTitle = data.value(forKey: "original_title") as! String
                let orgLang = data.value(forKey: "original_language") as! String
                let ids = data.value(forKey: "id") as! Double
                let img = data.value(forKey: "poster_path") as! String
                let movisCatoegry = data.value(forKey: "movieCateogory") as! String
                
                switch category{
                case .nowPlayingMovies:
                    moviObj.setValue("now_playing", forKey: "movieCateogory")
                    
                case .popularMovies:
                    moviObj.setValue("popular", forKey: "movieCateogory")
                    
                case .topRatedMovies:
                    moviObj.setValue("top_rated", forKey: "movieCateogory")
                    
                case .upcomingMovies:
                    moviObj.setValue("upcoming", forKey: "movieCateogory")
                }
                
                
            }
            
            try context.save()
            print(context)
            readFromCoreData(category: category)
        }
        catch
        {
            print("insertion: successful")
        }
    }
   
    //Fetchdata from coredata
    func readFromCoreData(category: movieCateogry)
    {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppleMovies")
        do
        {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                let populrty = data.value(forKey: "popularity") as! Double
                let votecnt = String(data.value(forKey: "vote_count") as! Double)
                let orgTitle = data.value(forKey: "original_title") as! String
                let orgLang = data.value(forKey: "original_language") as! String
                let ids = data.value(forKey: "id") as! Double
                let img = data.value(forKey: "poster_path") as! String
                let movisCatoegry = data.value(forKey: "movieCateogory") as! String
                
                switch category {
                case .nowPlayingMovies:
                    request.predicate = NSPredicate(format: "movieCateogory == %@", argumentArray: ["now_playing"])
                    DataBase.nowPlayingMovies1 = [AppleMoviesData]()
                    
                case .popularMovies:
                    request.predicate = NSPredicate(format: "movieCateogory == %@", argumentArray: ["popular"])
                    DataBase.popularMovies1 = [AppleMoviesData]()
                    
                case .topRatedMovies:
                    request.predicate = NSPredicate(format: "movieCateogory == %@", argumentArray: ["top_rated"])
                    DataBase.topRatedMovies1 = [TopRatedMovies]()
                    
                case .upcomingMovies:
                    request.predicate = NSPredicate(format: "movieCateogory == %@", argumentArray: ["upcoming"])
                    DataBase.upcomingMovies1 = [AppleMoviesData]()
                }
                
            }
            
        }
        catch
        {
            print(error.localizedDescription)
            
        }
    }
    
    
    
}


