//
//  LinkPhotoViewInput.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import Foundation

protocol LinkPhotoViewInput: AnyObject {
    func uploadURL(url: URLRequest)
}
