//
//  CollectionViewCell.swift
//  Movies
//
//  Created by Marta on 8/3/24.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    static func registerCell(collectionView: UICollectionView) {
        let nib = UINib(nibName: reuseIdentifier(), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier())
    }

    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
