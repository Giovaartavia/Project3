//: Playground - noun: a place where people can play

import UIKit
import Darwin

//NOTE: Semicolons can be used after statements

var str = "Hello, playground" //var is a normal variable
let pi = 3.14159 //let is constant variable

var test: String //It is good practice to define the type of a variable when initializing it
test = "Hello"

print("Pi is equal to \(pi)")

//To create a random number generator:
print("Random number: \(arc4random() % 11)") //Generates a random number between 0 and 10

print("============================")
//Conditionals:
var age = 13
if age<16{
    print("You can go to school")
}
else if (age>=16) && (age<18){
    print("You can drive")
}
else{
    print("You can vote")
}

print("============================")

//Switch statement:
var ingredients = "beans"
switch ingredients{
case "paste", "tomato":
    print("Spaghetti")
    fallthrough //Makes it so that "potato" is also checked
case "potato":
    print("Potato")
case "beans":
    print("Burrito")
default: //Necessary
    print("Water")
}

print("============================")

//Arrays:
var friends = ["Bob", "Fred", "Paul"]
print("Friend: \(friends[0])")

var groceries = [String]() //Empty array of strings
groceries.append("Tomato")
groceries.append("Potato")
groceries.append("Beans")
print("Num of groceries: \(groceries.count)") //Print length of array

groceries.insert("Flour", at: 1) //Inserts "flour" at index 1
print(groceries)

print("============================")

//For loops
for i in 0...10{
    if (i%2) == 0{
        continue //Skips all code after the keyword and increments value in for loop
    }
    if (i == 9){
        break //Breaks out of the for loop
    }
    print(i)
}

for person in friends{
    print(person)
}

print("============================")

//While loops
var k = 0
while (k<=10){
    print(k)
    k = k+1
}

var l = 0
repeat{ //Works as do while
    print(l)
    l = l+1
}while (l <= 10)

print("============================")

//Functions
func sayHello(name: String){ //Note the ': String'
    print("Hello \(name)")
}
sayHello(name: "Bob") //Note the 'name:'

var a = 1, b = 3
func getSum(num1: Int, num2: Int) -> Int{ //Arrow denotes that we are returning an int
    return(num1 + num2)
}
print(getSum(num1: a, num2: b))

//Note that parameters are always passed by value. If we want to pass by reference we use 'inout' and the '&':
var str1 = "happy"
var str2 = "sad"
func makeUppercase(str1: inout String, str2: inout String){ //Note the 'inout'
    str1 = str1.uppercased()
    str2 = str2.uppercased()
}
makeUppercase(str1: &str1, str2: &str2) //Note the '&'
print(str1, str2)

print("============================")

//Classes:
class Person{
    var firstName: String? //Question mark is used so that initialization can fail. It is required
    var lastName: String?
    let birthPlace = "Belgium" //No need to write the type of an already defined parameter
    
    func fullName() -> String{
        var parts: [String] = []
        if let firstName = self.firstName {
            parts += [firstName]
        }
        
        if let lastName = self.lastName {
            parts += [lastName]
        }
        
        return parts.joined(separator: " ")
    }
}

let john = Person()
john.firstName = "John"
john.lastName = "Doe"



