//
//  FullPhotoAssemble.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import UIKit

class FullPhotoAssemble {
    static func assembleFullPhoto(
        photo: [Photo],
        indexPath: Int
    ) -> UIViewController {
        let presenter = FullPhotoPresenter()
        let view = FullPhotoViewController(presenter: presenter)
        view.presenter = presenter
        presenter.view = view
        presenter.photo = photo
        presenter.indexPath = indexPath
        return view
    }
}
