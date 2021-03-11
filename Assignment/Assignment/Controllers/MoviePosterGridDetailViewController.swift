//
//  MoviePosterGridDetailViewController.swift
//  Assignment
//
//  Created by Savleen on 11/03/21.
//

import UIKit

class MoviePosterGridDetailViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var realeaseDateLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!

    private var grid :MoviePosterGrid!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }

}

//MARK:- Public Methods
extension MoviePosterGridDetailViewController {
    func setGrid(grid :MoviePosterGrid) {
        self.grid = grid
    }
}

//MARK:- Private Methods
extension MoviePosterGridDetailViewController {
    func createUI() {
        self.title = self.grid.original_title
        let imageUrl = imagebaseUrl + "\(grid.poster_path)"
        self.posterImageView.setImageWith(urlString: imageUrl)
        self.realeaseDateLbl.text = "Realease Date: \(self.grid.release_date)"
        self.ratingLbl.text = "Rating: \(self.grid.vote_average)"
        self.overviewLbl.text = self.grid.overview
    }
}
