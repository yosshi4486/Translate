//
//  Translate.swift
//  Translate
//
//  Created by yosshi4486 on 2020/03/21.
//

import Combine

extension Publishers {
    
    /// A publisher that translates all elements from the upstream publisher with provided translator.
    public struct Translate<Upstream, Translator> : Publisher where Upstream : Publisher, Translator : TopLevelTranslator, Upstream.Output == Translator.Input {
        
        public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            // Downstream operator calls upstream's `receive()`. Connection is established when upstream publisher call `subscriber.receive(subscription: subscription)`.
            upstream
                .map({ self.translator.translate(from: $0)} )
                .subscribe(subscriber)
            
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

}

public extension Publisher {
    
    /// Translates all elements from the upstream publisher with provided translator.
    func translate<Translator>(translator: Translator) -> Publishers.Translate<Self, Translator> where Translator : TopLevelTranslator, Self.Output == Translator.Input {
        Publishers.Translate(upstream: self, translator: translator)
    }

}
