//
//  ImagesListVC.swift
//  Meme-Generator
//
//  Created by Auliya Michelle Adhana on 16/02/24.
//

import UIKit

class MemesListVC: UIViewController {
    
    enum Section {case main}
    
    var memes: [Meme] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Meme>!
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getMemes()
        configureDataSource()
        configureRefresh()
    }
    
    func configureRefresh(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject)
    {
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnLayout(in: view))
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MemeCell.self, forCellWithReuseIdentifier: MemeCell.reuseID)
        view.addSubview(collectionView)
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        title = "MimGenerator"
    }
    
    
    func getMemes(){
        showLoadingView()
        NetworkManager.shared.getMemes{ [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let memes):
                self.memes.append(contentsOf: memes)
                self.updateData(on: self.memes)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Meme>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, meme) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCell.reuseID, for: indexPath) as! MemeCell
            cell.set(meme: meme)
            
            return cell
        })
    }
    
    func updateData(on memes:[Meme]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Meme>()
        snapshot.appendSections([.main])
        snapshot.appendItems(memes)
        DispatchQueue.main.async{self.dataSource.apply(snapshot, animatingDifferences: true)}
    }
    
    
}

extension MemesListVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = memes[indexPath.item]

        let destVC = MemeInfoVC()
        destVC.memeImage = meme.url

        navigationController?.pushViewController(destVC , animated: true)
    }
}


