//
//  View+Ex.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 29/11/2024.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
