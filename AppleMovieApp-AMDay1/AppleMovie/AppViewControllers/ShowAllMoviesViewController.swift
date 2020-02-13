//
//  ShowAllMoviesViewController.swift
//  AppleMovie
//
//  Created by Captain on 12/02/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit
import Kingfisher
class ShowAllMoviesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var getMoviesArrayData = [AppleMoviesData]()
    var pagenumber = 1
    var movieDescription:String!

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMoviesArrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowAllTableViewCell", for: indexPath) as! ShowAllTableViewCell
        let MoviestoShowinCell = getMoviesArrayData[indexPath.row]
        cell.showAllMoviename.text = MoviestoShowinCell.title
        cell.releaseDate.text = MoviestoShowinCell.release_date
        cell.voteCount.text = String(MoviestoShowinCell.vote_count)
        cell.showallImage.kf.setImage(with: URL(string: JsonParseData.jsonMoviesData.imageurl + MoviestoShowinCell.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.global().async {
            if indexPath.row == self.getMoviesArrayData.count-1 {
                self.pagenumber = self.pagenumber + 1
                self.getNextPage(pagenumber: self.pagenumber, moviescateogry: "top_rated")
                
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! ShowAllTableViewCell
        let movie = getMoviesArrayData[indexPath.row]
        movieDescription = currentCell.showAllMoviename.text
        movieDescription = currentCell.releaseDate.text
        movieDescription = currentCell.voteCount.text
        performSegue(withIdentifier: "showAlltoDetails", sender: movie)
    }
    
    let screenName = "Showing TopRated"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showAlltoDetails") {
            guard let movie  = sender as? AppleMoviesData else{
                return
            }
            let detailsVc =  segue.destination as! DetailsViewController
            detailsVc.movie = movie
            detailsVc.getMovieCatoegry = screenName
            
        }
    }
    
    @IBOutlet weak var showAllMoviesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        showAllMoviesTable.delegate = self
        showAllMoviesTable.dataSource = self
        pagenumber = 1
        JsonParseData.jsonMoviesData.jsonURLS(Moviescateogry: "top_rated", page: pagenumber)
        getMoviesArrayData = JsonParseData.jsonMoviesData.moviesDataArray
        showAllMoviesTable.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    func getNextPage(pagenumber: Int, moviescateogry: String){
        
        JsonParseData.jsonMoviesData.jsonURLS(Moviescateogry: moviescateogry, page: pagenumber)
        getMoviesArrayData += JsonParseData.jsonMoviesData.moviesDataArray
        DispatchQueue.main.async {
            self.showAllMoviesTable.reloadData()
        }
    }

    //showAlltoDetails

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
