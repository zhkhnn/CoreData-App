//
//  EditRestaurantView.swift
//  Restaurant
//
//  Created by Aruzhan Zhakhan on 18.04.2023.
//

import SwiftUI

struct EditRestaurantView: View {
    @Environment(\.managedObjectContext) var ManagedObjectContext
    @Environment(\.dismiss) var dismiss
    var restaurant: FetchedResults<Restaurant>.Element
    @State private var name = ""
    @State private var rate: Double = 0
    
    var body: some View {
        Form{
            Section{
                TextField("\(restaurant.name!)", text: $name).onAppear{
                    name = restaurant.name!
                    rate = restaurant.rate
                }
                VStack{
                    Text("Rate: \(Int(rate))")
                    Slider(value: $rate, in: 0...10, step: 1)
                }
                .padding()
                HStack{
                    Spacer()
                    Button("Submit"){
                        DataController().editRestaurant(restaurant: restaurant, name: name, rate: rate, context: ManagedObjectContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}


