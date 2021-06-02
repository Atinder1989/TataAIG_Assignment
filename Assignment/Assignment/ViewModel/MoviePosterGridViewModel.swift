//
//  MoviePosterGridViewModel.swift
//  Assignment
//
//  Created by Savleen on 11/03/21.
//

import Foundation

enum Event {
    case posterTap(grid:MoviePosterGrid)
    case filterTap
    case nextPage
    case none
}

protocol AppViewModel {
    
}

class MoviePosterGridViewModel:AppViewModel  {
    var dataClosure : (() -> Void)?
    var filterDataClosure : (() -> Void)?
    var routeToPosterDetailClosure : ((_ grid:MoviePosterGrid) -> Void)?
    var routeToFilterClosure : (() -> Void)?
    var moviePosterGridResponse: MoviePosterGridResponse?
    
    private var isChangeFilter = false
    private var filterType: Filter = .none {
        didSet{
            DispatchQueue.main.async { [weak self] in
                if let this = self {
                if let response = this.moviePosterGridResponse {
                    let list = this.applyFilterToList(list: response.posterlist)
                    this.moviePosterGridResponse?.posterlist = list
                    if !this.isChangeFilter {
                        if let closure = this.dataClosure {
                            closure()
                        }
                    } else {
                        if let closure = this.filterDataClosure {
                            closure()
                        }
                    }
                }
                }
                
            }
        }
    }
    
}


//MARK:- Private Methods
extension MoviePosterGridViewModel {
    private func getNextPagePosterList(){
        if let response = self.moviePosterGridResponse {
            let newPage = response.page + 1
            if newPage <= response.total_pages {
                self.getMoviesPosterList(page:newPage, filterType: .highestrated)
            }
        }
    }
    
    private func applyFilterToList(list:[MoviePosterGrid]) -> [MoviePosterGrid]{
        switch self.filterType {
        case .highestrated:
            return list.sorted{ $0.vote_average < $1.vote_average}
        case .mostpopular:
            return list.sorted{ $0.popularity < $1.popularity}
        default:
            break
        }
        return []
    }
}

//MARK:- Public Methods
extension MoviePosterGridViewModel {
    func getMoviesPosterList(page:Int,filterType:Filter) {
        isChangeFilter = false
        var service = Service.init(httpMethod: .GET)
        service.url = ServiceHelper.moviesPosterUrl(page: page)

        ServiceManager.processDataFromServer(service: service, model: MoviePosterGridResponse.self) { (responseVo, error) in
            if let e = error {
                if let closure = self.dataClosure {
                    closure()
                }
            } else {
                if let res = responseVo {
                    if let gridResponse = self.moviePosterGridResponse {
                        var oldResponse = gridResponse
                        oldResponse.page = res.page
                        oldResponse.total_pages = res.total_pages
                        oldResponse.total_results = res.total_results
                        oldResponse.posterlist = res.posterlist
                        self.moviePosterGridResponse = oldResponse
                    }else {
                        self.moviePosterGridResponse = res
                    }
                    self.filterType = filterType
                }
            }
        }
    }
    
    func handleEvent(event:Event) {
        switch event {
        case .posterTap(grid: let grid):
            if let closure = self.routeToPosterDetailClosure{
                closure(grid)
            }
        case .filterTap:
            if let closure = self.routeToFilterClosure{
                closure()
            }
        case .nextPage:
            self.getNextPagePosterList()
        default:break
        }
    }
    
    func changeFilter(type:Filter) {
        self.filterType = type
        isChangeFilter = true
    }
    
}
