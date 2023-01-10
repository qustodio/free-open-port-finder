//
//  OS.swift
//  
//
//  Created by Qustodio
//  

import Foundation


internal struct OS {
    #if os(Linux)
    static let close = Glibc.close
    static let bind = Glibc.bind
    #else
    static let close = Darwin.close
    static let bind = Darwin.bind
    #endif
}
