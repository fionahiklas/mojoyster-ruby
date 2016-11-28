## Overview

Ruby code for the MoJ Oyster programming test.


## Getting Started

### Install Ruby 

Install Ruby and Gem using the appropriate packages for your operating system

Install bundler locally using the following command

```
gem install --user-install bundler
```

Ensure that the local gem bin location is in your path, for example on UNIX/Linux/Mac

```
export PATH=$PATH:$HOME/.gem/ruby/2.0.0/bin
```

Or on Windows

```
set PATH=%PATH%;%HOME%\.gem\ruby\2.0.0\bin
```

### Install Any Gems

Since all required gems are listed in the Gemfile they can be loaded with the bundler by running the following command

```
bundle install --path ~/.gem
```

For any subsequent updates you can simply run the command as follows since the previous one caches the install location

```
bundle install
```


### Run the Tests

Run the tests using the following command

```
rake test
```



## Design

### Assumptions

* Top-up can occur at any point - the balance will simply be updated
* Top-up doesn't change the journey state 
* Access to tube stations is via in and out gates - there is no simply a single "at station" tap 
* The swipe/tap events update the state of the Oyster card and it's balance
* Corrections for the amount charaged for a journey are calculated by the swipe gates
* Balance is handled in pence rather than pounds - less mucking around with decimals, obviously can be improved with a Money class
* You can't travel from zone 1 direct to 3, you have to pass through 2


### Objects


#### Oyster Card

Essentially a state machine.  The card can be in the following states

* Dormant
* On bus Journey (transient state since there is no start/end point, reverts back to dormant)
* Tube Journey Started (Swiped in)
* Tube journey ended (also transient since finishing a journey then reverts back to dormant)

The events that can happen to an Oyster card are as follows

* Top-up - a given amount will be added to the card balance
* Bus journey - signals that the user has tapped onto a bus
* Start tube journey - entry via a tube station
* End tube journey - exit via a tube station

Internal state consists of the following

* The state of the journey (the state machine above)
* The current balance amount
* The last tube station to swipe in


### Fare Calculation

* Zone 1 to 1 = Anywhere in zone 1
* Zone 2 to 2, or 3 to 3 = Any one zone outside zone 1
* Zone 1 to 2, or 2 to 1 = Any two zones including 1
* Zone 2 to 3, or 3 to 2 = Any two zones excluding 1
* Zone 1, 2, 3, or 3, 2, 1 = Any three zones

So some rules

* If start and end zone are same then price is £2.00 unless it's zone 1 in which case it's £2.50
* If start and end zones differ by 1 then price is £2.25 unless one is zone 1 in which case it's £3.00
* If start and end zones differ by 2 then price is £3.20

|One point match |Zone difference  | Cost |
|----------------|------------------------|
|                |   0             | 2.00 |
|                |   1             | 2.25 |
|                |   2             | 3.20 |
|      1         |   0             | 2.50 |
|      1         |   1             | 3.00 |

