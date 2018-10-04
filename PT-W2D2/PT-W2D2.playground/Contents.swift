import UIKit


// -------------------------------------
// Types
// -------------------------------------


// String
var greeting = "Hello, playground!"
greeting // You can view what's currently in a variable on the right panel 👉
print(greeting) // You can view this print in the console on the bottom 👇

// Int
var eightyFive = 85

// Double
var accountBalance = 100.123
accountBalance // 100.123

accountBalance = accountBalance + 60
accountBalance // 160.123

// Type Inference
var anInteger = 33 // This type inferred as an Int. You can Option-Click this variable to check its type.
var EmmasWalletAmount: Float = 200 // We explicitly set this variable's type to Float
var KylesWalletAmount = EmmasWalletAmount // This type is inferred as a Float

// Array
var airport: [String] = ["plane 0", "plane 1", "plane 2"]

airport[2] // Look on the right panel. This is "plane 2"
airport.append("Boeing Dreamlifter")
airport.count
airport[3]

// Enum
enum Suit {
	case heart
	case spade
	case diamond
	case club
}

var mySuit: Suit = Suit.heart
var yourSuit = Suit.club


// -------------------------------------
// Classes -- Initialization
// -------------------------------------


class Card {
	
	// Method 1 for initialization
	//	var suit: Suit
	//	var value: Int
	
	// Method 1 for initialization
	//	init(suit: Suit, value: Int) {
	//		self.suit = suit
	//		self.value = value
	//	}
	
	// Method 2 for initialization
	var suit: Suit = .heart
	var value: Int = 12
	
	func isCardAHeart() {
		if suit == Suit.heart {
			print("Card is a heart!")
		} else {
			print("Card is not a heart!")
		}
	}
}

// Method 1 for initialization
//  var myCard = Card(suit: Suit.heart, value: 5)
//  myCard.isCardAHeart()

// Method 2 for initialization
var myCard2 = Card()
myCard2.suit
myCard2.isCardAHeart() // "Card is a heart!"


// -------------------------------------
// Classes -- Adding Functions and Variables
// -------------------------------------


class BankAccount {
	var name: String
	
	// When we make the variable balance private,
	// we can't use it from outside of the BankAccount class.
	private var balance: Double = 0

	init(name: String) {
		self.name = name
	}
	
	func checkBalance() -> Double {
		return balance
	}
	
	func deposit(amount: Double) {
		if amount < 0 {
			print("You have no money to deposit!!!")
		} else {
			balance = balance + amount
		}
	}
	
	func withdraw(amount: Double) {
		if amount > balance {
			print("You don't have money to withdraw \(amount)")
		} else if amount < 0 {
			print("You cannot withdraw a negative amount!")
		} else {
			balance = balance - amount
		}
	}
}

var myAccount: BankAccount = BankAccount(name: "Mo")
myAccount.checkBalance() // 0

myAccount.deposit(amount: 60)
myAccount.checkBalance() // 60
myAccount.withdraw(amount: -3)

myAccount.name = "Shanon"

// Private variables can't be accessed from outside the class
// myAccount.balance = 1000000

// currentBalance is a COPY of the value '60',
// so when we change this currentBalance,
// the balance inside the BankAccount stays the same
var currentBalance: Double = myAccount.checkBalance()
currentBalance = currentBalance + 70
currentBalance // 130
myAccount.checkBalance() // Still 60!


// -------------------------------------
// Inheritance/Subclassing 
// -------------------------------------


class Animal {
	
	var name: String = "Empty name"
	
	func poop() {
		print("\(name) pooped! 💩")
	}
}

class Pig: Animal {
	
	func oink() {
		print("Oink! Oink! 🐷")
	}
}

class Dog: Animal {
	
	// We can nest classes inside classes, for as many layers as we want!!! 🏦
	let bankAccount: BankAccount
	
	init(name: String) {
		self.bankAccount = BankAccount(name: name)
		
		super.init() // Initialize parent Animal class
		
		self.name = name
	}
}

var piglet = Pig()
piglet.name = "Piglet"
piglet.oink()
piglet.poop()

var ellie = Dog(name: "Ellie")
ellie.poop()
ellie.bankAccount.deposit(amount: 1000)

var ellieBalance = ellie.bankAccount.checkBalance()
print("\(ellie.name) has $\(ellieBalance)!")


// -------------------------------------
// Mutability in Variables
// -------------------------------------


// Mutable variables can be changed
var mutableVariable = 9
mutableVariable = 14

// Immutable variables can't be changed
let immutableVariable = 27
// immutableVariable = 128 // Can't do this
