//
//  MoviePosterGridViewModel.swift
//  Assignment
//
//  Created by Savleen on 11/03/21.
//

import Foundation

class MoviePosterGridViewModel:NSObject  {
    var dataClosure : (() -> Void)?
    var moviePosterGridResponse: MoviePosterGridResponse?

    func getMoviesPosterList(page:Int) {
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
                    if let closure = self.dataClosure {
                        closure()
                    }
                }
            }
        }
    }
}


