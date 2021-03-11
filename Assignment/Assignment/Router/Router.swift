//
//  Router.swift
//  Assignment
//
//  Created by Savleen on 11/03/21.
//

import Foundation
import UIKit

enum Route: String {
      case posterDetail
    case none
}

protocol Router {
   func route(
      to route: Route,
      from context: UIViewController,
      parameters: Any?
   )
}

class AppRouter: Router {
    private var viewModel: AppViewModel
    init(viewModel: AppViewModel) {
       self.viewModel = viewModel
    }
    
    func route(to route: Route, from context: UIViewController, parameters: Any?) {
        switch route {
        case .posterDetail:
            if let params = parameters {
                if let grid = params as? MoviePosterGrid {
                    let vc = Utility.getViewController(ofType: MoviePosterGridDetailViewController.self)
                    vc.setGrid(grid: grid)
                    context.navigationController?.pushViewController(vc, animated: true)
                }
            }
            break
        default:
            break
        }
    }
}
