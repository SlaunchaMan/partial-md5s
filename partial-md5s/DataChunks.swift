//
//  DataChunks.swift
//  partial-md5s
//
//  Created by Jeff Kelley on 5/22/17.
//  Copyright © 2017 Jeff Kelley. All rights reserved.
//

import Foundation

extension Data {
    func withChunks(ofSize size: Int, execute block: ((Data) -> Void)) {
        for offset in stride(from: 0, to: count, by: size) {
            let maxRange = Swift.min(count, offset + size)
            block(subdata(in: offset ..< maxRange))
        }
    }
}
