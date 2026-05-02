//
//  Typography.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 01/05/2026.
//

import SwiftUI

extension Font {
    // MARK: - Display (Entry View)

    static let tmDisplay = Font.system(.largeTitle, design: .rounded).weight(.black)

    // MARK: - Titles (Titles/Hero)

    static let tmTitle1 = Font.system(.title, design: .rounded).weight(.bold)
    static let tmTitle2 = Font.system(.title2, design: .rounded).weight(.bold)
    static let tmTitle3 = Font.system(.title3, design: .rounded).weight(.semibold)

    // MARK: - Body & Content (Main text, paragraphs)

    static let tmHeadline = Font.system(.headline, design: .rounded).weight(.semibold)
    static let tmBody = Font.system(.body, design: .rounded).weight(.regular)
    static let tmCallout = Font.system(.callout, design: .rounded).weight(.regular)

    // MARK: - Support (data, footer, small text)

    static let tmCaption = Font.system(.caption, design: .rounded).weight(.regular)
    static let tmCaptionSmall = Font.system(.caption2, design: .rounded).weight(.regular)

    // MARK: - Metrics (Numbers/Decimals)

    static let tmMetric = Font.system(.largeTitle, design: .rounded)
        .weight(.black)
        .monospacedDigit()

    static let tmMetricSmall = Font.system(.title, design: .rounded)
        .weight(.heavy)
        .monospacedDigit()
}
