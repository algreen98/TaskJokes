//
//  APIManager.swift
//  TaskJokes
//
//  Created by mac on 23.01.2021.
//

import Foundation

struct APIManager: Decodable {
    let type: String
    var value: [Value]
}

struct Value: Decodable {
    var id: Int
    var joke: String
}
