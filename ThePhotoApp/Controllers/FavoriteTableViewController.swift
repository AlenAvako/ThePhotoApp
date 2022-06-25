//
//  FavoriteTableViewController.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 23.06.2022.
//

import UIKit

class FavoriteTableViewController: UIViewController {
    
    private lazy var favoriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: String(describing: FavoriteCell.self))
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteTableView.reloadData()
    }
    
    private func setUpTableView() {
        view.addSubview(favoriteTableView)
        
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        
        NSLayoutConstraint.activate([
            favoriteTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoriteTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            favoriteTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension FavoriteTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteArray.favoriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteCell.self), for: indexPath) as! FavoriteCell
        
        cell.loadedPhoto = FavoriteArray.favoriteArray[indexPath.row]
        
        return cell
    }
    
    
}

extension FavoriteTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = FavoriteArray.favoriteArray[indexPath.row].id
        let viewModel = DetailViewModel(id: id)
        let detailVC = PhotoDetailViewController(viewModel: viewModel)
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }
}
