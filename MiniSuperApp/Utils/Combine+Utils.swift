//
//  Combine+Utils.swift
//  MiniSuperApp
//
//  Created by Ian on 2022/03/17.
//

import Combine
import CombineExt
import Foundation

public class ReadOnlyCurrentValuePublisher<Element>: Publisher {

  public typealias Output = Element
  public typealias Failure = Never

  public var value: Element {
    currentValueRelay.value
  }

  fileprivate let currentValueRelay: CurrentValueRelay<Output>

  fileprivate init(_ initialValue: Element) {
    currentValueRelay = CurrentValueRelay(initialValue)
  }

  public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Element == S.Input {
    currentValueRelay.receive(subscriber: subscriber)
  }
}

public final class CurrentValuePublisher<Element>: ReadOnlyCurrentValuePublisher<Element> {

  typealias Output = Element
  typealias Failure = Never

  override init(_ initialValue: Element) {
    super.init(initialValue)
  }

  public func send(_ value: Element) {
    currentValueRelay.accept(value)
  }
}
