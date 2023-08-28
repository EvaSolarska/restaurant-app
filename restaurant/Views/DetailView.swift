//
//  DetailView.swift
//  restaurant
//
//  Created by Ewa Solarska on 29/08/2023.
//

import SwiftUI

struct DetailView: View {
    @Binding var product: Product?
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                }
                .padding()
            }
            
            Spacer()
            if let data = product?.image, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Spacer()
            Text(product?.name ?? "No name")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("\(String(format: "%.2f", product?.price ?? 0.0)) PLN")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            if let productDescription = product?.desc{
                Text(productDescription)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .navigationTitle("Product details")
    }
}
