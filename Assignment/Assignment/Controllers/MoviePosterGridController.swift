//
//  MoviePosterGridController.swift
//  Assignment
//
//  Created by Savleen on 11/03/21.
//

import UIKit

class MoviePosterGridController: UIViewController {
    private var gridViewModel = MoviePosterGridViewModel()
    private var posterList:[MoviePosterGrid] = [] {
        didSet{
            DispatchQueue.main.async {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addViewModelListeners()
        gridViewModel.getMoviesPosterList(page:1)
    }


}

//MARK:- Private Methods
extension MoviePosterGridController {
    private func addViewModelListeners() {
        self.gridViewModel.dataClosure = {[weak self] in
            if let this = self {
                if let response = this.gridViewModel.moviePosterGridResponse {
                    this.posterList.append(contentsOf: response.posterlist)
                }
            }
        }
    }
    
}
