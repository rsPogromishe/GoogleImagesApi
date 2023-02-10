//
//  Image.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import Foundation

struct Photo: Codable, Equatable {
    let photoUrl: String
    let originalLink: String

    init?(photoData: ImagesResult) {
        photoUrl = photoData.thumbnail ?? ""
        originalLink = photoData.link ?? ""
    }
}
