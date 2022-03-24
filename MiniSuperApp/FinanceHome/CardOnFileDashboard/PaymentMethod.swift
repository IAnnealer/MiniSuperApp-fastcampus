//
//  PaymentModel.swift
//  MiniSuperApp
//
//  Created by Ian on 2022/03/24.
//

import Foundation

struct PaymentMethod: Decodable {
  let id: String
  let name: String
  let digits: String
  let color: String
  let isPrimary: Bool
}
