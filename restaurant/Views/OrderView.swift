//
//  OrderView.swift
//  restaurant
//
//  Created by Ewa Solarska on 28/08/2023.
//

import SwiftUI

struct OrderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var surname:String = ""
    @State var address: String = ""
    
    @State var refreshKey = UUID()
    @Binding var currentOrder: Order?
    @State var showingAlert = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Order.status, ascending: true)], predicate: NSPredicate(format: "status LIKE %@", "Pending"), animation: .default)
    
    private var orders: FetchedResults<Order>
    
    var validOrder: Bool {
        return !orders.isEmpty && surname.count >= 3 && address.count >= 6
    }
    
    var sortedProducts: [OrderedProduct] {
        return orders.first!.orderedProductArray.sorted {
            $0.toProduct?.name ?? "" < $1.toProduct?.name ?? ""
        }
    }
    
    private func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let product = sortedProducts[index]
            viewContext.delete(product)
        }
        DatabaseService.shared.saveContext(viewContext)
    }
    
    var body: some View {
        NavigationView {
            VStack{
                if orders.first?.orderedProductArray.isEmpty ?? true {
                    Text("Add products to start your order")
                        .font(.headline)
                        .padding()
                }  else {
                    List {
                        Section(header: Text("Ordered products").font(.headline)) {
                            ForEach(sortedProducts, id: \.self.objectID) { orderedProduct in
                                OrderedProductRow(
                                    product: orderedProduct,
                                    onIncrement: {
                                        DatabaseService.shared.incrementQuantity(for: orderedProduct, in: viewContext)
                                        refreshKey = UUID()
                                    },
                                    onDecrement: {
                                        DatabaseService.shared.decrementQuantity(for: orderedProduct, in: viewContext)
                                        refreshKey = UUID()
                                    }
                                )
                            }.onDelete(perform: deleteItem)
                        }
                    }.id(refreshKey)
                        .listStyle(GroupedListStyle())
                    
                    Text("Total cost: \(orders.first!.totalCost, specifier: "%.2f") PLN")
                        .font(.headline)
                    
                    Form{
                        Section(header: Text("Personal information").font(.headline)){
                            TextField("Enter surname", text: $surname)
                            TextField("Enter address", text: $address)
                        }
                    }
                    
                    Button(action: {
                        orders.first!.surname = surname
                        orders.first!.address = address
                        orders.first!.status = "End"
                        
                        let newOrder = Order(context: viewContext)
                        newOrder.status = "Pending"
                        newOrder.date = Date()
                        showingAlert = true
                        do {
                            try viewContext.save()
                            currentOrder = newOrder
                            surname = ""
                            address = ""
                        } catch {
                            print("Error saving order: \(error)")
                        }
                    }) {
                        Text("Order")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(validOrder ? Color.blue : Color.gray)
                            .cornerRadius(40)
                    }.disabled(!validOrder)
                        .padding(.horizontal)
                    
                }
            }    .onAppear {
                refreshKey = UUID()
            }.alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Order submitted"),
                    message: Text("Your order has been successfully placed."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationTitle("Order")
        }
    }
}


