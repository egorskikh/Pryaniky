//
//  File.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 21.07.2021.
//

import Foundation

protocol PryanikyViewModelType: AnyObject {
    func didTappedView(id: Int?, title: String?)
}

extension PryanikyViewModelType {
    func didTappedView(id: Int? = nil, title: String?) {
        return didTappedView(id: id, title: title)
    }
}



