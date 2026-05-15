//
//  ReadinessCard.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 15/05/2026.
//

import SwiftUI

struct ReadinessCard: View {
    let score: Int
    
    private var scoreColor: Color {
        switch score {
        case 80...100: return Color.successColor
        case 50..<80: return Color.warningColor
        default: return Color.errorColor
        }
    }
    
    private var readinessMessage: String {
        switch score {
        case 80...100: return "Ready to Fight!"
        case 50..<80: return "Light Training Today!"
        default: return "Please Regenerate!"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .tmSpacing.medium) {
            Text(verbatim: "Readiness")
                .font(.tmBody)
                .foregroundStyle(Color.secondaryTextColor)
            
            HStack {
                Gauge(value: Double(score), in: 0...100) {
                    EmptyView()
                } currentValueLabel: {
                    Text("\(score)")
                        .font(.tmTitle3)
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .tint(scoreColor)
                .scaleEffect(1.2)
                .padding(.trailing, .tmSpacing.small)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(verbatim: "Status")
                        .font(.tmCaption)
                        .foregroundStyle(Color.tertiaryColor)
                    
                    Text(readinessMessage)
                        .font(.tmCaption)
                        .fontWeight(.medium)
                        .foregroundStyle(scoreColor)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.secondaryColor)
        .clipShape(RoundedRectangle(cornerRadius: .tmSpacing.medium))
    }
}

#Preview("All good!") {
    ReadinessCard(score: 100)
}

#Preview("Normal") {
    ReadinessCard(score: 79)
}
#Preview("TIRED!") {
    ReadinessCard(score: 49)
}
