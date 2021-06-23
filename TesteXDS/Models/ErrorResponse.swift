//
//  ErrorResponse.swift
//  TesteXDS
//
//  Created by Caio Marastoni on 21/06/21.
//

import Foundation

struct ErrorResponse: Decodable, LocalizedError {
    let reason: String
    
    var errorDescription: String? { return reason }
}
