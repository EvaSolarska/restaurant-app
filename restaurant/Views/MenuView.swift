//
//  MenuView.swift
//  restaurant
//
//  Created by Ewa Solarska on 28/08/2023.
//

import SwiftUI

import SwiftUI
import CoreData
struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],animation: .default)
    private var categories: FetchedResults<Category>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],animation: .default)
    private var products: FetchedResults<Product>
    
    @State var selectedCategory: Category?
    @State var selectedProduct: Product?
    
    @State var showingDetail = false
    
    let adaptiveColumns = [ GridItem(.adaptive(minimum: 170)) ]
    
    var body: some View {
        VStack (alignment: .leading){
            Text("The Restaurant")
                .font(.title)
                .bold()
                .padding(.horizontal,10)
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing:15){
                    ForEach(categories){ category in
                        CategoryButton(category: category, selectedCategory: $selectedCategory)
                    }
                }
            }.padding(.horizontal,10)
            ScrollView{
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(products.filter { product in
                        product.toCategory == selectedCategory
                    }) { product in
                        ProductCardView(product: product, selectedProduct: $selectedProduct, showingDetail: $showingDetail)
                    }
                }.padding(.vertical,10)
                    .id(selectedCategory)
                    .sheet(isPresented: $showingDetail) {
                        DetailView(product: $selectedProduct)
                    }
            }
        }.padding(.vertical,16)
            .onAppear{
                DatabaseService.shared.addCategory(context: viewContext)
                DatabaseService.shared.addProducts(context: viewContext, categories: Array(categories))
                selectedCategory = categories.first
            }
    }
}


