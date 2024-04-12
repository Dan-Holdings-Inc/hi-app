//
//  BackButton.swift
//  Hi
//
//  Created by Yuma on 2024/04/10.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Button(
                action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.backward")
                }
            )
            .tint(.black)
            .padding(.leading)
            Spacer()
        }
    }
}

#Preview {
    BackButton()
}
