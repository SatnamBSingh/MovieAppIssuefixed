//
//  DetailsViewController.swift
//  AppleMovie
//
//  Created by Captain on 14/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit
import Kingfisher
class DetailsViewController: UIViewController {

    var getMoviesArrayData = [AppleMoviesData]()
    var movie:AppleMoviesData? 
    var getMovieCatoegry:String?
    
    @IBOutlet weak var cancelbuttonoutlet: UIButton!
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "Backsegue", sender: IndexPath.self)
    }
    
    
    @IBOutlet weak var movienamelabel: UILabel!
    @IBOutlet weak var moviescateogrylbl: UILabel!
    @IBOutlet var movieimageview: UIImageView!
    @IBOutlet var languagelabel: UILabel!
    @IBOutlet var votecountlabel: UILabel!
    @IBOutlet var descriptionlabel: UILabel!
    @IBOutlet weak var popularity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movienamelabel.text = movie!.title
        popularity.text = "\(movie!.popularity)"
        movieimageview.kf.setImage(with: URL(string: JsonParseData.jsonMoviesData.imageurl + movie!.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
        votecountlabel.text = "\(movie!.vote_count)"
        descriptionlabel.text = movie?.overview
        languagelabel.text = movie?.original_language
        cancelbuttonoutlet.layer.cornerRadius = 15
        if let receiveName = getMovieCatoegry{
            moviescateogrylbl.text = receiveName
        }
        
        // Do any additional setup after loading the view.
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
