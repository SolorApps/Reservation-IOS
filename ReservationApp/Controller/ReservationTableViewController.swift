//
//  ReservationTableiewController.swift
//  ReservationApp
//
//  Created by Erick Manrique on 3/31/18.
//  Copyright © 2018 Erick Manrique. All rights reserved.
//

import UIKit

// decided not to inherit from UITableViewController because this UIViewController allows for easier UI customization in the future
class ReservationTableViewController: UIViewController, UISearchBarDelegate {
    
    // MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    // MARK:- Variables
    let cellId = String(describing: ReservationTableViewCell.self)
    let searchController = UISearchController(searchResultsController: nil)
    var reservations = [Reservation]()
    var filteredReservations = [Reservation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        requestReservations()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Methods
    
    // Method to setup views
    func setupViews() {
        // Setup the Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a Reservation"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        
        // Setup Navigation Bar
        navigationController?.navigationBar.topItem?.title = "Reservations"
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ReservationTableViewController.addReservation(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshData(notification:)), name: Notification.Name.init(rawValue: "refreshData"), object: nil)
        
        
    }
    
    @objc func addReservation(_ sender: UIBarButtonItem) {
        let viewController = ReservationCreateViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func requestReservations() {
        activityIndicatorView.startAnimating()
        Service.shared.getReservations { (reservations, error) in
            DispatchQueue.main.async { [weak self] in
                if error != nil {
                    self?.activityIndicatorView.stopAnimating()
                } else {
                    if let reservations = reservations {
                        self?.reservations = reservations
                        self?.activityIndicatorView.stopAnimating()
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    // Notification Reloading view
    @objc func refreshData(notification: Notification){
        if let userInfo = notification.userInfo as? [String: Reservation] {
            if let reservation = userInfo["reservation"] {
                self.reservations.append(reservation)
                let indexPath = IndexPath(row: reservations.count-1, section: 0)
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
            }
        } else {
            Alert.showBasic(title: "No Data", message: "No data was received", vc: self)
        }
    }
    
    // MARK:- Filter methods
    func filterContentForSearchText(searchText: String) {
        filteredReservations = reservations.filter({( reservation : Reservation) -> Bool in
            return (reservation.fullName?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && (!isSearchBarEmpty())
    }

}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension ReservationTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredReservations.count
        }
        return reservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! ReservationTableViewCell
        let reservation: Reservation
        if isFiltering() {
            reservation = filteredReservations[indexPath.row]
        } else {
            reservation = reservations[indexPath.row]
        }
        // add model data to cell
        cell.fullNameLabel.text = reservation.fullName
        cell.phoneNumberLabel.text = reservation.phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reservationViewController = ReservationViewController()
        let reservation: Reservation
        if isFiltering() {
            reservation = filteredReservations[indexPath.row]
        } else {
            reservation = reservations[indexPath.row]
        }
        // pass data to reservation controller
        reservationViewController.reservation = reservation
        navigationController?.pushViewController(reservationViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let id = reservations[indexPath.row]._id {
                Service.shared.deleteReservation(with: id, completion: { (message, error) in
                    DispatchQueue.main.async { [weak self] in
                        if error != nil {
                            Alert.showBasic(title: "No Data", message: "No data was received", vc: self!)
                        } else {
                            self?.reservations.remove(at: indexPath.row)
                            self?.tableView.beginUpdates()
                            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                            self?.tableView.endUpdates()
                        }
                    }
                })
            }
        }
    }
    
}

// MARK: - UISearchResultsUpdating Delegate
extension ReservationTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
