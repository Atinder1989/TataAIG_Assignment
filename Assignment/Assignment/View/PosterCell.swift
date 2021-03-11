//
//  PosterCell.swift
//  Assignment
//
//  Created by Savleen on 11/03/21.
//

import UIKit

class PosterCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.posterImageView.layer.cornerRadius = 5
    }
    
    func setData(grid:MoviePosterGrid) {
        let imageUrl = imagebaseUrl + "\(grid.poster_path)"
        self.posterImageView.setImageWith(urlString: imageUrl)
    }

}
