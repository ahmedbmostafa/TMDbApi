//
//  Font+App.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 28/11/2024.
//

import SwiftUI

extension Font {
    
    // MARK: - Methods
    
    static func tmdbBlackBold(_ size: CGFloat) -> Font {
        Font.custom("NunitoSans7pt-Black", size: size)
    }
    
    static func tmdbBold(_ size: CGFloat) -> Font {
        Font.custom("NunitoSans7pt-Bold", size: size)
    }
    
    static func tmdbSemiBold(_ size: CGFloat) -> Font {
        Font.custom("NunitoSans7pt-SemiBold", size: size)
    }
    
    static func tmdbRegular(_ size: CGFloat) -> Font {
        Font.custom("NunitoSans7pt-Regular", size: size)
    }
}
