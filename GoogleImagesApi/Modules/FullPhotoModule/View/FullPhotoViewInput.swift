//
//  FullPhotoViewInput.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import UIKit

protocol FullPhotoViewInput: AnyObject {
    func configure(photo: Photo)
    func setImage(image: UIImage)
}
