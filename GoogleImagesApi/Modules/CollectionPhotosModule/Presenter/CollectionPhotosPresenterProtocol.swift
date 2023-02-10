//
//  CollectionPhotosPresenterProtocol.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import Foundation

protocol CollectionPhotosPresenterProtocol {
    func viewDidLoad()
    func searchPhotos(searchText: String)
    func showRandomPhotos()
}
