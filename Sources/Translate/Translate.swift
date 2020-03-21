//
//  Translate.swift
//  Translate
//
//  Created by yosshi4486 on 2020/03/21.
//

import Combine

/// A publisher that translates all elements from the upstream publisher using concrate translator you pass.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Translate<Upstream, Translator> : Publisher where Upstream : Publisher, Translator : TopLevelTranslator, Upstream.Output == Translator.Input {
    
    public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        // Downstream(this) operator calls upstream's receive().
        upstream
            .map({ self.translator.translate(from: $0)} )
            .receive(subscriber: subscriber)
    }
    
    public typealias Output = Translator.Output
    public typealias Failure = Upstream.Failure
    
    /// The publisher from which this publisher receives elements.
    public var upstream: Upstream
    
    /// The translater that translates input type to output type.
    public var translator: Translator
    
    public init(upstream: Upstream, translator: Translator) {
        self.upstream = upstream
        self.translator = translator
    }

}


