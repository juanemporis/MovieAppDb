//
//  ApiService.swift
//  MovieApp
//
//  Created by levi on 13/06/22.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?

    func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {

        let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"

        guard let url = URL(string: popularMoviesURL) else {return}

        // Crea sesion de trabajo c=en background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in

            //Error de manejo
            if let error = error {
                completion(.failure(error))
                debugPrint("DataTask error: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                //Manejar respuesta de datos
                debugPrint("Empty Response")
                return
            }
            debugPrint("Response status code: \(response.statusCode)")

            guard let data = data else {
                // Manejar datos vacios
                debugPrint("Empty Data")
                return
            }

            do {
                //Analizar los datos
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }

        }
        dataTask?.resume()
    }

}


