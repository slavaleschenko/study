//: ADVANCED CLASSES

// introducing inheritance (наследие)

struct Grade {
    let letter: String
    let points: Double
    let credits: Double
}

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

class Student {
    var firstName: String
    var lastName: String
    var grades: [Grade] = []
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

// we can see there is a lot of redundancy between Person and Student. Student is a Person!
// lets represent same relations in code:

class NewPerson {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

class NewStudent: NewPerson {
    var grades: [Grade] = []
    
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
    }
}
// in this example Student now INHERITS from Person. Now the student is really a person. Student gets the properties, init and methods declared in Person

let john = NewPerson(firstName: "Johnny", lastName: "Appleseed")
let jane = NewStudent(firstName: "Jane", lastName: "Appleseed")

john.firstName
jane.firstName

let history = Grade(letter: "b", points: 9.0, credits: 3.0)
jane.recordGrade(history)
//john.recordGrade(history) - john is not a student

// a class that inherits from another class is SUBCLASS or derived class - NewStudet class
// a class from wich it inherits is SUPERCLASS or base class - NewPerson class

//RULES:
//- class can inherit from only one other class, SINGLE INHARITANCE
//- there is no limit to the depth of subclassing, you can subclass from a slacc that is also a subclass:
class BandMember: NewStudent {
    var minimunPracticeTime = 2
}

class OboePlayer: BandMember {
    // this is an example of override, wich we will cover soon
    override var minimunPracticeTime: Int {
        get {
            return super.minimunPracticeTime * 2
        }
        set {
            super.minimunPracticeTime = newValue / 2
        }
    }
}

// Polymorphism
// is a programming languages ability to treat an object differently based on context

func phonebookName(_ person: NewPerson) -> String {
    return "\(person.lastName), \(person.firstName)"
}
let person = NewPerson(firstName: "Johnny", lastName: "Appleseed")
let oboePlayer = OboePlayer(firstName: "Jane", lastName: "Appleseed")

phonebookName(person)
phonebookName(oboePlayer)
// because oboePlayer derives from NewPerson it is valid input for the function

// RunTime hierarchy Checks

var hallMonitor = NewStudent(firstName: "Jill", lastName: "Banana")
hallMonitor = oboePlayer
hallMonitor
// swift provides 'as' operator to treat a property or variable as another type:
// - 'as:' cast to a specific type that is known, such as casting to a supertype
// - 'as?:' an optional downcast (to a subtype). It it fails, the result will be nill
// - 'as!:' A forsed downcast. if it fails, program will CRASH. Use it only when you certain the cast will never fall

oboePlayer as NewStudent
//(oboePlayer as NewStudent).minimumPracticeTime - ERROR: no longer a band member

hallMonitor as? BandMember
(hallMonitor as? BandMember)?.minimunPracticeTime

hallMonitor as! BandMember
(hallMonitor as! BandMember).minimunPracticeTime

if let hallMonitor = hallMonitor as? BandMember {
    print("this hall monitor is a bend member and practices \(hallMonitor.minimunPracticeTime) hours per week")
}

// example of static dispatch - decision of wich specific operation is selected at compile time

func afterClassActivity(for student: NewStudent) -> String {
    return "Goes home!"
}

func afterClassActivity(for student: BandMember) -> String {
    return "Goes to practice!"
}

afterClassActivity(for: oboePlayer) // for NewStudent
afterClassActivity(for: oboePlayer) // for BandMember
afterClassActivity(for: oboePlayer as NewStudent)

// swift dispatch rules select more-derived version that takes in an OboePlayer. Because this is a subclass of bandmembers it will call always for: BandMembers func. but if we add 'oboePlayer as Newstudent' it will call for: Newstudent func.

//Inheritance, Methods and Overrides

// subclasses can override methods defined in their superclass when creating theit own meethods

class StudentAthlete: NewStudent {
    var failedClasses: [Grade] = []
    
    override func recordGrade(_ grade: Grade) {
        super.recordGrade(grade)
        
        if grade.letter == "F" {
            failedClasses.append(grade)
        }
    }
    
    var isEligible: Bool {
        return failedClasses.count < 3
    }
}

// the StudentAthlete class overridden recordGrade(_:) so it can track of any failed courses.
// you use 'super' to indicate that you override function from superclass

// When to call super - always

// Preventing inheritance
// sometime you want to disallow subclasses anf a class. Swift provides us with 'final' keyword, to guarabty the class will never get a subclass
//final class NewStudent: Person {
//}

// when you say Final class - you say that NewStudent is Final class in inheritance where person is a SUPERclass
// also, you can protect class methods from overridding - just mark it as final:
// final func recordGrade(_ grade: Grade) {} - you can't now override func in subclasses


//: Inheritance and class initialization

class NewStudentAthlete: NewStudent {
    var failedClasses: [Grade] = []
    var sports: [String] // added new variable and it needs initializer
    
