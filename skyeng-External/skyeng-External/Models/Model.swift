//
//  Model.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
protocol ModelType {}

// let this take control, instead of Mappable protocol
protocol DecodableModel: ModelType, Decodable {}

struct EmptyDecodableModel: DecodableModel {}
