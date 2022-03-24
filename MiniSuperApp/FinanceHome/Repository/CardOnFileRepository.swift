//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by Ian on 2022/03/24.
//

import Foundation

// 역할: API를 호출하여 User에게 등록된 카드 목록을 가져옴
protocol CardOnFileRepository {
  var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}

// Concreate class
final class CardOnFileRepositoryImp: CardOnFileRepository {

  // 외부에 노출될 read-only property
  var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }

  private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
    PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
    PaymentMethod(id: "1", name: "신한카드", digits: "0987", color: "#3478f6ff", isPrimary: false),
    PaymentMethod(id: "2", name: "현대카드", digits: "8121", color: "#78c5f5ff", isPrimary: false),
    PaymentMethod(id: "3", name: "국민은행", digits: "2812", color: "#65c456ff", isPrimary: false),
    PaymentMethod(id: "4", name: "카카오뱅크", digits: "8751", color: "#ffcc00ff", isPrimary: false)
  ])
}
