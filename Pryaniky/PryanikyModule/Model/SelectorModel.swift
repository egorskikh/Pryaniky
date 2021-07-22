//
//  SelectorModel.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 22.07.2021.
//

import Foundation

struct SelectorModel: Decodable {
    let selectedId: Int
    let variants: [SelectorVariantsModel]
}

struct SelectorVariantsModel: Decodable {
    let id: Int
    let text: String
}
