//
//  AddRestaurantView.swift
//  Restaurant
//
//  Created by Aruzhan Zhakhan on 17.04.2023.
//

import SwiftUI

struct AddRestaurantView: View {
    @Environment(\.managedObjectContext) var ManagedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var rate: Double = 0
    var body: some View {
        Form{
            Section{
                TextField("Restaurant name", text: $name)
                VStack{
                    Text("Rate \(Int(rate))")
                    Slider(value: $rate, in: 0...10, step: 1)
                }.padding()
                HStack{
                    Spacer()
                    Button("Submit"){
                        DataController().addRestaurant(name: name, rate: rate, context: ManagedObjectContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AddRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        AddRestaurantView()
    }
}
