//
//  PinterestModel.swift
//  CustomCollectionViewLayout
//
//  Created by SaiKiran Panuganti on 23/10/21.
//

import Foundation

// MARK: - ConfigData
struct PinterestModel: Codable {
    let statusCode: Int?
    let body: [PinterestData]?
}

// MARK: - Body
struct PinterestData: Codable {
    let imgURL: String
    let width, height: Int

    enum CodingKeys: String, CodingKey {
        case imgURL = "imgUrl"
        case width, height
    }
}
