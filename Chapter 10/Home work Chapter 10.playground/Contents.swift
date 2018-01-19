// Collection Iteration with Closures CHAPTER 10

var multiplyClouser: (Int, Int) -> Int

multiplyClouser = { (a: Int, b: Int) -> Int in
    return a * b
}

let result = multiplyClouser(4, 2)

//Shorthand syntax

multiplyClouser = { (a: Int, b: Int) -> Int in
    a * b
}

multiplyClouser = { (a, b) in
    a * b
}

multiplyClouser = {
    $0 * $1
}

func operateOnNumbers(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
    let result = operation(a, b)
    print(result)
    return result
}

let addClosure = { (a: Int, b: Int) in
    a + b
}

operateOnNumbers(4, 2, operation: addClosure)

operateOnNumbers(4, 2, operation: { (a: Int, b: Int) -> Int in
    return a + b
})

operateOnNumbers(4, 2, operation: { $0 + $1})

operateOnNumbers(4, 2, operation: +)

operateOnNumbers(4, 2) {
    $0 + $1
}

// Closures with no return value

let voidClosure: () -> Void = {
    print("SWIFT!")
}

voidClosure()

// Capturing from the enclosing scope

var counter = 0
let incrementCounter = {
    counter += 1
}

incrementCounter()
incrementCounter()
counter

func countingClosure() -> (() -> Int) {
    var counter = 0
    let incrementCounter: () -> Int = {
        counter += 1
        return counter
    }
    return incrementCounter
}

let counter1 = countingClosure()
let counter2 = countingClosure()

counter1()
counter1()

// Custom sorting with closures

let names = ["ZZZZZ", "BB", "A", "CCCC", "EEEEEE"]

names.sorted()

names.sorted {
    $0.characters.count > $1.characters.count
}

// Iterating over collections with closures

var prices = [1.5, 10, 4.99, 2.3, 8.19]

let largePrices = prices.filter {
    return $0 > 5
}

largePrices

let salePrices = prices.map {
    return $0 * 0.9
}

let sum = prices.reduce(0) {
    return $1 + $0
}

let stock = [1.5:5, 10:2, 4.99:20, 2.3:5, 8.19:30]
let stockSum = stock.reduce(0) {
    return $0 + $1.key * Double($1.value)
}

let removeFirst = prices.dropFirst()
let removeFirstTwo = prices.dropFirst(2)

let dropLastThree = prices.dropLast(3)

let firstTwo = prices.prefix(2)
let lastTwo = prices.suffix(2)

// MINI EXERCISES
// #1

let myNames = ["Slava", "Stas", "Max", "Den"]

let connectNames = myNames.reduce("") {
    $0 + $1
}

//#2

let longNames = myNames.filter {
    $0.characters.count > 3
}

let connectLongNames = longNames.reduce("") {
    $0 + $1
}

//#3
let namesAndAges = ["Slava": 18, "Stas": 32, "Max": 35, "Den": 15]

let namesUnderAge18 = namesAndAges.filter {
    $0.value < 18
}

let namesAdult = namesAndAges.filter {
    $0.value >= 18
}

let onlyNames = namesAdult.map {
    $0.key
}


// CHALANGES A

func repeatTask(times: Int, task: () -> Void) {
    for _ in 0..<times {
        task()
    }
}

repeatTask(times: 10, task: { print("SWIFT!!!") })

// CHALLENGES B

func mathSum(lenght: Int, series: (Int) -> Int) -> Int {
    var sum = 0
    for i in 1...lenght {
        let result = series(i)
        sum += result
    }
    return sum
}

let squareSum = mathSum(lenght: 10) { value in
  return value * value
}

squareSum

let fibonacciSum = mathSum(lenght: 10) { value in
    func fibonacci(_ number: Int) -> Int {
        if number == 0 || number == 1 {
            return number
        }
        return fibonacci(number-1) + fibonacci(number-2)
    }
    return fibonacci(value)
}

fibonacciSum


// CHALLENGE C
import Foundation

let appRating = [
    "Calendar Pro": [1, 5, 5, 4, 2, 1, 5, 4],
    "Messenger": [5, 4, 2, 5, 4, 1, 1, 2],
    "Socialise": [2, 1, 2, 2, 1, 2, 4, 2]
]

var summa: Double = 0

var average: Double = 0

var averageRating = [String: Double]()

appRating.forEach { (key, value) in
    summa = Double(value.reduce(0, +))
    let countNumbers = Double(appRating[key]!.count)
    averageRating[key] = summa/countNumbers
}

averageRating

print(averageRating.filter {$0.value > 3})






