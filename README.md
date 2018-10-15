# Greetings!
This exercise is designed to test your ability to work with complex composite types (classes
and structs) in the Swift programming language.

Your task is simple: Make the code compile, and make all the unit tests pass. You may not change the
tests that already exist; you may, however, add a few tests, as well.

## To get started...
... you must first obtain a copy of the source. Do that by cloning this repository:

    git clone https://bitbucket.org/TedNeward/uw-ios-simpledomainmodel simpledomainmodel

This will create a local copy of the project. However, in order to *store* your changes to your own
GitHub account, you need to create a new repository on GitHub (call it `simpledomainmodel`), and then
change the project's settings to point to that new repository as the remote origin.

    git remote set-url origin https://github.com/[your-ID]/simpledomainmodel.git

This will work regardless of whether you got the syntax of the URL correct or not, so do a quick
push to make sure it all worked correctly:

    git push

Git will ask you for your username and password, then (if everything was done correctly), it will
upload the code to the new repository, and this is your new "home" for this project going forward.
Verify the files are there by viewing your GitHub project through the browser.

***NOTE:*** Your grade for this assignment (and all future assignments) will be based on what we
see in the GitHub repository, and nothing else. If it isn't in GitHub, it doesn't exist.

Now, you can begin to work on the homework code.

## Your tasks
Your task is to create some types that will allow the associated unit tests to pass. Again, as
with the other assignments you have done, you are free to examine the unit test code, but you may
not modify it. Again, you are free to comment out parts of the unit tests to let your work compile
as you go, but make sure no comments are present in the finished product that you turn in.

Your domain model is going to represent a rather simple domain: real life. At least, the money,
jobs, people and family parts of real life. (OK, so not really life, but a vast oversimplification
of it. Such is what we do in programming.)

### Money
To start, you will need to create a Money type (a struct). It will need two properties, `amount`
and `currency`, since money is different in different cultures. (We will be ignoring fractional
amounts like pennies for simplicity's sake.) The `amount` should be an Int and the `currency`
should be a String--make sure to include code to reject unknown currencies. Acceptable currencies
are "USD", "GBP" (British pounds), "EUR" (Euro) and "CAN" (Canadian dollars, also known in the
US as "funny money").

Money should also have three methods, `convert`, which takes a currency name as a parameter and
returns a new Money that contains the converted amount, and `add` and `subtract`, which each take
a Money as a parameter and returns a new Money that contains the addition or subtraction of the
two. Note that it is entirely acceptable to add mixed-currency amounts (5 EUR to 7 USD, and so on).

Exchange rates are as follows:

* 1 USD = .5 GBP / 2 USD = 1 GBP

* 1 USD = 1.5 EUR / 2 USD = 3 EUR

* 1 USD = 1.25 CAN / 4 USD = 5 CAN

You will need to work out the rest of the math on your own.

All of the Money tests are in MoneyTests.swift, if you want to see what's tested.

### Job
How do we get money? From jobs, of course! Create a class, called Job, that has two properties:
`title`, a String describing the name of the job, and `type`, which will be an enumeration
called JobType (which is already provided for you). Note that the JobType is a "discriminated
union", meaning it is an enumeration that can carry data--in this case, the amount of either
the Hourly wage (a Double) or the yearly Salary amount (an Int).

The two methods you must provide are:

* `calculateIncome`, which returns the amount of money (as an Integer, we're not worried about 
  Money here) that this position makes in a calendar year. For Salary positions, this is simply 
  the yearly amount; for Hourly positions, this is the hourly amount multiplied by 2000. 
  (Interesting and important note for job seekers: assuming you get two weeks' off during the 
  year, there are 50 weeks * 40 hours/week, or 2000 working hours in a given calendar year.)

* `raise`, which should bump the amount of the Salary or the Hourly by the given percentage.

All of the Job tests are in JobTests.swift, if you want to see what's tested.

### Person
Now we want to start modeling those carbon-based life forms that do jobs, a la people. Create
a class, called Person, which will have the following five properties:

* `firstName` and `lastName`, both Strings

* `age`, an Int

* `job`, a Job (the rough syntax for the property is provided for you)

* `spouse`, a Person (the rough syntax for the property is provided for you)

Note that `job` and `spouse` are nullable, whereas the others aren't.

Create an initializer to take the first three as parameters; since `job` and `spouse` are not
always present (not everyone has a job, and certainly not everyone is married), leave those
out of the initializer.

Create a method to display a human-readable String of the contents of a Person. (Since so many
of you--and me--are all comfortable with Java, call it `toString`.) Put some reasonable display
of the Person class there, along the lines of "[Person: firstName: Ted lastName: Neward age: 45
job: Salary(1000) spouse: Charlotte]".

All of the Person tests are in PersonTests.swift, if you want to see what's tested.

### Family
Finally, a family is a group of people, some of whom have jobs, some don't, but whose total
income is what's taxed come April 1. Create a class called Family that has one property,
`members`, which is a collection of Persons. US law dictates that a family consists of two
Persons at a minimum (spouse1 and spouse2), so create an initializer that takes two Person
parameters (called `spouse1` and `spouse2` to avoid genderfying parameter names). However,
US law also frowns on being married more than once at the same time, so make sure your two
parameters each have no spouse, and set their respective `spouse` fields to each other.

Next, flesh out the `haveChild` method, which takes a Person parameter to add to the family.
However, US law also frowns on minors having children, so let's make sure that at least one
Person of the two spouses is over the age of 21.

Finally, the `householdIncome` method will calculate the complete income for the Family.

All of the Family tests are in PersonTests.swift, if you want to see what's tested.

