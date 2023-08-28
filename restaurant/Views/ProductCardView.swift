//
//  ProductCardView.swift
//  restaurant
//
//  Created by Ewa Solarska on 28/08/2023.
//

import SwiftUI

import SwiftUI

struct ProductCardView: View {
    let product: Product
    @Binding var selectedProduct: Product?
    
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(width:170, height: 270)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)

            VStack{
                VStack(alignment: .center, spacing: 10){
                    Image(uiImage: UIImage(data: product.image!)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding(.top, 10)

                    Text(product.name ?? "")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("\(String(format: "%.2f", product.price)) PLN")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()
                Button(action: {
                    
                }){
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .frame(width: 30,height: 30)
                        .background(Color.red)
                        .clipShape(Circle())
                        .padding(.bottom, 10)
                }

            } .onLongPressGesture {
                selectedProduct = product
            }
            .padding(.horizontal, 10)
        }
    }
}

