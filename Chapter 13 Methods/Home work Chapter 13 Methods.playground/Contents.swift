//: METHODS

//: Method refresher

var numbers = [1, 2, 3]
numbers.removeLast()
let newArray = numbers
// methods like removeLast() help you to control the data in the structure

// Comparing methods to computed properties
// properties hold values that you can get and set, Methods perform work.
// methods uses to call expensive in time and computational resources, copmuted properties is for easier operations.

// Turning a function into the method

let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
struct SimpleDate {
    var month: String
    func monthsUntilWinterBreak(from date: SimpleDate) -> Int {
        return months.index(of: "December")! - months.index(of: date.month)!
    }
}

let date = SimpleDate(month: "October")

let monthsLeft = date.monthsUntilWinterBreak(from: date)

//there must be a way to access the content stored by the instance instead of passing the instance irsalf as a parametr to the method.

// Intoducing self
// to access the value of an instance you use 'self.' inside the structure
struct SimpleDateUsingSelf {
    var month: String
    // 1 now there is no parameter in the method definition
    func monthsUntilWinterBreak() -> Int {
        // 2 in the implementation 'self' replaces the old parameter name
        return months.index(of: "December")! - months.index(of: self.month)!
    }
}

let dateUsingSelf = SimpleDateUsingSelf(month: "October")

let leftMonths = dateUsingSelf.monthsUntilWinterBreak()

// use 'self' only when it is required, to disambiguate between a local variable and a property with the same name

//MINI exercise
//Transform the method into a computed property with a getter

struct SimpleDateComputedProperty {
    var month: String
    // 1 declare computed property
    var monthsToBreak: Int {
        // 2 in the implementation we removed 'self' because there is no need in it in this case
        return months.index(of: "December")! - months.index(of: month)!
    }
}

let dateTest = SimpleDateComputedProperty(month: "October")

let monthsLeftTest = dateTest.monthsToBreak

// Introducing initializers

// initializers is a special methods to create a new instance. They omit the 'func' keyword, name; use simply 'init' . It can have parameters but doesn't have to

let dateNew = SimpleDateUsingSelf(month: "January")

struct SimpleDateInit {
    var month: String
    //1 the init() don't requires func keyword or name. Always use the name of the type to call it
    //2 init always must have a parameter list, even if it empty
    //3 in 'init' you assign values for all the stored properties of the structure
    //4 'init' never returns a value. Its task is simply to initialize a new instance
    init() {
        month = "January"
    }
    func monthsUntilWinterBreak() -> Int {
        return months.index(of: "December")! - months.index(of: month)!
    }
}

let dateInit = SimpleDateInit()

let month = dateInit.month
let monthsLeftAgain = dateInit.monthsUntilWinterBreak()
// in future you can set init to use a default value on today's date from a Foundation library

// Initializers in structures

// init ensure all properties are set before the instance is ready to use

struct newSimpleDate {
    var month: String
    var day: Int
    
    init() {
        month = "March"
        day = 1
    }
}
// here init works as default values for month and day and we can't change them like so:
// let test = newSimpleDate(month: "February", day: 14)
// we have to re-write the init and define our own initializer with parameters

struct oneMoreSimpleDate {
    var month: String
    var day: Int
    
    init(month: String, day: Int) {
        self.month = month
        self.day = day
    }
    
    mutating func advance() {
        day += 1
    }
}

//Introducing mutating methods
// methods can't change the values of the instance without being marked as 'mutating' - it changes the value of the struct, but only for var propertues, not for let
// see the previous struct on line 106

// Type methods
// you can use type methods to access data across all instances. Use 'static' to declare type method
// use type methods for things that are about a type in general , rather than something about specific anstaces

// you can use type method to group similar methods

struct Math {
    //1 use 'static' to declare the type method, with accepts Int and return Int
    static func factorial(of number: Int) -> Int {
        //2 implementation uses higher-order function 'reduce' you can write it using 'for loop' but 'reduce' allows to intent in a cleaner way
        return (1...number).reduce(1, *)
    }
}
//3 you call the type method on Math, rather than on instance of the type
let factorial = Math.factorial(of: 6)

// MARK:  MINI exrcise

struct NewMath {
    static func factorial(of number: Int) -> Int {
        return (1...number).reduce(1, *)
    }
    static func triangleNumbers(of number: Int) -> Int {
        return number * (number + 1) / 2
    }
}

let triangleNumbers = NewMath.triangleNumbers(of: 60)

//: Adding to an existing structure with extensions

extension Math {
    static func primeFactors(of value: Int) -> [Int] {
        //1 the value passed in as a parameter is assigned to the var. it can be changed as a calculation runs
        var remainingValue = value
        //2 the testFactor starts as two and will be devided into remainigValue
        var testFactor = 2
        var primes: [Int] = []
        //3 runs a loop
        while testFactor * testFactor <= remainingValue {
            if remainingValue % testFactor == 0 {
                primes.append(testFactor)
                remainingValue /= testFactor
            }
            else {
                testFactor += 1
            }
        }
        if remainingValue > 1 {
            primes.append(remainingValue)
        }
        return primes
    }
}

// you now add a new type methid to a structure, but you can't extend struct with stored properties, because in needs memory.

let megaTest = Math.primeFactors(of: 81)


// Keeping the compiler generated initializer using extensions

struct Date {
    var month: String
    var day: Int
}

extension Date {
    init() {
        month = "march"
        day = 1
    }
}

let defaultDay = Date()
let childrensDay = Date(month: "May", day: 5)

//: KEY POINTs
// CHALENGE
//1 write method that can change the instance of area by growth factor.

struct Circle {
    var radius = 0.0
    
    var area: Double {
       return .pi * radius * radius
    }
    
    init (radius: Double) {
    self.radius = radius
    }
    mutating func grow(byFactor: Double) -> Double {
        return area * 3
    }
}

var circle = Circle(radius: 2)

let area = circle.area
let grow = circle.grow(byFactor: 3)
// в этом задании есть подсказка, использовать setter для area. Но  не пойму зачем, надо обсудить.


// 2 rewrite advance() in DateCalc struct to account for advancing from Dec 31st to Jan 1st

struct DateCalc {
    
    var month: String
    var day: Int
    
    init(month: String, day: Int) {
        self.month = month
        self.day = day
    }
    mutating func advance() {
        //let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        
        return day += 1
    }
}

var current = DateCalc(month: "January", day: 31)
current.advance()
//let currentMonth = current.month
//let currentDay = current.day


//3 add type method to Math struct called isEven and isOdd that return true or false if the number is even or odd

extension Math {
    static func isOdd(number: Int) -> Bool {
        if number % 2 == 0 {
            return false
        }
        return true
    }
    static func isEven(number: Int) -> Bool {
        if number % 2 == 0 {
            return true
        }
        return false
    }
}

let odd = Math.isOdd(number: 155)
let even = Math.isEven(number: 154)

// 4 надо изменить страктуру Int в библиотеке как в предыдущем задании с Math - стремаюсь делать
// 5 опять просят изменить стандартную библиотеку, тоже не буду, добавить метод который уже я писал, смысл просто добавить, тоже стремаюсь...





