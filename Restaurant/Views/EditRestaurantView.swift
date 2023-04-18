//
//  EditRestaurantView.swift
//  Restaurant
//
//  Created by Aruzhan Zhakhan on 18.04.2023.
//

import SwiftUI

struct EditRestaurantView: View {
    @ObservedObject var userPreferences = UserDefaults()
    @Environment(\.managedObjectContext) var ManagedObjectContext
    @Environment(\.dismiss) var dismiss
    var restaurant: FetchedResults<Restaurant>.Element
    @State private var name = ""
    @State private var rate: Double = 0
    @State private var isDarkModeEnabled = false
    
    var backgroundColor: Color {
            userPreferences.isDarkModeEnabled ? Color(UIColor.gray) : Color(UIColor.systemBackground)
        }
    
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
                    Toggle(isOn: $userPreferences.isDarkModeEnabled) {
                                Text("Dark mode")
                            }
                }
                
//                .onChange(of: userPreferences.isDarkModeEnabled) { newValue in
//                            self.isDarkModeEnabled = newValue
//                        }
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
            .onAppear {
                        self.isDarkModeEnabled = userPreferences.isDarkModeEnabled
                    }
            .background(backgroundColor.ignoresSafeArea())
        }
    }
}
class UserDefaults: ObservableObject{
    private let isDarkModeEnabledKey = "isDarkModeEnabled"
    @Published var isDarkModeEnabled: Bool {
        didSet {
            Foundation.UserDefaults.standard.set(isDarkModeEnabled, forKey: isDarkModeEnabledKey)
        }
    }

    init() {
        self.isDarkModeEnabled = Foundation.UserDefaults.standard.bool(forKey: isDarkModeEnabledKey)
    }
}


