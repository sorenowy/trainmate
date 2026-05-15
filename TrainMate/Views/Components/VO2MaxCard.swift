//
//  VO2MaxCard.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 15/05/2026.
//

import SwiftUI

struct VO2MaxCard: View {
    let vo2Max: Double
    
    private var fitnessLevel: String {
        switch vo2Max {
        case ..<35: return "Low"
        case 35..<42: return "Moderate"
        case 42..<47: return "Good"
        case 47..<52: return "High"
        default: return "Excellent"
        }
    }
    
    private var levelColor: Color {
        switch vo2Max {
        case ..<35: return Color.errorColor
        case 35..<42: return .warningColor
        case 42..<47: return .successColor
        case 47..<52: return .blue
        default: return .purple
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .tmSpacing.medium) {
            HStack {
                Text(verbatim: "VO2 Max")
                    .font(.tmBody)
                    .foregroundStyle(.secondaryText)
                
                Spacer()
                
                Image(systemName: "lungs.fill")
                    .foregroundStyle(levelColor)
                    .font(.tmCaption)
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text(String(format: "%.1f", vo2Max))
                    .font(.tmTitle1)
                    .foregroundStyle(.primaryText)
                
                Text(verbatim:"ml/kg/min")
                    .font(.tmCaption)
                    .foregroundStyle(.secondaryText)
            }
        }
    }
}

#Preview {
    VO2MaxCard(vo2Max: 41)
}
