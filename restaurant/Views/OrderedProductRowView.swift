//
//  OrderedProductRowView.swift
//  restaurant
//
//  Created by Ewa Solarska on 29/08/2023.
//

import SwiftUI

struct OrderedProductRow: View {
    let product: OrderedProduct
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    
    var body: some View {
        HStack{
            Text("\(product.toProduct?.name ?? "")")
            Spacer()
            
            Button(action: onDecrement) {
                Image(systemName: "minus.circle")
                    .foregroundColor(Color.red)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            
            Text("\(product.quantity)")
            
            Button(action: onIncrement) {
                Image(systemName: "plus.circle")
                    .foregroundColor(Color.green)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
