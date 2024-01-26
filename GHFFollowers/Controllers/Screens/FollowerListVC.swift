//
//  FollowerListVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 17/1/2024.
//

import UIKit
protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(username: String)
}
class FollowerListVC: UIViewController {
    
    var username : String!
    
    var currentPage: Int = 1
    var hasMoreFollowers: Bool = true
    
    var collectionView: UICollectionView!
    
    // enum is hashable by default
    enum Section {
        case mainSec
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionView()
        getFollowers()
        configureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func getFollowers() {
        presentLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: currentPage) {[weak self] result in
            // weak self might be nil
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result{
            case .success(let followers):
                if followers.count < 100 {
                    hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "This user doesn't have any followers.", in: self.view)
                    }
                }
                
                self.currentPage+=1
                
                self.updateData(followers: self.followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Request error", message: error.rawValue, buttonTitle: "OK") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    //MARK: - UICollectionView
    private func configureCollectionView(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(for: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        // delegate
        collectionView.delegate = self
    }
    
    private func configureDataSource () {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower)->UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follwer: follower)
            return cell
        })
    }
    
    private func updateData(followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.mainSec])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    //MARK: - UISearchController
    private func configureSearchController (){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
//        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let contentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if contentOffset > (contentHeight - height) {
            // return if there are no more followers
            guard hasMoreFollowers else { return }
            getFollowers()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let array = isSearching ? filteredFollowers : followers
        
        let user = array[indexPath.item]
        
        let userInfoVC = UserInfoVC()
        userInfoVC.followerListVCDelagate = self
        let navi = UINavigationController(rootViewController: userInfoVC)
        userInfoVC.username = user.login

        present(navi, animated: true)
        
    }
    
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { return }
        
        let searchedFollowers = followers.filter { $0.login.lowercased().contains(searchText.lowercased()) }
        
        filteredFollowers = searchedFollowers
        isSearching = true
        
        updateData(followers: searchedFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(followers: self.followers)
        isSearching = false
    }
}

extension FollowerListVC: FollowerListVCDelegate{
    func didRequestFollowers(username: String) {
        
        // reset
        self.username = username
        currentPage = 1
        hasMoreFollowers = true
        isSearching = false
        followers.removeAll()
        filteredFollowers.removeAll()
        title = username
        
        collectionView.setContentOffset(.zero, animated: true) // back to the top
        
        // get data
        getFollowers()
    }
}
