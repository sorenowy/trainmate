//
//  FTPCard.swift
//  TrainMate
//
//  Created by Hubert Kuszyński on 15/05/2026.
//

import SwiftUI

struct FTPCard: View {
    let ftp: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: .tmSpacing.medium) {
            Text("Last FTP")
                .font(.tmBody)
                .foregroundStyle(Color.secondaryTextColor)
            
            HStack(alignment: .firstTextBaseline) {
                Text("\(ftp)")
                    .font(.tmTitle1)
                    .foregroundStyle(Color.primaryTextColor)
                
                Text("W")
                    .font(.tmBody)
                    .foregroundStyle(Color.secondaryTextColor)
                
                HStack {
                    Image(systemName: "bicycle")
                    Text("Orbea / Esker")
                }
                .font(.tmCaption)
                .foregroundStyle(Color.tertiaryColor)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.secondaryColor)
        .clipShape(RoundedRectangle(cornerRadius: .tmSpacing.medium))
    }
}

#Preview {
    FTPCard(ftp: 100)
}
