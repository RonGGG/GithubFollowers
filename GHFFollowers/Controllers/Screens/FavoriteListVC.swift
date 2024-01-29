//
//  FavoriteListVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 16/1/2024.
//

import UIKit

class FavoriteListVC: UIViewController {

    var favorites: [Follower] = []
    
    var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favorites"
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    private func getFavorites(){
        PersistenceManager.retrieveFavorites {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.favorites = favorites
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Request error", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func configureTableView(){
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

//extension FavoriteListVC: UITableViewDelegate {}
extension FavoriteListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as? FavoriteCell else {
            fatalError("unable to downcast to FavoriteCell")
        }
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let username = favorites[indexPath.row].login
        let destVC = FollowerListVC(username: username)
        navigationController?.pushViewController(destVC, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = favorites[indexPath.row]
        
        let action = UIContextualAction(style: .destructive, title: "Delete") {[weak self] action, view, handler in
            
            guard let self = self else { return }
            
            // delete from databse
            PersistenceManager.update(favorite: favorite, type: .remove) {[weak self] error in
                
                guard let self = self else { return }
                
                if let errorSafe = error {
                    self.presentGFAlertOnMainThread(title: "Request issue", message: errorSafe.rawValue, buttonTitle: "OK")
                    return
                }
                
                DispatchQueue.main.async {
                    // delete from array
                    self.favorites.remove(at: indexPath.row)
                    
                    /* reload tableview
                     Dont have to call tableView.reloadData()
                    */
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    
                    handler(true)
                }
            }
            
        }
        let config = UISwipeActionsConfiguration(actions: [action])
//        config.performsFirstActionWithFullSwipe = true
        return config
    }
    
}
