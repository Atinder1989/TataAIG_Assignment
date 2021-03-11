//
//  MovieFilterViewController.swift
//  Assignment
//
//  Created by Savleen on 11/03/21.
//

import UIKit

protocol MovieFilterDelegate:NSObjectProtocol {
    func didSelectFilter(filter:Filter)
}

class MovieFilterViewController: UIViewController {
    @IBOutlet weak var filterTableView: UITableView!
    private var filterList:[Filter] = [.highestrated,.mostpopular]
    private weak var delegate: MovieFilterDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.filterTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.filterTableView.tableFooterView = UIView.init()
    }
    
}

//MARK:- Public Methods
extension MovieFilterViewController {
    func setDelegate(delegate: MovieFilterDelegate){
        self.delegate = delegate
    }
}

//MARK:- UITableView Delegate and Datasource
extension MovieFilterViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.filterTableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = filterList[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = self.delegate {
            delegate.didSelectFilter(filter: filterList[indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)
    }
}
