//
//  ErrOut.swift
//  partial-md5s
//
//  Created by Jeff Kelley on 5/22/17.
//  Copyright © 2017 Jeff Kelley. All rights reserved.
//

import Foundation

var standardError = FileHandle.standardError

extension FileHandle: TextOutputStream {
    public func write(_ string: String) {
        guard let data = string.data(using: .utf8) else { return }
        write(data)
    }
}
