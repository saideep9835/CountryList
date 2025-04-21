//
//  ViewController.swift
//  CountryListProject
//
//  Created by Saideep Reddy Talusani on 4/18/25.
//

import UIKit

final class ViewController: UIViewController {
    private let viewModel = CountryDisplayViewModel(networkClient: NetworkClient.shared)
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private let countriesDisplayTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var searchBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isInSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        return isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        setupAndConfigureTableView()
        fetchCountriesInformaton()
        configureNavigationBarAppearance()
    }
    
    private func fetchCountriesInformaton() {
        Task {
            do {
                try await viewModel.fetchCountries()
                countriesDisplayTableView.reloadData()
            } catch {
                ErrorLogger.logError("Unable to fetch country data.")
            }
        }
    }
    
    private func setupAndConfigureTableView() {
        view.addSubview(countriesDisplayTableView)
        constrainTableView()
        countriesDisplayTableView.dataSource = self
        countriesDisplayTableView.delegate = self
        CountryInfoTableViewCell.register(in: countriesDisplayTableView)
    }
    
    private func constrainTableView() {
        NSLayoutConstraint.activate([
            countriesDisplayTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            countriesDisplayTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            countriesDisplayTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countriesDisplayTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
}

extension ViewController: UISearchBarDelegate {
    private func configureSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Countries"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = isInSearchMode(searchController)
        
        switch inSearchMode {
            case true:
                return viewModel.filteredCountries.count
            case false:
                return viewModel.getCountriesCount()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryInfoTableViewCell.reuseIdentifier, for: indexPath) as? CountryInfoTableViewCell else { return UITableViewCell() }
        
        let inSearchMode = isInSearchMode(searchController)
        
        let currCountry = inSearchMode ? viewModel.filteredCountries[indexPath.row] : viewModel.getCountry(index: indexPath.row)
        let nameAndRegion = viewModel.generateNameAndRegion(country: currCountry)
        let code = viewModel.generateCode(country: currCountry)
        let capital = viewModel.generateCapital(country: currCountry)
        
        cell.configureCell(nameAndRegion: nameAndRegion, code: code, capital: capital)
        return cell
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel.filterCountriesBySearchText(searchBarText: searchBar.text ?? String())
        countriesDisplayTableView.reloadData()
    }
}


