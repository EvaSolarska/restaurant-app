//
//  ContentView.swift
//  restaurant
//
//  Created by Ewa Solarska on 28/08/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var currentOrder: Order?
    
    var body: some View {
        TabView{
            MenuView(currentOrder: $currentOrder).tabItem(){
                Image(systemName: "menucard")
                Text("Menu")
            }
            OrderView(currentOrder: $currentOrder).tabItem(){
                Image(systemName: "basket")
                Text("Order")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
