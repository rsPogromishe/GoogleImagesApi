//
//  CollectionPhotoViewCell.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import UIKit

class CollectionPhotosViewCell: UICollectionViewCell {
    static let identifier = "collectionPhotoViewCell"

    private let picture: UIImageView = {
        let picture = UIImageView()
        picture.clipsToBounds = true
        picture.contentMode = .scaleAspectFill
        picture.translatesAutoresizingMaskIntoConstraints = false
        return picture
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        addSubview(picture)

        NSLayoutConstraint.activate([
            picture.rightAnchor.constraint(equalTo: rightAnchor),
            picture.leftAnchor.constraint(equalTo: leftAnchor),
            picture.topAnchor.constraint(equalTo: topAnchor),
            picture.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(photos: Photo) {
        NetworkManager.shared.downloadImage(url: photos.photoUrl) { [weak self] image in
            guard let self = self else { return }
            self.picture.image = image
        }
    }
}
