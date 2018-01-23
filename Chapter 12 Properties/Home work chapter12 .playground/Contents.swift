//:CHAPTER 12 Properties


import UIKit

struct Car {
    let make: String
    let color: String
}
// values make and color are stored properties - they store string values

// there are also computed properties - they calculate values, not store them

//: Stored properties

struct Contact {
    var fullName: String
    var emailAddress: String
    var type = "Frieand"
}

var person = Contact(fullName: "Grace", emailAddress: "grace@navy.mil", type: "Friend")

let name = person.fullName
let email = person.emailAddress

person.fullName = "Grace Hopper"

let grace = person.fullName

// if you don't want properties to be changed use 'let' instead of 'var'

//: Default values
// we are adding var type = "Friend"

//: Computed values
// computer values must be declared as variables and include a type
// this is read only computed property - getter

struct TV {
    var height: Double
    var width: Double
    
    //1 use curly braces to enclose your computed property’s calculation
    var diagonal: Int {
        //2 use the Pythagorean theorem to calculate the width of the diagonal.
        let result = sqrt(height * height + width * width)
        //3 use the rounded(_:) method to round the value with the standard rule: If it the decimal is 0.5 or above, it rounds up; otherwise it rounds down.
        let roundedResult = result.rounded()
        //4 return it as an Int.
        return Int(roundedResult)
    }
}

var tv = TV(height: 53.93, width: 95.87)

let size = tv.diagonal

tv.width = tv.height

let diagonal = tv.diagonal


//: Getter and setter
// now we will write a read-write computed property. it include getter and setter

struct TV2 {
    var height: Double
    var width: Double
    
    var diagonalTwo: Int {
        //1 you want to include setter, you should use getter
        get {
            //2 use the same cod as for TV struct to get a computed value
            let result = sqrt(height * height + width * width)
            let roundedResult = result.rounded(.toNearestOrAwayFromZero)
            return Int(roundedResult)
        }
        set {
            //3 for setter we need assumption, in this case we provide default value
            let ratioWidth = 16.0
            let ratioHeight = 9.0
            //4 formulas to calculate height and width. newValue constant lets you use any value that passed during the assignment. the new value is getting from get. so we transform it to Double (the diagonal is Int)
            height = Double(newValue) * ratioHeight / sqrt(ratioHeight * ratioHeight + ratioWidth * ratioWidth)
            width = height * ratioWidth / ratioHeight
        }
    }
}

var tv2 = TV2(height: 53.93, width: 95.87)

// now we can set the diagonal, and calculate the height and width. In this case screen ration is 16:9
tv2.diagonalTwo = 100

let height = tv2.height
let width = tv2.width

//:Type properties
// imagine we build a game with lots of levels
// you declare a type property using static for value based types like structures. use it to store game's progress
struct Level {
    static var highestLevel = 1
    let id: Int
    var boss: String
    var unlocked: Bool
}

let level1 = Level(id: 1, boss: "Chameleon", unlocked: true)
let level2 = Level(id: 2, boss: "Squid", unlocked: false)
let level3 = Level(id: 3, boss: "Chupacabra", unlocked: false)
let level4 = Level(id: 4, boss: "Yeti", unlocked: false)

//the highestLevel property on Level is a property itself - you don't access a type property
// this will give an error: you can't access type property:
//let highestLevel = level3.highestLevel
// BUT you can access it on the type ITSELF

let highestLevel = Level.highestLevel

// it means that you can retrieve the same stored property value from anywhere in code.

//: Property observers
// property observers called before and after property changes. use willSet and didSet like set and get before.
struct Level2 {
    static var highestLevel = 1
    let id: Int
    let boss: String
    var unlocked: Bool {
        didSet {
            if unlocked && id > Level.highestLevel {
                Level.highestLevel = id
            }
        }
    }
}
// now when player unlock new level it will update the highestLevel value.
// didSet called AFTER the value has been set.
// inside the instance of a type you need to acsess  the properties with a full name like Level.fullnameOfTheProperty
// willSet and didSet called only when a new value is being assigned. It usefull only for Variables.



//: Limiting a variable

// use property observers to limit the value of variable

struct LightBulb {
    static let maxCurrent = 40
    var current = 0 {
        didSet {
            if current > LightBulb.maxCurrent {
                print("current too high, falling back to previous setting")
                current = oldValue
            }
        }
    }
}

// use oldValue to access previous value and newValue to access new value

var light = LightBulb()
light.current = 50
var current = light.current
light.current = 40
current = light.current
light.current = 30
current = light.current

light.current = 60
current = light.current



// MINI exercise

struct SmartBulb {
    static let maxCurrent = 40
    var current: Int? = 0 {
        willSet {
            if newValue! > SmartBulb.maxCurrent {
                print("current too high, turning OFF!")
            }
        }
        didSet {
            if current! > SmartBulb.maxCurrent {
                current = nil
            }
        }
    }
}


var smart = SmartBulb()
smart.current = 15

var currentTest = smart.current

smart.current = 45

currentTest = smart.current

//: Lazy properties

// you can call the property when you actually need it - lazy stored properties

struct Circle {
    lazy var pi = {
        return ((4.0 * atan(1.0 / 5.0)) - atan(1.0 / 239.0)) * 4.0
    }()
    var radius = 0.0
    var circumference: Double {
        mutating get {  // mutating - it changes the value of the struct
            return pi * radius * 2
        }
    }
    init (radius: Double) {
        self.radius = radius
    }
}

// here we want to calculate a value of pi by ourself

var circle = Circle(radius: 5) // got circle, pi has not been run

// the calculation of pi waits until some code needs it.
let circumference = circle.circumference // also, pi now has a value

// pi uses {}() pattern to calculate its value because it marked as lazy. it must be declared as variable, because it has no value when you create struct.


//: KEY POINTS
// - Properties are variables and costants that are part of named type
// - Stored properties allocate memory to store a value
// - Computed properties are calculated each time you code requests tham amd aren't stored as a value in memory
// - The 'static' keyword marks a type property that's universal to all instances of a particular type
// - the 'lazy' keyword prevents a value of a stored property from being calculated until your code uses it for the first time. Use laze initialization.

//: CHALLENGES
// A
// make default values
struct IceCreamDefault {
    let name = "Chocolate Plombir"
    let ingredients = ["milk", "cream", "sugar", "cocoa"]
}

let test = IceCreamDefault()

print(test.name)
// initialise lazy ingredients

struct IceCreamLazy {
    let name = "Chocolate Plombir"
    lazy var ingredients: [String] = {
        self.ingredients = ["milk", "sugar", "cream", "cocoa"]
        return self.ingredients
    }()
}

var test2 = IceCreamLazy()

print(test2)

test2.ingredients

// B

struct FuelTank {
    static let maxLevel = 1.0
    static let minLevel = 0.0
    var level: Double = 0.0 {
        didSet {
            if level < FuelTank.minLevel || level > FuelTank.maxLevel {
                print("the range of Fuel level must be between \(FuelTank.minLevel) and \(FuelTank.maxLevel). Please Change your level")
                level = oldValue
            }
        }
    }
    var lowFuel: Bool {
        if level < 0.1 {
            return true
        } else {
            return false
        }
    }
}

var myCarFuelTank = FuelTank()

myCarFuelTank.level

//myCarFuelTank.level = 1.5

myCarFuelTank.level = 0.05

var fillTank = myCarFuelTank.lowFuel

myCarFuelTank.level = 0.5

fillTank = myCarFuelTank.lowFuel








