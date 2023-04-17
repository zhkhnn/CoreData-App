//
//  DataController.swift
//  Restaurant
//
//  Created by Aruzhan Zhakhan on 17.04.2023.
//

import Foundation
import CoreData
class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "RestaurantModel")
    
    init(){
        container.loadPersistentStores{ desc, error in
            if let error = error{
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data saved")
        }
        catch{
            print("We could not save the data")
        }
    }
    func addRestaurant(name: String, rate: Double, context: NSManagedObjectContext){
        let restaurant = Restaurant(context: context)
        restaurant.id = UUID()
        restaurant.date = Date()
        restaurant.name = name
        restaurant.rate = rate
        
        save(context: context)
    }
    func editRestaurant(restaurant: Restaurant, name: String, rate: Double, context: NSManagedObjectContext){
        restaurant.date = Date()
        restaurant.name = name
        restaurant.rate = rate
        
        save(context: context)
    }
}
