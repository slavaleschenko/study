//: CLASSES

// classes is named types, have properties and can define methods
// but classes is reference types, but not value types like structs.
// use structures to represent values and Classes to represent objects

//: Creating Classes
import UIKit
class Person {
    var firstName: String
    var lastName: String
    
    init (firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

let john = Person(firstName: "Johnny", lastName: "Appleseed")
john.fullName

// 'init' in Classes is a MUST, otherwise it will occur an error. all stored properties must be assigned initial values before the end of init
// this is BASIC 'init' for classes, later we will learn more about 'inheritance' in chapter Advanced Classes

//: Reference types

// structure is immutable but class is Mutable
// variable of class type doesn't store actual instance, but a REFERENCE to a location in memory that stores a value.

// The heap vs. the stack

// when create class the system stores actual instance in region of memory known as HEAP.
// when struct declared it stores in a region of memory called STACK. UNLESS it is a part of class.

// STACK
// - system uses stack to store anything on the immediate thread of execution. it is managed by CPU. When function creates a variable, STACK store this variable and then destriys when the function exits. STACK is fast.

// HEAP
// - system uses heap to store data referenced by by other objects. It is a large pool of memory from wich system can rewuest and allocate blocks of memory. It doesn't automatically destriy its objects like stack. additional job required for that. it is slower comparing to Stack.


// Working with references

// when we assign to variable of class type, the system doesn't copy the instance, only a reference copied.

let johnny = Person(firstName: "Johnny", lastName: "Appleseed")
var homeOwner = johnny

johnny.firstName = "Slava"

johnny.firstName
homeOwner.firstName
// johnny and homeOwner have the same value. When johnny object changes, then anything holding a reference to johnny see the update and changes too.

// MINI exercise
homeOwner.lastName = "Les"

johnny.fullName
homeOwner.fullName
// johnny and homeOwner pointing to the same object
// Object identity

// use === to check if the identity of one object is equal to another. its like == but it compares the memory address of two reference.

johnny === homeOwner
john === homeOwner

let imposterJohn = Person(firstName: "Johnny", lastName: "Appleseed")

johnny === homeOwner
johnny === imposterJohn
imposterJohn === homeOwner

// create fake, imposter johns. Use === to see if any of these imposters are our real john

var imposters = (0...100).map { _ in
    Person(firstName: "John", lastName: "Appleseed")
}
// == is not effective when john cannot be identified by name alone
imposters.contains {
    $0.firstName == johnny.firstName &&
    $0.lastName == johnny.lastName
}

// check to ensure the real John is not found among the imposters
imposters.contains {
    $0 === johnny
}
// now hide the real john somewhere among the imposters. Now he can be found
imposters.insert(johnny, at: Int(arc4random_uniform(100)))

imposters.contains {
    $0 === johnny
}

// since 'Person' is a reference type, you can use === to grab the real John out of the list of imposters and modify the value.
// the original 'johnny' variable will print the new last name
if let whereIsJohn = imposters.index(where: { $0 === johnny}) {
    imposters[whereIsJohn].lastName = "Banana"
}

johnny.fullName

// MINI exercise
// check if your name contains in a group
func memberOf(person: Person, group: [Person]) -> Bool {
    return group.contains {
        $0 === person
    }
}

var group1 = [Person(firstName: "Yarik", lastName: "Les"), Person(firstName: "Stas", lastName: "Goodman")]
let group2 = [Person(firstName: "Dima", lastName: "Yar"), Person(firstName: "Stas", lastName: "Goodman")]
let myName = Person(firstName: "Slava", lastName: "Les")

group1.append(myName)

let test1 = memberOf(person: myName, group: group1)
let test2 = memberOf(person: myName, group: group2)

// Methods and mutability

// because classes are mutable, its also possible for instances to mutate themselves

struct Grade {
    let letter: String
    let points: Double
    let credits: Double
}

class Student {
    var firstName: String
    var lastName: String
    var grades: [Grade] = []
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
    }
}

let jane = Student(firstName: "Jane", lastName: "Appleseed")
let history = Grade(letter: "B", points: 9.0, credits: 3.0)
var math = Grade(letter: "A", points: 16.0, credits: 4.0)

jane.recordGrade(history)
jane.recordGrade(math)

jane.grades

// Mutability and constants
// you can notice that we modified 'jane' even thoug it was defined as constant and we didn't use 'mutating' keyword for func to modify 'grades'
// the value of constant can't be modified, so when you will try to to assign another name to 'jane' it will show error
//jane = Student(firstName: "Slava", lastName: "Les") //ERROR

// MINI Exercise

// Understanding state and site effect

// Imagine we need to pass s 'Student' instance to a sports team, teacher class etc. All of these entities need to know the student's grades, and they all point to the sme instance and see new grades because the instance automatically records them

// The result of this sharing is that class instances have STATE.

class Student2 {
    var firstName: String
    var lastName: String
    var grades: [Grade] = []
    var credits = 0.0
    
    init(firstName: String, lastName: String, credits: Double) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
        credits += grade.credits
    }
}
// 'recordGrade(_:)' now adds the number of credits to the credits property. Calling 'recordGrade(_:)' has the side effect of updating credits.
// lets see the result

let jane2 = Student2(firstName: "Jane", lastName: "Appleseed", credits: 0.0)

jane2.recordGrade(history)
jane2.recordGrade(math)

jane2.credits

math = Grade(letter: "A", points: 20.0, credits: 5.0)
jane2.recordGrade(math)

jane2.credits // 12 but should be 8, because math was modified and updated, this is an example of side effect


//: Extending a class using an extension

extension Student {
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
// 'derivation' will be shown in next chapter

//: When to use CLASS vs STRUCT

// classes - objects - is an instance of a reference type, they have identity. Objects are unique
// structs - values

// speed - classes slower (heap), structs faster (stack

// minimalistic approach - use what you need considering on a situation.

// CHALENGE A



class List {
    var name: String
    var moveiList: Set<String>
    
    init(name: String, moveiList: Set<String>) {
        self.name = name
        self.moveiList = moveiList
    }
    
    func printList() {
        print(moveiList)
    }
}
var usersMoveiList: [String: Set<String>] = [:]


class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func addList(list: Set<String>) {
       usersMoveiList[name] = list
    }
}

let userJane = User(name: "Jane")
let userJohn = User(name: "John")

userJane.addList(list: ["movei1", "movei2"])
userJohn.addList(list: ["movei1", "movei2"])

usersMoveiList

let janeList = List(name: userJane.name, moveiList: usersMoveiList[userJane.name]!)

janeList.printList()













