//
//  ContentView.swift
//  Restaurant
//
//  Created by Aruzhan Zhakhan on 17.04.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var restaurant: FetchedResults<Restaurant>
    
    @State private var showingAddView = false
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                List{
                    ForEach(restaurant){
                        restaurant in
                        NavigationLink(destination: EditRestaurantView(restaurant: restaurant)){
                            HStack{
                                VStack(alignment: .leading, spacing: 6){
                                    Text(restaurant.name!).bold()
                                    Text("\(Int(restaurant.rate))") + Text(" rate").foregroundColor(.red)
                                }
                                Spacer()
                                Text(calculateTimeSince(date: restaurant.date!)).foregroundColor(.gray).italic()
                            }
                        }
                    }
                    .onDelete(perform: deleteRestaurant)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Restaurants")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showingAddView.toggle()
                    } label:{
                        Label("Add Restaurant", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView){
                AddRestaurantView()
            }
        }
        .navigationViewStyle(.stack)
    }
    private func deleteRestaurant(offsets: IndexSet){
        withAnimation{
            offsets.map {
                restaurant[$0]
            }.forEach(managedObjectContext.delete)
            DataController().save(context: managedObjectContext)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
