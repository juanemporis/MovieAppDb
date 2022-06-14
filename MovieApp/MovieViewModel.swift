//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by levi on 14/06/22.
//

import Foundation

class MovieViewModel {
    private var apiService = ApiService()
    private var popularMovies = [Movie]()
    
    func fetchPopularMoviesData(completion: @escaping () -> ()) {
        
        apiService.getPopularMoviesData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.popularMovies = listOf.movies
                completion()
            case .failure(let error):
                debugPrint("Error processing json data \(error)")
            }
        }
            
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return popularMovies[indexPath.row]
    }
}
