//
//  ViewController.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import UIKit

class CollectionPhotosViewController: UIViewController {
    var presenter: CollectionPhotosPresenter

    private var collectionView: UICollectionView?
    private let searchBar = UISearchController()
    private var timer: Timer?

    init(presenter: CollectionPhotosPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearch()
        presenter.viewDidLoad()
    }
}

// MARK: Setup UI

extension CollectionPhotosViewController {
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: 200)
        flowLayout.minimumInteritemSpacing = 5.0
        flowLayout.minimumLineSpacing = 5.0

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView?.register(
            CollectionPhotosViewCell.self,
            forCellWithReuseIdentifier: CollectionPhotosViewCell.identifier
        )
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        self.view.addSubview(collectionView ?? UICollectionView())
    }

    private func setupSearch() {
        navigationItem.searchController = searchBar
        searchBar.searchResultsUpdater = self
        searchBar.delegate = self
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.placeholder = "Search..."
    }
}

// MARK: Setup CollectionView

extension CollectionPhotosViewController: UICollectionViewDelegateFlowLayout,
                                            UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photoData.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionPhotosViewCell.identifier,
            for: indexPath
        ) as? CollectionPhotosViewCell,
        let photo = presenter.photoData[safe: indexPath.row] {
            cell.configure(photos: photo)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FullPhotoAssemble.assembleFullPhoto(photo: presenter.photoData, indexPath: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Setup SearchBar

extension CollectionPhotosViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.isEmpty == false {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
                let searchText = searchController.searchBar.text
                self.presenter.searchPhotos(searchText: searchText ?? "")
            }
            )
        } else {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
                self.presenter.showRandomPhotos()
            }
            )
        }
    }
}

// MARK: ViewInput

extension CollectionPhotosViewController: CollectionPhotosViewInput {
    func reloadData() {
        self.collectionView?.reloadData()
    }
}
