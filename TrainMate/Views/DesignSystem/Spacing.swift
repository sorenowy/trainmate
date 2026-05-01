//
//  Spacing.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 01/05/2026.
//

import Foundation

enum Spacing {
    private static let baseOffset: CGFloat = 4
    
    static let xsmall: CGFloat = baseOffset * 1;
    static let small: CGFloat = baseOffset * 2;
    static let medium: CGFloat = baseOffset * 4;
    static let large: CGFloat = baseOffset * 6;
    static let xlarge: CGFloat = baseOffset * 8;
    static let xxlarge: CGFloat = baseOffset * 12;
}

extension CGFloat {
    static let tmSpacing = Spacing.self
}
