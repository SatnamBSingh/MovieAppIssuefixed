//
//  TopRatedViewController.swift
//  AppleMovie
//
//  Created by Captain on 14/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit
import Kingfisher
class TopRatedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    var getMoviesArrayData = [AppleMoviesData]()
    var movies:AppleMoviesData?
    var positionScroll:CGFloat = 0
    var movieDescription:String!
    var pagenumber = 1
    var api = API()
    var dataBase = DataBase()
    
    
    @IBOutlet var populartableview: UITableView!
    @IBOutlet var toprtdcollectionView: UICollectionView!
    
    
    @IBAction func seeAllButtton(_ sender: Any) {
        let showallMovies = self.storyboard?.instantiateViewController(withIdentifier: "ShowAllMoviesViewController") as! ShowAllMoviesViewController
        navigationController?.pushViewController(showallMovies, animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populartableview.delegate = self
        populartableview.dataSource = self
        pagenumber = 1

        JsonParseData.jsonMoviesData.jsonURLS(Moviescateogry: "top_rated", page: pagenumber)
        getMoviesArrayData = JsonParseData.jsonMoviesData.moviesDataArray
        
        jsonparsingfortoprated.jsonMoviesData.jsonURLS(Moviescateogry: "popular", page: pagenumber)
        getMoviesArrayData = JsonParseData.jsonMoviesData.moviesDataArray
        populartableview.reloadData()
        
        DispatchQueue.global().sync {
            self.api.fetchingMovies(movieLanguage: "en-US", pageNumber: 1, category: .topRatedMovies)
            self.api.fetchingMovies(movieLanguage: "en-US", pageNumber: 1, category: .popularMovies)
            let manageData = DataBase()
            manageData.readFromCoreData(category: .topRatedMovies)
            // self.getMoviesArrayData = dataBase
            self.populartableview.reloadData()
            
        }

    }
   
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getMoviesArrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCollectionViewCell", for: indexPath) as! TopRatedCollectionViewCell
        cell.toprtdImageview.layer.cornerRadius = 10
        cell.toprtdImageview.clipsToBounds = true
        
        let moviestoShowinCell = getMoviesArrayData[indexPath.row]
        cell.topratedNamelbl.text = moviestoShowinCell.title
        cell.topratedPopularitylbl.text = String(moviestoShowinCell.popularity)
        cell.topratedDescriptionlbl.text = moviestoShowinCell.overview
        cell.topratedvoteavglbl.text = String(moviestoShowinCell.vote_average)
        cell.topvotecountlbl.text = String(moviestoShowinCell.vote_count)
        cell.toprtdImageview.kf.setImage(with: URL(string: JsonParseData.jsonMoviesData.imageurl + moviestoShowinCell.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! TopRatedCollectionViewCell
        let movie = getMoviesArrayData[indexPath.row]
        movieDescription = currentCell.topratedDescriptionlbl.text
        movieDescription = currentCell.topratedPopularitylbl.text
        movieDescription = currentCell.topvotecountlbl.text
        performSegue(withIdentifier: "toprateddetails", sender: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.global().async {
            if indexPath.row == self.getMoviesArrayData.count-1 {
                self.pagenumber = self.pagenumber + 1
                self.pageReload(pagenumber: self.pagenumber, moviescateogry: "top_rated")
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    let screenname = "TopRated"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toprateddetails") {
            guard let movie  = sender as? AppleMoviesData else{
                return
            }
            let detailsVc =  segue.destination as! DetailsViewController
            detailsVc.movie = movie
            detailsVc.getMovieCatoegry = screenname

        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMoviesArrayData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTableViewCell", for: indexPath) as! TopRatedTableViewCell
            cell.MVImageView.layer.cornerRadius = 10
            cell.MVImageView.clipsToBounds = true
            let moviestoShowinCell = getMoviesArrayData[indexPath.row]
            cell.movienamelbl.text = moviestoShowinCell.title
            cell.popularitylbl.text = String(moviestoShowinCell.popularity)
            cell.releaseddatelbl.text = moviestoShowinCell.release_date
            cell.votecountlbl.text = String(moviestoShowinCell.vote_count)
            cell.selectionStyle = .none
            cell.MVImageView.kf.setImage(with: URL(string: JsonParseData.jsonMoviesData.imageurl + moviestoShowinCell.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
            
            if indexPath.row != 1 {
                
            }
            else {
                
            }
            
            return cell
            
        }
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "TopRatedMoviesTableViewCell", for: indexPath) as! TopRatedMoviesTableViewCell
        cell1.topratedcollectionview.reloadData()
        cell1.separatorInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        
        return cell1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return 300
        }
        
        return 114
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as! TopRatedTableViewCell
        let movie = getMoviesArrayData[indexPath.row]
        movieDescription = currentCell.movienamelbl.text
        movieDescription = currentCell.popularitylbl.text
        movieDescription = currentCell.votecountlbl.text
        performSegue(withIdentifier: "toprateddetails", sender: movie)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.global().async {
            if indexPath.row == self.getMoviesArrayData.count-1 {
                self.pagenumber = self.pagenumber + 1
                self.pageReload(pagenumber: self.pagenumber, moviescateogry: "popular")
                
            }
        }
    }
    func pageReload(pagenumber: Int, moviescateogry: String){
        
        JsonParseData.jsonMoviesData.jsonURLS(Moviescateogry: moviescateogry, page: pagenumber)
        getMoviesArrayData += JsonParseData.jsonMoviesData.moviesDataArray
        DispatchQueue.main.async {
            self.populartableview.reloadData()
        }
    }
}
extension TopRatedViewController:UIScrollViewDelegate{

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        positionScroll = self.populartableview.contentOffset.y
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.populartableview.contentOffset.y > self.positionScroll || self.populartableview.contentOffset.y < self.positionScroll{
            self.populartableview.isPagingEnabled = true
        } else{
            self.populartableview.isPagingEnabled = false
        }
    }
}
