//
//  CollectionPhotosAssemble.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import UIKit

class CollectionPhotosAssemble {
    static func assembleCollectionPhotosModule() -> UIViewController {
        let presenter = CollectionPhotosPresenter()
        let view = CollectionPhotosViewController(presenter: presenter)
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
