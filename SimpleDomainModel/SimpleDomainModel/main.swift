//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
    init(amount: Int, currency: String) {
        self.amount = amount
        let legalCurrencies = ["USD", "GBP", "EUR", "CAN"]
        if legalCurrencies.contains(currency) {
            self.currency = currency
        }
        else{
            self.currency = "USD"
            print("Illegal Input: Currency changed to USD")
        }
    }
    
    
  public func convert(_ to: String) -> Money {
    var returnAmount = 0
    switch (currency, to) {
    case ("USD", "GBP"):
        returnAmount = Int(self.amount / 2)
    case("USD", "EUR"):
        returnAmount = Int(Double(self.amount) * 1.5)
    case("USD", "CAN"):
        returnAmount = Int(Double(self.amount) * 1.25)
    case("CAN", "USD"):
        returnAmount = Int(Double(self.amount) / 1.25)
    case("GBP", "USD"):
        returnAmount = Int(self.amount * 2)
    case("EUR", "USD"):
        returnAmount = Int(Double(self.amount) / 1.5)
    default:
        returnAmount = self.amount
    }
    
    return Money(amount: returnAmount, currency: to)
    
  }
  
  public func add(_ to: Money) -> Money {
    let conertedMoney = self.convert(to.currency)
    let returnAmount = conertedMoney.amount + to.amount
    return Money(amount: returnAmount, currency: to.currency)
  }
    
  public func subtract(_ from: Money) -> Money {
    let conertedMoney = self.convert(from.currency)
    let returnAmount = from.amount - conertedMoney.amount
    return Money(amount: returnAmount, currency: from.currency)
  }
}

//////////////////////////////////
// Job

open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }

  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }

  open func calculateIncome(_ hours: Int) -> Int {
    switch self.type{
    case .Hourly(let temp):
        return (Int(temp) * hours)
    case .Salary(let temp):
        return (temp)
    }
  }

  open func raise(_ amt : Double) {
    switch self.type{
    case .Hourly(let temp):
        self.type = JobType.Hourly(temp + amt)
    case .Salary(let temp):
       self.type = JobType.Salary(temp + Int(amt))
    }
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { return _job}
    set(value) {
        if self.age > 18 {
            _job = value
        }
    }
  }

  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get {return _spouse}
    set(value) {
        if self.age > 18 {
            _spouse = value
        }
    }
  }

  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }

  open func toString() -> String {
    return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(String(describing: self._job)) spouse:\(String(describing: self._spouse))]"
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []

  public init(spouse1: Person, spouse2: Person) {
    if spouse1.spouse == nil && spouse2.spouse == nil {
        spouse2.spouse = spouse1
        spouse1.spouse = spouse2
        members.append(spouse2)
        members.append(spouse1)
    }
  }

  open func haveChild(_ child: Person) -> Bool {
    if members[0].age > 21 || members[1].age > 21 {
        members.append(child)
        return true
    }
    return false
  }

  open func householdIncome() -> Int {
    var totalIncome = 0
    for person in members{
        if person.job != nil{
            switch person.job!.type{
            case .Hourly(let temp):
                totalIncome += Int(temp * Double(2000))
            case .Salary(let temp):
                totalIncome += temp
            }
        }
    }
    return totalIncome
  }
}





