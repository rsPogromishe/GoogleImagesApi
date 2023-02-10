//
//  FullPhotoPresenter.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import Foundation

enum ShowImage {
    case previous
    case next
}
class FullPhotoPresenter: FullPhotoPresenterProtocol {
    weak var view: FullPhotoViewInput?
    var photo: [Photo] = []
    var indexPath: Int = 0

    func viewDidLoad() {
        view?.configure(photo: photo[indexPath])
        uploadImage()
    }

    func showImage(choose: ShowImage) {
        switch choose {
        case .previous:
            if indexPath != 0 {
                indexPath -= 1
                view?.configure(photo: photo[indexPath])
                uploadImage()
            }
        case .next:
            if (photo.count - 1) > indexPath {
                indexPath += 1
                view?.configure(photo: photo[indexPath])
                uploadImage()
            }
        }
    }

    private func uploadImage() {
        NetworkManager.shared.downloadImage(url: photo[indexPath].photoUrl) { [weak self] image in
            guard let self = self else { return }
            self.view?.setImage(image: image)
        }
    }
}