    init(firstName: String, lastName: String, sports: [String]) { // need to add firstname and lastname from superclass
        self.sports = sports
        super.init(firstName: firstName, lastName: lastName) // init requires 'super.init' at the end because without it the superclass won't be able to provide initial states for all properties.
    }
    
    override func recordGrade(_ grade: Grade) {
        super.recordGrade(grade)
        
        if grade.letter == "F" {
            failedClasses.append(grade)
        }
    }
    
    var isEligible: Bool {
        return failedClasses.count < 3
    }
}

// Two-phase initialization
// - Phase One - initialize all the stored properties in the class instance. from the bottom to the top of the class hierarcy.
// - Phase Two - you can use methods and properties onle after Phase ONE

// Required and convenience initializers
// its possible to have multiple initialisers in a class. you can call it from any of a subclass.
// you can find that your class can have various initializers that provide convenient way to init the object.

class StudentTwo {
    var firstName: String
    var lastName: String
    var grades: [Grade] = []
    
    // 'required' keyword will force all subclasses of StudentTwo to implement this init.
    required init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    init(transfer: Student) {
        self.firstName = transfer.firstName
        self.lastName = transfer.lastName
    }
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
    }
}

// in this example the StudentTwo class can be built woth another StudentTwo object.
// subclasses of StudentTwo could potentially rely on the studenttwobased init when they make a call to super.init

// this is how to make init in subclass now:

class Athlete: StudentTwo {
    var failedClasses: [Grade] = []
    var sports: [String]
    // we use 'required' init to be sure the subclass uses init from super class.
    required init(firstName: String, lastName: String) {
        self.sports = []
        super.init(firstName: firstName, lastName: lastName)
    }
    
    override func recordGrade(_ grade: Grade) {
        super.recordGrade(grade)
        
        if grade.letter == "F" {
            failedClasses.append(grade)
        }
    }
    
    var isEligible: Bool {
        return failedClasses.count < 3
    }
}


// Also we can mark init in superclass as convenience for what? a hui ego znaet

// When and Why to subclass
// - single responsibility principle - any class ahould have a single concern only, and it should own all the functionality it uses.

// Understanding the class lifecycle

// there is a mechanism in swift to decide when to clean up unused objects on the HEAP - reference counting.
// each object has a reference count - incremented for constant or var woth a reference t object and decremented each time the reference is removed.
// when counter reaches zero - nothing holds a reference - object will be cleaned up

//example: one object created and it has lots of references:
var someone = NewPerson(firstName: "Slava", lastName: "Les")
// personn object has reference count of 1 (someone variable)

var anotherSomeone: NewPerson? = someone
// reference count 2 (someone, anotherSomeone)

var lotsOfPeople = [someone, someone, anotherSomeone, someone]
// reference count 6 (someone, anotherSomeone and 4 reference in lotsOfPeople)

anotherSomeone = nil
// reference count 5 (someone, 4 references in lotsOfPeople)

lotsOfPeople = []
// reference count 1 (someone)

someone = NewPerson(firstName: "Johnny", lastName: "Appleseed")
// Refence count 0 for the original Person object!
//Variable someone now references a new object

// this counts automaticaly because of Automatic Reference Counting

// Deinitialization

// deinit is a special method on classes that runs when an object's reference count reaches zero, but before it will be removed from memory

//  class NewPerson {
//      ...
//      deinit {
//       print("\(firstName) is beaing removed from memory")
//      }
//  }
// it all work automatically

// CHALLENGES
//1

class A {
    var a: String
    
    init(a: String) {
        self.a = a
        print("I'm A")
    }
}

class B: A {
    var b: String
    init(a: String, b: String) {
        self.b = b
        print("I'm B")
        super.init(a: a)
        print("I'm B: A")
    }
}

class C: B {
    var c: String
    init(a: String, b: String, c: String) {
        self.c = c
        print("I'm C")
        super.init(a: a, b: b)
        print("I'm C: B")
    }
}


let c = C(a: "A", b: "B", c: "C")

let a = A(a: "Test")

//3 cast c to A
c as A

//4
class StudentBaseballPlayer: Athlete {
    var position: String
    var number: Int
    var battingAverage: Int
    
    required init(firstName: String, lastName: String) {
        self.position = ("")
        self.number = 0
        self.battingAverage = 0
        super.init(firstName: firstName, lastName: lastName)
    }
}

let testret = StudentBaseballPlayer(firstName: "Slava", lastName: "Les")

testret.battingAverage = 3

testret.battingAverage

//6 fix the given classes so there isn't a mamory leak ahenwe add an order

class Customer {
    let name: String
    var orders: [Order] = []
    init(name: String) {
        self.name = name
    }
    func add(_ order: Order) {
        order.customer = self
        orders.append(order)
    }
}

class Order {
    let product: String
    weak var customer: Customer?   //added weak var
    init(product: String) {
        self.product = product
    }
}





