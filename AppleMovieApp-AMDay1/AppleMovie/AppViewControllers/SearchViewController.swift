//
//  SearchViewController.swift
//  AppleMovie
//
//  Created by Captain on 14/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit
import Kingfisher
class SearchViewController: UIViewController,UISearchDisplayDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet var tableviewsearches: UITableView!
    @IBOutlet var SearchBar: UISearchBar!
    //   var Movies = [Searchmovies]()
   // var getMoviesArrayData = [AppleMoviesData]()
    var movies:AppleMoviesData?
    var movieDescription:String!
    var pagenumber = 1
    
    var searchMovies = [AppleMoviesData]()
    var searchActive = true

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if searchActive {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchesTableViewCell", for: indexPath) as! SearchesTableViewCell
            let movie = searchMovies[indexPath.row]
            cell.textLabel?.text = movie.title
            return cell
        }
        else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
            cell2.serachimgvw1.layer.cornerRadius = 10
            cell2.serachimgvw1.clipsToBounds = true
            cell2.serachimgvw2.layer.cornerRadius = 15
            cell2.serachimgvw2.clipsToBounds = true
            
            let moviestoShow = searchMovies[indexPath.row]
            cell2.searchmovinmae.text = moviestoShow.title
            cell2.searchreleasedlbl.text  = moviestoShow.release_date
            cell2.searchpopularitylbl.text = String(moviestoShow.popularity)
            cell2.searchvotecnt.text = String(moviestoShow.vote_count)
            DispatchQueue.main.async {
                cell2.serachimgvw2.kf.setImage(with: URL(string: JsonParseData.jsonMoviesData.imageurl + moviestoShow.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
                cell2.serachimgvw1.kf.setImage(with: URL(string: JsonParseData.jsonMoviesData.imageurl + moviestoShow.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
            }
            
            return cell2
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return searchActive ? 51 : 391
    }
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.global().async {
            if indexPath.row == self.searchMovies.count-1 {
                self.pagenumber = self.pagenumber + 1
                self.getPageCount(pagenumber: self.pagenumber, moviescateogry: "search")
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive {
            searchActive = false
            let movie = searchMovies.remove(at: indexPath.row)
            self.searchMovies.insert(movie, at: 0)
            DispatchQueue.main.async {
                self.tableviewsearches.reloadData()
            }
        }
        else{
            let currentCell = tableView.cellForRow(at: indexPath) as! SearchTableViewCell
            let movie = searchMovies[indexPath.row]
            movieDescription = currentCell.searchpopularitylbl.text
            movieDescription = currentCell.searchmovinmae.text
            performSegue(withIdentifier: "detailsfromsearch", sender: movie)
        }
    }
    
     
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailsfromsearch") {
            guard let movie  = sender as? AppleMoviesData else{
                return
            }
            let detailsVc =  segue.destination as! DetailsViewController
            detailsVc.movie = movie
        }
    }
    
    @IBAction func cancelbutton(_ sender: Any) {
        SearchBar.text = ""
        searchActive = false
        tableviewsearches.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchBar.text!.count >= 3){
            DispatchQueue.global().async {
                self.searchActive = true
                self.getsSearchMovies(pagenumber: 1, serachtext: searchText)
                
            }
        }
        else{
            self.searchActive = false
            self.tableviewsearches.reloadData()
        }
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }

    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.delegate = self
        tableviewsearches.delegate = self
        tableviewsearches.dataSource = self
        pagenumber = 1
       // getPageCount(pagenumber: pagenumber, moviescateogry: "search")

        // Do any additional setup after loading the view.
    }
    
    func getsSearchMovies(pagenumber: Int, serachtext: String){
       
        Searchjson.searchMoviesData.jsonURLS(string: serachtext, page: pagenumber, completetion: { (success, model) in
            guard success else{
                return
            }
            guard let model = model else{
                return
            }
            self.searchMovies = model.results
            
            DispatchQueue.main.async {
                self.tableviewsearches.reloadData()
                
            }
        })
    }
    
    func getPageCount(pagenumber: Int, moviescateogry: String){
        
        JsonParseData.jsonMoviesData.jsonURLS(Moviescateogry: moviescateogry, page: pagenumber)
        searchMovies += JsonParseData.jsonMoviesData.moviesDataArray
        DispatchQueue.main.async {
            self.tableviewsearches.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
