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
    
    //configurar los valores de la película
    func setCellWithValueOf(_ movie : Movie) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    
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
        //antes de descargar la imagen borramos la anterior
        self.moviePoster.image = nil
        
        getImageDataFrom(url: posterImageURL)
        
        //obtener datos de imagen
         func getImageDataFrom(url : URL) {
            URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                
                //error de manejo
                if let error = error {
                    debugPrint("dataTask error: \(error.localizedDescription)")
                    return
                }
                guard let data = data else {
                    //manejar datos vacíos
                    debugPrint("Empty Data")
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self .moviePoster.image = image
                    
                }
                
            }
            
            }.resume()
        }
    
    //convertir formato de datos
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
    }

