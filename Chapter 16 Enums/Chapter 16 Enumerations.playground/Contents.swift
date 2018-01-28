//: ENUMERATIONS
import UIKit
// enumerations is a list of related values that define a common type and let you work with a values in a type-safe way.
// examples of related values : values, colors, roles, directions

// enumerations can have methods and computed properties.

//: My first enumeration

// cistruct a func that will determine the school semester based on the month. One way is to make a array wwith months and match them with semesters using switch

//1 we list out all the months
let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

//2 the function will return the semester to which the month belongs
func semester(for month: String) -> String {
    switch month {
    case "August", "September", "October", "November", "December":
        return "Autumn"
    case "January", "February", "March", "April", "May":
        return "Spring"
    default:
        return "Not in the school year"
    }
}

//3 here is the result, but what is you mistype? it will show error. Here enumerations can help!
semester(for: "April")

// Declaring an enumeration
// to declare an enumeration, you list out all the possible member values as case clause:

enum Month {
    case january
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case decenber
}

// you created new enumeration with 12 possible member values. start each member value with lower case first letter, like property

// you can also simplify the code:

enum Months {
    case january, february, march, april, may, june, july, august, september, october, november, december
    
    var semester: String {
        switch self {
        case .august, .september, .october, .november, .december:
            return "Autumn"
        case .january, .february, .march, .april, .may:
            return "Spring"
        case .june, .july:
            return "Summer"
        }
    }
}

// Deciphering an enum in a function
// you can now rewrite the function semester:
// you can rewomve the enum name because compiler already know the type. (we write Months.january before)
// Also, you can remove the 'default' statement, because enum has limited number of values, wich we can put into the case.
func whatSemester(for month: Months) -> String {
    switch month {
    case .august, .september, .october, .november, .december:
        return "Autumn"
    case .january, .february, .march, .april, .may:
        return "Spring"
    case .june, .july:
        return "Summer"
    }
}

// lets test

var testMonth = Months.april

whatSemester(for: testMonth)

// mini exercise - add computer property to a enum to see the semester - see the line 55

let semester = testMonth.semester  // cool

// Code completion prevents typos

// testMonth = .blabla - it will show an error

// RAW values
// you can associate a raw value with each enumeration case simply by declaring the raw type on the enum name.
// Swift can automaticaly assign values from 0 to n , but in our case it better to start from 1, so we say january = 1, and the rest will be automaticaly numered by +1.
// lets take a look:

enum NewMonth: Int {
    case january = 1, february, march, april, may, june, july, august, september, october, november, december
    var monthsUntilWinterBreak: Int {
        return NewMonth.december.rawValue - self.rawValue
    }
}


// accessing the raw value

func monthsUntilWinterBreak(from month: NewMonth) -> Int {
    return NewMonth.december.rawValue - month.rawValue
}

monthsUntilWinterBreak(from: .april)


// Init with the raw value

let fifthMonth = NewMonth(rawValue: 5) // it returns an optional, because we don't know if 5 is exist

// mini exercise - make func monthsUntilWinterBreak a computed property of NewMonth

let monthApril = NewMonth.april

monthApril.monthsUntilWinterBreak // it works!

// String raw values

//1 the enum with a String raw value
enum Icon: String {
    case music
    case sports
    case weather
    
    var filename: String {
        //2 calling rawValue inside the enum is equivalent to call self.rawValue. Capitalized will return uppercase firdt letter
        return "\(rawValue.capitalized).png"
    }
}

let icon = Icon.weather
icon.filename

// Unordered raw values
// int raw values don't have to be in an incremental order

enum Coin: Int {
    case penny = 1
    case nickel = 5
    case dime = 10
    case quater = 25
}

let coin = Coin.quater

coin.rawValue
coin.hashValue

var coinPurse: [Coin] = []

coinPurse.append(coin)
coinPurse[0].rawValue

//: Associated values

// associated values similar to raw values, but:
// - each enum case has zero or more associated values
// - the associated values for each enum case have their own datatype
// - you define associated values with names like you would for named func parameters
// - enum can have OR associated value OR raw. but NOT BOTH

var balance = 100
func withdraw(amount: Int) {
    balance -= amount
}

enum WithdrawRasult {
    case success(newBalance: Int)
    case error(message: String)
}

// each case has a required value to go along it

// Lets rewrite the func:

func newWithdraw(amount: Int) -> WithdrawRasult {
    if amount <= balance {
        balance -= amount
        return .success(newBalance: balance)
    } else {
        return .error(message: "Not enough money!")
    }
}

let result = newWithdraw(amount: 99)

switch result {
case .success(let newBalance):
    print("Your new balance is \(newBalance)")
case .error(let message):
    print(message)
}
// to access associated values here you need to use LET to read them.

//: Enumeration as a state Machine
// enumeration can be a single value at a time:

enum TrafficLight {
        case red, yellow, green
}

let trafficLight = TrafficLight.red

//: Case-less enum

struct Math {
    static func factorial(of number: Int) -> Int {
        return (1...number).reduce(1, *)
    }
}

let factorial = Math.factorial(of: 6)

let math = Math()

// let math is useless, its better to use enum here rather then func

enum EnumMath {
    static func factorial(of number: Int) -> Int {
        return (1...number).reduce(1, *)
    }
}

let enumFactorial = EnumMath.factorial(of: 6)


//let mathnew = EnumMath() - it will show an error No accessible init!!!


//: Optional
// optional is enumerations!!

//CHALENGE A

enum CoinNew: Int {
    case penny = 1, nickel = 5, dime = 10, quater = 25
}

let coinPurseNew: [Coin] = [.penny, .quater, .nickel, . dime, .penny, .dime, .quater]

func numberOfCentcs(in coinArray: [Coin]) -> Int {
    var sum = 0
    for index in 0..<coinArray.count {
        sum += coinArray[index].rawValue
    }
    return sum
}


let test1 = numberOfCentcs(in: coinPurseNew)

// CHALLENGE B

enum MonthNew: Int {
    case january = 1, february, march, april, may, june, july, august, september, october, november, december
    var monthsUntillNextSummer: Int {
        var result = MonthNew.june.rawValue - self.rawValue
        if result < 0 {
            result += 12
        }
        return result
    }
}

let july = MonthNew.july
july.monthsUntillNextSummer

//CHALLENGE C

enum Direction {
    case north, south, east, west
}

let movements: [Direction] = [.north, .north, .west, .south, .west, .south, .south, .east, .east, .south, .east]


var Location = (x: 0, y:0)



func currentPossition(after movements: [Direction]) -> (x: Int, y: Int) {
    for index in 0..<movements.count {
        switch movements[index].hashValue {
        case 0:
            Location.y += 1
        case 1:
            Location.y -= 1
        case 2:
            Location.x += 1
        case 3:
            Location.x -= 1
        default:
            Location
        }
     }
    return Location
}

let currentLocation = currentPossition(after: movements)

currentLocation.x
currentLocation.y



