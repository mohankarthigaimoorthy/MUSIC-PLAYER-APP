//
//  restAPI.swift
//  musicPlayer
//
//  Created by Mohan K on 27/01/23.
//

import Foundation

struct restAPI: Decodable {
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
    let id: Int
}

