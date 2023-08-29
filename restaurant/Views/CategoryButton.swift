//
//  CategoryButton.swift
//  restaurant
//
//  Created by Ewa Solarska on 28/08/2023.
//

import SwiftUI

struct CategoryButton: View {
    let category: Category
    @Binding var selectedCategory: Category?
    
    var body: some View {
        HStack(spacing:10){
            Text(category.name ?? "")
                .bold()
                .foregroundColor(selectedCategory?.name == category.name ? .white : .black)
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(selectedCategory?.name == category.name ? .brown : .gray.opacity(0.08))
        .clipShape(Capsule())
        .onTapGesture {
            withAnimation(.spring()){
                selectedCategory = category
            }
        }
    }
}

