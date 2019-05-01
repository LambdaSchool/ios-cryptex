//
//  Cryptex.swift
//  Cryptex
//
//  Created by Michael Redig on 5/1/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

struct Cryptex: Codable {
	let password: String
	let hint: String
	let time: TimeInterval
}
