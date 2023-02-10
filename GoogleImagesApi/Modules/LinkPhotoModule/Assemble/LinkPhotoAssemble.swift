//
//  LinkPhotoAssemble.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import UIKit

class LinkPhotoAssemble {
    static func assembleLinkPhoto(newsLink: String) -> UIViewController {
        let presenter = LinkPhotoPresenter()
        let view = LinkPhotoViewController(presenter: presenter)
        view.presenter = presenter
        presenter.view = view
        presenter.sourceLink = newsLink
        return view
    }
}
