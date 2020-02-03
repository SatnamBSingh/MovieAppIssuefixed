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
    static let manager = DataBase()
    static var nowPlayingMovies = [AppleMoviesData]()
    static var topRatedMovies = [TopRatedMovies]()
    static var upcomingMovies = [UpcomingMovies]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var moviesdata:AppleMoviesData?
    
    func SavemoviesData(movies: [AppleMoviesData]){
        
    }

    //Insert into coredata
    func InsertData(){
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
            }
            
            try context.save()
            print(context)
            readFromCoreData()
        }
        catch
        {
            print("insertion: successful")
        }
    }
   
    //coredata function
    func readFromCoreData()
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
            }
//                        if moviesdata.count > 0
//                        {
//                         //   UITableView.reloadData()
//                        }
        }
        catch
        {
            
        }
    }

    
    
}


