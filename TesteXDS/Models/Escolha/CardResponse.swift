//
//  CardResponse.swift
//  TesteXDS
//
//  Created by Caio Marastoni on 21/06/21.
//

import Foundation

struct CardResponse: Decodable {
    let id: String
    let name: String
    let imageUrl: String
    let rating: Double
    let priceP: Double
    let priceM: Double
    let priceG: Double
}
