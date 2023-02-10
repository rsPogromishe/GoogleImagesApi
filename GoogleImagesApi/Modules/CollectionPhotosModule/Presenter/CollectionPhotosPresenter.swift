//
//  CollectionPhotosPresenter.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import UIKit

class CollectionPhotosPresenter: CollectionPhotosPresenterProtocol {
    weak var view: CollectionPhotosViewInput?

    var photoData: [Photo] = []
    private var randomPhotoData: [Photo] = []

    func viewDidLoad() {
        fetchPhotos()
    }

    func searchPhotos(searchText: String) {
        NetworkManager.shared.fetchData(request: searchText) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photo):
                self.photoData = photo
                self.view?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    func showRandomPhotos() {
        if photoData != randomPhotoData {
            photoData = randomPhotoData
            view?.reloadData()
        }
    }

    private func fetchPhotos() {
        NetworkManager.shared.fetchData(request: "random") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photo):
                self.photoData = photo
                self.randomPhotoData = photo
                self.view?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
