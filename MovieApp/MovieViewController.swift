//
//  ViewController.swift
//  MovieApp
//
//  Created by levi on 13/06/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    loadPopularMoviesData()
        
    }
    
    private func loadPopularMoviesData() {
        
        viewModel.fetchPopularMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
    
}
//TableView
extension MovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return viewModel.numberOfRowsInsection(section: section)
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let movie = viewModel .cellForRowAt(indexPath: indexPath)
        cell.setCellWithValueOf(movie)
        
        return cell
    }
    
    
}
