//
//  GlobalFunctions.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 27/11/2024.
//

import Foundation

func valueOfSecret(named keyname:String) -> String {
    let filePath = Bundle.main.path(forResource: "SecretKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}

func delay(seconds: Int, completion: @escaping () -> Void) async {
    let duration =  UInt64(seconds * 1_000_000_000)
    try? await Task.sleep(nanoseconds: duration)
    DispatchQueue.main.async {
        completion()
    }
}
