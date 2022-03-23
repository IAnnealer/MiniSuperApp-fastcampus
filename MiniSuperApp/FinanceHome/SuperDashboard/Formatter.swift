//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by Ian on 2022/03/24.
//

import Foundation

struct Formatter {
  static let balanceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }()
}
