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

    func getMoviesPosterList(page:Int,filterType:Filter) {
        isChangeFilter = false
        var service = Service.init(httpMethod: .GET)
        service.url = ServiceHelper.moviesPosterUrl(page: page)

        ServiceManager.processDataFromServer(service: service, model: MoviePosterGridResponse.self) { (responseVo, error) in
            if let e = error {
                print("Error = ", e.localizedDescription)
                if let closure = self.dataClosure {
                    closure()
                }
            } else {
                if let res = responseVo {
                    self.moviePosterGridResponse = res
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
        default:break
        }
    }
    
    func changeFilter(type:Filter) {
        self.filterType = type
        isChangeFilter = true
    }
}


