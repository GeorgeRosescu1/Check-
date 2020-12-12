//
//  Product.swift
//  Check✓
//
//  Created by George Rosescu on 11/11/2020.
//

import Foundation
import UIKit

struct Product {
    
    var price: String!
    var name: String!
    var ingrediends: String!
    var image: UIImage!
    
    init(price: String!, name: String!, ingrediends: String!, image: UIImage? = nil) {
        self.price = price
        self.name = name
        self.ingrediends = ingrediends
        self.image = image
    }
}

struct ProductConstants {
    
    struct FStore {
        static let price = "price"
        static let name = "name"
        static let ingrediends = "ingrediends"
    }
}
