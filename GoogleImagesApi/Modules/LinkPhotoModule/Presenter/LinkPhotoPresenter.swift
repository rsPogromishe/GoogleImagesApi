//
//  LinkPhotoPresenter.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import Foundation

class LinkPhotoPresenter: LinkPhotoPresenterProtocol {
    weak var view: LinkPhotoViewInput?

    var sourceLink: String = ""

    func viewDidLoad() {
        guard let url = URL(string: sourceLink) else { return }
        let urlRequest = URLRequest(url: url)
        self.view?.uploadURL(url: urlRequest)
    }
}
