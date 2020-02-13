//
//  UpComingViewController.swift
//  AppleMovie
//
//  Created by Captain on 15/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit
import Kingfisher
class UpComingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var getMoviesArrayData = [AppleMoviesData]()
    var movies:AppleMoviesData?
    var movieDescription:String!
    var pagenumber = 1
    var api = API()
    var dataBase = DataBase()
    
    @IBOutlet var upcomingtableV: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingtableV.delegate = self
        upcomingtableV.dataSource = self
        JsonParseData.jsonMoviesData.jsonURLS(Moviescateogry: "upcoming", page: 1)
        getMoviesArrayData = Upcoming.jsonMoviesData.moviesDataArray
        pagenumber = 1
        getPageCount(pagenumber: pagenumber, moviescateogry: "upcoming")
        print(getMoviesArrayData)
        
        DispatchQueue.global().sync {
            self.api.fetchingMovies(movieLanguage: "en-US", pageNumber: 1, category: .upcomingMovies)
            let manageData = DataBase()
            manageData.readFromCoreData(category: .upcomingMovies)
            // self.getMoviesArrayData = dataBase
            self.upcomingtableV.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMoviesArrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as! UpcomingTableViewCell
        cell.upcomingImgView.layer.cornerRadius = 10
        cell.upcomingImgView.clipsToBounds = true
        let moviestoShow = getMoviesArrayData[indexPath.row]
        cell.mvnameUpcm.text = moviestoShow.title
        cell.releasedateupcm.text = moviestoShow.release_date
        cell.popularityupcm.text = String(moviestoShow.popularity)
        cell.votecountupcm.text = String(moviestoShow.vote_count)
        cell.selectionStyle = .none
        cell.upcomingImgView.kf.setImage(with: URL(string: JsonParseData.jsonMoviesData.imageurl + moviestoShow.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.global().async {
            if indexPath.row == self.getMoviesArrayData.count-1 {
                self.pagenumber = self.pagenumber + 1
                self.getPageCount(pagenumber: self.pagenumber, moviescateogry: "upcoming")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! UpcomingTableViewCell
        let movie = getMoviesArrayData[indexPath.row]
        movieDescription = currentCell.mvnameUpcm.text
        movieDescription = currentCell.popularityupcm.text
        movieDescription = currentCell.votecountupcm.text
        //Detailsfromupcoming
        performSegue(withIdentifier: "Detailsfromupcoming", sender: movie)
    }
    let name = "UpComing"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Detailsfromupcoming") {
            guard let movie  = sender as? AppleMoviesData else{
                return
            }
            let detailsvc =  segue.destination as! DetailsViewController
            detailsvc.movie = movie
            detailsvc.getMovieCatoegry = name
        }
    }
    
    func getPageCount(pagenumber: Int, moviescateogry: String){
        
        JsonParseData.jsonMoviesData.jsonURLS(Moviescateogry: moviescateogry, page: pagenumber)
        getMoviesArrayData += JsonParseData.jsonMoviesData.moviesDataArray
        DispatchQueue.main.async {
            self.upcomingtableV.reloadData()
        }
    }
    
}
