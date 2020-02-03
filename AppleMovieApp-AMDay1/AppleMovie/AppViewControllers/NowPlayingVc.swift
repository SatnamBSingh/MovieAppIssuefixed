//
//  NowPlayingVc.swift
//  AppleMovie
//
//  Created by Captain on 13/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher
class NowPlayingVc: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    

    @IBOutlet weak var collectionviewnp: UICollectionView!
    var getMoviesArrayData = [AppleMoviesData]()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var movieDescription:String!
    var pagenumber = 1
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getMoviesArrayData.count

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowplayingCollectionViewCell", for: indexPath) as! NowplayingCollectionViewCell
        cell.layer.cornerRadius = 30
        cell.movieimageview.layer.cornerRadius = 20
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 20)
        cell.layer.shadowRadius = 20
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        
        let MoviestoShowinCell = getMoviesArrayData[indexPath.row]
        cell.movienamelabel.text = MoviestoShowinCell.title
        cell.moviedescriptionlabel.text = MoviestoShowinCell.overview
        cell.releaselabel.text = MoviestoShowinCell.release_date
        cell.ratinglabel.text = String(MoviestoShowinCell.vote_average)
        cell.votinglabel.text = String(MoviestoShowinCell.vote_count)
        cell.movieimageview.kf.setImage(with: URL(string: JsonParseData.JsonMoviesData.imageurl + MoviestoShowinCell.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.global().async {
            if indexPath.row == self.getMoviesArrayData.count-1 {
                self.pagenumber = self.pagenumber + 1
                self.getsSearchMovies(pagenumber: self.pagenumber, moviescateogry: "now_playing")
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentcell = collectionviewnp.cellForItem(at: indexPath) as! NowplayingCollectionViewCell
        let movie = getMoviesArrayData[indexPath.row]
        movieDescription = currentcell.moviedescriptionlabel.text
        performSegue(withIdentifier: "details", sender: movie)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionviewnp.delegate = self
        collectionviewnp.dataSource = self
        //pagenumber = 1
        getsSearchMovies(pagenumber: pagenumber, moviescateogry: "now_playing")
        print(getMoviesArrayData)
    }
    
    let Screenname = "NowPlaying"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "details") {
            guard let movie  = sender as? AppleMoviesData else{
                return
            }
            let detailsvc =  segue.destination as! DetailsViewController
            detailsvc.movie = movie
            detailsvc.GetMovieScreenname = Screenname
        }
    }
    func getsSearchMovies(pagenumber: Int, moviescateogry: String){
        
        JsonParseData.JsonMoviesData.JsonURLS(Moviescateogry: moviescateogry, page: pagenumber)
        getMoviesArrayData += JsonParseData.JsonMoviesData.MoviesDataArray
        DispatchQueue.main.async {
            self.collectionviewnp.reloadData()
        }
    }
    
    //For Displaying Cateogry of movies
//    enum Cateogry: CaseIterable{
//        case NowPlaying
//        case TopRated
//        case Popular
//        case UpComing
//    }
//
//    var selectedCateogry = Cateogry.NowPlaying
//    selectedCateogry = .NowPalying
//    switch selectedCateogry{
    //    case .NowPlaying:
//    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
