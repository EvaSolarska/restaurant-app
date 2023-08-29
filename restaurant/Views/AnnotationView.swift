//
//  AnnotationView.swift
//  restaurant
//
//  Created by Ewa Solarska on 29/08/2023.
//

import SwiftUI

struct AnnotationView: View {
    var title: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "mappin.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
                .shadow(radius: 4)
            Text(title)
                .font(.caption)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                )
                .shadow(radius: 4)
        }
        .padding()
    }
}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView(title: "Example")
    }
}
