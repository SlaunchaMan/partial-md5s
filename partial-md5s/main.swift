//
//  main.swift
//  partial-md5s
//
//  Created by Jeff Kelley on 5/19/17.
//  Copyright © 2017 Jeff Kelley. All rights reserved.
//

import Foundation
import os

guard let arguments = CommandLine.parseArguments() else {
    Arguments.printUsage()
    exit(EXIT_FAILURE)
}

let inputURL = URL(fileURLWithPath: arguments.inputPath)

if #available(macOS 10.12, *) {
    os_log("Opening file at path %@",
           log: .default,
           type: .info,
           arguments.inputPath)
}

do {
    let data = try Data.init(contentsOf: inputURL, options: .alwaysMapped)
    
    if #available(macOS 10.12, *) {
        os_log("Using chunk size of %{bytes}d",
               log: .default,
               type: .info,
               arguments.chunkSize)
    }
    
    data.withChunks(ofSize: arguments.chunkSize) { subdata in
        print(subdata.md5)
    }
}
catch {
    if #available(macOS 10.12, *) {
        os_log("Error opening file at %@: %@",
               log: .default,
               type: .error,
               arguments.inputPath, error.localizedDescription)
    }
    
    exit(EXIT_FAILURE)
}
