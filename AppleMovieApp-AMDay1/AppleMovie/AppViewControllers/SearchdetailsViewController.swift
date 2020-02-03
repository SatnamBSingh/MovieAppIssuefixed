//
//  SearchdetailsViewController.swift
//  AppleMovie
//
//  Created by Captain on 21/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit
import Kingfisher
class SearchdetailsViewController: UIViewController {


//    @IBOutlet var searchtableview: UITableView!
//    @IBAction func cancelbutton(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//
//    }
    
//    var getMoviesArrayData = [Searchmovies]()
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return getMoviesArrayData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
//
//        cell.serachimgvw1.layer.cornerRadius = 10
//        cell.serachimgvw1.clipsToBounds = true
//        cell.serachimgvw2.layer.cornerRadius = 20
//        cell.serachimgvw2.clipsToBounds = true
//
//        let moviestoshow = getMoviesArrayData[indexPath.row]
//       cell.searchmovinmae.text = moviestoshow.title
//        cell.searchreleasedlbl.text  = moviestoshow.release_date
//        cell.searchpopularitylbl.text = String(moviestoshow.popularity)
//        cell.searchvotecnt.text = String(moviestoshow.vote_count)
//        cell.serachimgvw2.kf.setImage(with: URL(string: JsonParseData.JsonMoviesData.imageurl + moviestoshow.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
//
//        return cell
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchtableview.delegate = self
//        searchtableview.dataSource = self
////        Searchjson.SearchMoviesData.JsonURLS(string: "String", page: 1)
////        getMoviesArrayData = Searchjson.SearchMoviesData.SearchMoviesDataArray
//        // Do any additional setup after loading the view.
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
