//CHAPTER 11 STRUCTURES

// Introduction


import UIKit
/*
let restaurantLocation = (2, 4)
let restaurantRange = 2.5

let otherRestaurantLocation = (7, 8)
let otherRestaurantRange = 1.5

// Pythagorean Theorem
func distance(from source: (x: Int, y: Int), to target: (x: Int, y: Int)) -> Double {
    let distanceX = Double(source.x - target.x)
    let distanceY = Double(source.y - target.y)
    return sqrt(distanceX * distanceX + distanceY * distanceY)
}

func isInDeliveryRange(location: (x: Int, y: Int)) -> Bool {
    let deliveryDistance = distance(from: location, to: restaurantLocation)
    let secondDeliveryDistance = distance(from: location, to: otherRestaurantLocation)
    return deliveryDistance < restaurantRange || secondDeliveryDistance < otherRestaurantRange
}

// MARK: My first structure

struct Location {
    let x: Int
    let y: Int
}

let storeLocation = Location(x: 2, y: 4)

struct DeliveryArea {
    var range: Double
    let center: Location
}

var storeArea = DeliveryArea(range: 4, center: storeLocation)

// mini-exercise: make a struct that represent a pizza order

struct pizzaOrder {
    let topping: [String]
    let size: Double
    let doubleCheese: Bool
}

var pizzaForSlava = pizzaOrder(topping: ["meet", "omar", "tomatos", "olive"], size: 1, doubleCheese: true)

// Accessing members

print(storeArea.range)

print(storeArea.center.x)

storeArea.range = 250

var fixedArea = DeliveryArea(range: 4, center: storeLocation)

fixedArea.range = 2.5

// Introducing Methods

let areas = [
    DeliveryArea(range: 2.5, center: Location(x: 2, y: 4)),
    DeliveryArea(range: 4.5, center: Location(x: 9, y: 7))
]

func isInDeliveryRange(_ location: Location) -> Bool {
    for area in areas {
        let distanceToStore = distance(from: (area.center.x, area.center.y), to: (location.x, location.y))
        if distanceToStore < area.range {
            return true
        }
    }
    return false
}

let customerLocation1 = Location(x: 8, y: 1)
let customerLocation2 = Location(x: 5, y: 5)

print(isInDeliveryRange(customerLocation1))
print(isInDeliveryRange(customerLocation2))

struct DeliveryAreaUpdated: CustomStringConvertible {
    var range: Double
    let center: Location
    
    var description: String {
        return "Area with range \(range), location: x: \(center.x) - y: \(center.y)"
    }
    func contains(_ location: Location) -> Bool {
        let distanceFromCenter = distance(from: (center.x, center.y), to: (location.x, location.y))
        return distanceFromCenter < range
    }
    
    func overlap(with: DeliveryArea) -> Bool {
        let distanceFromCenterToCenter = distance(from: (center.x, center.y), to: (with.center.x, with.center.y))
        return distanceFromCenterToCenter < (range + with.range)
    }
}

let area = DeliveryAreaUpdated(range: 4.5, center: Location(x: 5, y: 5))

let customerLocation = Location(x: 2, y:2)

let newArea = DeliveryArea(range: 3, center: Location(x: 15, y: 10))
area.contains(customerLocation)

area.overlap(with: newArea)

// mini exercise : write a method that can tell if area overlaps another area
// DONE in 100 line for struct from 88 line

// Stuctures as values

var a = 5
var b = a

a = 10
b
// = means 'assign', when 'equal to' is ==

var area1 = DeliveryAreaUpdated(range: 2.5, center: Location(x: 2, y: 4))
var area2 = area1

print(area1.range)
print(area2.range)

area1.range = 4
print(area1.range)
print(area2.range)

// area1 and area2 independent; when you assign area2 the value of area1 it gets a COPY of value - value semantics

// Structs everywhere: Int, String, Bool, Array, Dictionary are structs.
/*
public struct Int : SignedInteger, Comparable, Equatable {
    // ...
}
*/
// Conforming to a protocol. We updated DeliveryAreaUpdated on line 88, with a description on line 92

print(area1)
*/
// CHALLENGES 1 tic-tac-toe

typealias BoardPiece = String

let X: BoardPiece = "X"
let O: BoardPiece = "O"



// CHALLENGES 2 Tshirt Struct

struct TShirt: CustomStringConvertible {
    var size: String
    var color: String
    var material: String
    var description: String {
        return("T-Shirt is \(color) color, \(size) size, made from high quality \(material).")
    }
    
    func price() -> Double {
        let standartPrice: Double = 35
        var finalPrice: Double = 35
        let sizeDict = ["XS": 1, "S": 1, "M": 1, "L": 1.25, "XL": 1.5]
        for s in sizeDict.keys {
            if s == size {
                let coefficientSize = sizeDict[s]
                finalPrice = standartPrice * coefficientSize!
            }
        }
        let materialDict = ["wool": 1.3, "cotton": 1]
        for m in materialDict.keys {
            if m == material {
                let coefficientMaterial = materialDict[m]
                finalPrice = finalPrice + standartPrice * (coefficientMaterial! - 1)
            }
        }
        return finalPrice
    }
    
}

var tShirtForSlava = TShirt(size: "L", color: "red", material: "wool")

tShirtForSlava.price()


