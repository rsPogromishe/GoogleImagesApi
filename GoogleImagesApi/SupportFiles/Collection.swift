//
//  Collection.swift
//  GoogleImagesApi
//
//  Created by Снытин Ростислав on 09.02.2023.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
