//
//  TranslateCollection.swift
//  Translate
//
//  Created by yosshi4486 on 2020/03/27.
//

import Foundation
import Combine

extension Publishers {
    
    /// A publisher that translates all elements that are collection from the upstream publisher with provided translator.
    public struct TranslateCollection<Upstream, Translator> : Publisher where Upstream : Publisher, Translator : TopLevelTranslator, Upstream.Output : Collection, Upstream.Output.Element == Translator.Input {
        
        public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            // Downstream operator calls upstream's `receive()`. Connection is established when upstream publisher call `subscriber.receive(subscription: subscription)`.
            upstream
                .map({ $0.map { self.translator.translate(from: $0) } })
                .subscribe(subscriber)
            
        }
        
        /// The output is collection.
        public typealias Output = [Translator.Output]
        
        /// The failure type is mached to upstream's failure type.
        public typealias Failure = Upstream.Failure
        
        /// The publisher from which this publisher receives elements.
        public var upstream : Upstream
        
        /// The translater that translates input type to output type.
        public var translator : Translator
        
        public init(upstream: Upstream, translator: Translator) {
            self.upstream = upstream
            self.translator = translator
        }

    }

}

extension Publisher {
    
    /// Translates all elements that are collection from the upstream publisher with provided translator.
    func translates<Translator : TopLevelTranslator>(translator: Translator) -> Publishers.TranslateCollection<Self, Translator> where Self.Output : Collection,  Self.Output.Element == Translator.Input {
        Publishers.TranslateCollection(upstream: self, translator: translator)
    }
    
}
