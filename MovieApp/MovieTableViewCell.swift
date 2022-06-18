//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by levi on 14/06/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverView: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    
    private var urlString: String = ""
    
    
    private func updateUI(title : String?, releaseDate : String?, rating : Double?, overview : String?, poster : String?  ) {
        
        self .movieTitle.text = title
        self .movieYear.text = convertDateFormater(releaseDate)
        guard let rate = rating else {
            return
        }
        self .movieYear.text = String (rate)
        self .movieOverView.text = overview
        
        guard let posterString = poster else {
            return
        }
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvaidable")
            return
        }
        
        self.moviePoster.image = nil
        
    }
    func convertDateFormater (_ date : String?) -> String {
        var fixDate = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
         return fixDate
        
    }
}
