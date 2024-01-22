//
//  FollowerListVC.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 17/1/2024.
//

import UIKit

class FollowerListVC: UIViewController {

    var username : String!
    
    var collectionView: UICollectionView!
    
    // enum is hashable by default
    enum Section {
        case mainSec
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var followers: [Follower]!
    
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
        NetworkManager.shared.getFollowers(for: username, page: 1) {[weak self] result in
            // weak self might be nil
            guard let self = self else { return }
            
            switch result{
                case .success(let followers):
                    self.followers = followers
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
