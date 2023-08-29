//
//  ProductCardView.swift
//  restaurant
//
//  Created by Ewa Solarska on 28/08/2023.
//

import SwiftUI

struct ProductCardView: View {
    let product: Product
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var selectedProduct: Product?
    @Binding var showingDetail: Bool
    @Binding var currentOrder: Order?
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Order.status, ascending: true)],animation: .default)
    private var orders: FetchedResults<Order>
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
                    if currentOrder == nil {
                        if let pendingOrder = orders.first(where: { $0.status == "Pending" }) {
                            currentOrder = pendingOrder
                        } else {
                            currentOrder = DatabaseService.shared.createOrder(in: viewContext)
                        }
                    }
                    if let currentOrder = currentOrder {
                        DatabaseService.shared.addToOrder(product: product, order: currentOrder, in: viewContext)
                    }
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
                showingDetail = true
            }
            .padding(.horizontal, 10)
        }
    }
}

