//
//  AlbumsViewController.swift
//  MyTestTask
//
//  Created by Maksim Malofeev on 29/09/2022.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    // MARK: - Prorerties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        setNavigationBar()
        setupSearchController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Albums"
        navigationItem.searchController = searchController
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    
    @objc func rightBarButtonItemTapped() {
        
    }
}

// MARK: - UITableViewDataSource

extension AlbumsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "record.circle.fill")
        content.imageProperties.preferredSymbolConfiguration = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 70))
        content.imageProperties.reservedLayoutSize = CGSize(width: 60, height: 60)
        content.text = "Text"
        content.secondaryText = "Secondary Text"
        
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 20))
        lable.text = "10 tracks"
        lable.tintColor = .label
        lable.font = .systemFont(ofSize: 12)

        cell.accessoryView = lable
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AlbumsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailViewController =
    }
}

// MARK: - UISearchBarDelegate

extension AlbumsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
    }
}
