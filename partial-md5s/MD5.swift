//
//  MD5.swift
//  partial-md5s
//
//  Created by Jeff Kelley on 5/22/17.
//  Copyright © 2017 Jeff Kelley. All rights reserved.
//

import CommonCrypto
import Foundation

extension Data  {
    var md5: String {
        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
        
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = [UInt8](repeating: 0, count: digestLength)
        
        CC_MD5_Init(context)
        
        withUnsafeBytes { bytes -> Void in
            CC_MD5_Update(context, bytes, CC_LONG(self.count))
        }
        
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        
        let hash = (0 ..< digestLength)
            .map { digest[$0] }
            .map { String(format: "%02x", $0) }
            .joined()
        
        return hash
    }
}
