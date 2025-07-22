//
//  HomeVC.swift
//  DesiDabba
//
//  Created by Aditya on 22/07/25.
//

import UIKit
import SwiftLoader

class HomeViewController: UIViewController {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    let viewModel = HomeViewModel()
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        getRestaurantsList()
        
    }
    
    // MARK: METHODS
    private func setupSearchBar() {
        searchBar.returnKeyType = .default
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName: FileNames.homeTableViewCell.rawValue, bundle: nil),
                         forCellReuseIdentifier: FileNames.homeTableViewCell.rawValue)
    }
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
        searchView.isHidden.toggle()
    }
    
    private func getRestaurantsList() {
        viewModel.getRestaurantsList(completion: { [weak self] success, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if success != nil {
                    self.tblView.reloadData()
                } else {
                    self.showAlert(title: AlertMessages.error.rawValue, message: error?.localizedDescription ?? AlertMessages.somethingWentWrong.rawValue)
                }
                hideLoader()
            }
        })
    }
}

// MARK: SearchBar Delegate Methods
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: TableView Delegate & Datasource Methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FileNames.homeTableViewCell.rawValue, for: indexPath) as! HomeTableViewCell
        cell.setupCell(data: viewModel.restaurants[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
