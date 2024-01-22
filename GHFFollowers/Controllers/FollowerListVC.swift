//
//  FollowerListVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 17/1/2024.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionView()
        getFollowers()
        configureDataSource()
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
                
                self.updateData()
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Request error", message: error.rawValue, buttonTitle: "OK") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
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
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.mainSec])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
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
}
