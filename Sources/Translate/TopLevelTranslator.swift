//
//  TopLevelTranslator.swift
//  Translate
//
//  Created by yosshi4486 on 2020/03/21.
//

import Foundation

/// A type that defines method for translating.
public protocol TopLevelTranslator {
    
    /// The type this translator accepts.
    associatedtype Input
    
    /// The type this translator output.
    associatedtype Output
    
    /// Translate an instance of the indicated type.
    func translate(from input: Self.Input) -> Output
}
