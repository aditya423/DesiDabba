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
    var filteredRestaurants: [Restaurant] = []
    var isSearching: Bool = false
    let viewModel = HomeViewModel()
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        getRestaurantsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: METHODS
    private func setupSearchBar() {
        searchBar.returnKeyType = .done
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName: FileNames.homeTableViewCell.rawValue, bundle: nil),
                         forCellReuseIdentifier: FileNames.homeTableViewCell.rawValue)
    }
    
    private func getRestaurantsList() {
        showLoader()
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

// MARK: IBACTION METHODS
extension HomeViewController {
    @IBAction func searchBtnAction(_ sender: UIButton) {
        searchView.isHidden.toggle()
    }
}

// MARK: SearchBar Delegate Methods
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredRestaurants.removeAll()
        } else {
            isSearching = true
            filteredRestaurants = viewModel.restaurants.filter {
                $0.restaurantName?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        tblView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: TableView Delegate & Datasource Methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredRestaurants.count : viewModel.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FileNames.homeTableViewCell.rawValue, for: indexPath) as! HomeTableViewCell
        cell.setupCell(data: isSearching ? filteredRestaurants[indexPath.row] : viewModel.restaurants[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MenuViewController.loadNib()
        restaurantId = (isSearching ? filteredRestaurants[indexPath.row].restaurantID : viewModel.restaurants[indexPath.row].restaurantID) ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
