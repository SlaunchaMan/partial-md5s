//
//  Arguments.swift
//  partial-md5s
//
//  Created by Jeff Kelley on 5/22/17.
//  Copyright © 2017 Jeff Kelley. All rights reserved.
//

import Foundation

let DefaultChunkSize = 50_000_000

struct Arguments {
    let inputPath: String
    let chunkSize: Int
    
    init(inputPath: String, chunkSize: Int?) {
        self.inputPath = inputPath
        self.chunkSize = chunkSize ?? DefaultChunkSize
    }
    
    static func printUsage() {
        print("Usage:")
        print("\t-i <input file>")
        print("\t-s <chunk size in bytes> - Optional, defaults to 50 MB")
    }
}

extension CommandLine {
    static func parseArguments() -> Arguments? {
        guard let inputIndex = arguments.index(of: "-i"),
            arguments.count > inputIndex + 1
            else { return nil }
        
        let inputPath = arguments[arguments.index(after: inputIndex)]
        
        var chunkSize: Int? = nil
        
        if let chunkSizeIndex = arguments.index(of: "-s"),
            arguments.count > chunkSizeIndex + 1,
            let size = Int(arguments[arguments.index(after: chunkSizeIndex)]) {
            chunkSize = size
        }
        
        return Arguments(inputPath: inputPath, chunkSize: chunkSize)
    }
}
