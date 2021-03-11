//
//  MoviePosterGridController.swift
//  Assignment
//
//  Created by Savleen on 11/03/21.
//

import UIKit

class MoviePosterGridController: UIViewController {
    @IBOutlet weak var posterCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    private var searchActive : Bool = false
    private var router: AppRouter?
    private var gridViewModel = MoviePosterGridViewModel()
    private var posterList:[MoviePosterGrid] = [] {
        didSet{
            DispatchQueue.main.async {
                self.posterCollectionView.reloadData()
            }
        }
    }
    
    private var filterList:[MoviePosterGrid] = [] {
        didSet{
            DispatchQueue.main.async {
                self.posterCollectionView.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customSetting()
        addViewModelListeners()
        gridViewModel.getMoviesPosterList(page:1)
    }
}

//MARK:- Private Methods
extension MoviePosterGridController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            searchActive = false;
            searchBar.resignFirstResponder()
            self.posterCollectionView.reloadData()
        } else {
            searchActive = true
            self.filterList = self.posterList.filter({$0.original_title.contains(searchText)})
        }
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
        
        self.gridViewModel.routeToDetailClosure = {[weak self] grid in
            if let this = self {
                if let router = this.router {
                    router.route(to: .posterDetail, from: this, parameters: grid)
                }
            }
        }
        
    }
    
    private func customSetting() {
        self.router = AppRouter.init(viewModel: self.gridViewModel)
        posterCollectionView.register(PosterCell.nib, forCellWithReuseIdentifier: PosterCell.identifier)
    }
    
}

extension MoviePosterGridController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.size.width / 2 , height: UIScreen.main.bounds.size.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive {
            return filterList.count
        }
        return self.posterList.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.identifier, for: indexPath) as! PosterCell
        if searchActive {
            cell.setData(grid: self.filterList[indexPath.row])
        }   else {
            cell.setData(grid: self.posterList[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchActive {
        self.gridViewModel.handleEvent(event: .posterClick(grid: self.filterList[indexPath.row]))
        } else {
            self.gridViewModel.handleEvent(event: .posterClick(grid: self.posterList[indexPath.row]))

        }
    }
    
}
