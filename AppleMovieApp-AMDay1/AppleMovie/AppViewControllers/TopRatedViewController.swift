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

    @IBOutlet var populartableview: UITableView!
    @IBOutlet var toprtdcollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populartableview.delegate = self
        populartableview.dataSource = self
        //toprtdcollectionView.delegate = self
        //toprtdcollectionView.dataSource = self
    
        topratedcollectionvw.JsonMoviesData.JsonURLS(Moviescateogry: "top_rated", page: 2)
        getMoviesArrayData = JsonParseData.JsonMoviesData.MoviesDataArray
        
//        jsonparsingfortoprated.JsonMoviesData.JsonURLS(Moviescateogry: "popular", page: 2)
//        getMoviesArrayData = JsonParseData.JsonMoviesData.MoviesDataArray
        populartableview.reloadData()
        pagenumber = 1
        //getsSearchMovies(pagenumber: pagenumber, moviescateogry: "now_playing")
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
        
        let MoviestoShowinCell = getMoviesArrayData[indexPath.row]
        cell.topratedNamelbl.text = MoviestoShowinCell.title
        cell.topratedPopularitylbl.text = String(MoviestoShowinCell.popularity)
        cell.topratedDescriptionlbl.text = MoviestoShowinCell.overview
        cell.topratedvoteavglbl.text = String(MoviestoShowinCell.vote_average)
        cell.topvotecountlbl.text = String(MoviestoShowinCell.vote_count)
        cell.toprtdImageview.kf.setImage(with: URL(string: JsonParseData.JsonMoviesData.imageurl + MoviestoShowinCell.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentcell = collectionView.cellForItem(at: indexPath) as! TopRatedCollectionViewCell
        let movie = getMoviesArrayData[indexPath.row]
        movieDescription = currentcell.topratedDescriptionlbl.text
        movieDescription = currentcell.topratedPopularitylbl.text
        movieDescription = currentcell.topvotecountlbl.text
        performSegue(withIdentifier: "toprateddetails", sender: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width-2*24, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    let Screenname = "TopRated"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toprateddetails") {
            guard let movie  = sender as? AppleMoviesData else{
                return
            }
            let detailsvc =  segue.destination as! DetailsViewController
            detailsvc.movie = movie
            detailsvc.GetMovieScreenname = Screenname

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
            let MoviestoShowinCell = getMoviesArrayData[indexPath.row]
            cell.movienamelbl.text = MoviestoShowinCell.title
            cell.popularitylbl.text = String(MoviestoShowinCell.popularity)
            cell.releaseddatelbl.text = MoviestoShowinCell.release_date
            cell.votecountlbl.text = String(MoviestoShowinCell.vote_count)
            cell.selectionStyle = .none
            cell.MVImageView.kf.setImage(with: URL(string: JsonParseData.JsonMoviesData.imageurl + MoviestoShowinCell.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
           
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
        
        let currentcell = tableView.cellForRow(at: indexPath) as! TopRatedTableViewCell
        let movie = getMoviesArrayData[indexPath.row]
        movieDescription = currentcell.movienamelbl.text
        movieDescription = currentcell.popularitylbl.text
        movieDescription = currentcell.votecountlbl.text
        performSegue(withIdentifier: "toprateddetails", sender: movie)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.global().async {
            if indexPath.row == self.getMoviesArrayData.count-1 {
                self.pagenumber = self.pagenumber + 1
                self.getsSearchMovies(pagenumber: self.pagenumber, moviescateogry: "top_rated")
                
            }
        }
    }
    func getsSearchMovies(pagenumber: Int, moviescateogry: String){
        
        JsonParseData.JsonMoviesData.JsonURLS(Moviescateogry: moviescateogry, page: pagenumber)
        getMoviesArrayData += JsonParseData.JsonMoviesData.MoviesDataArray
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
