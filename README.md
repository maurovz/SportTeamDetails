# Sports Team Detail

A demo showing the teams squads and player information

## Description

This is a demonsration of the basic functionality of sports information app. For this exercise, we'll only focus on the Squad section of the Team detail view.

## Architecture

Although this is a very small and basic app, I want to demonstrate that we can easily use CLEAN Architeture and follow the SOLID principles. This way we can avoid tight coupling and will be able to add/remove functionality without the need to modify several modules.

![architecture](https://user-images.githubusercontent.com/1994477/190904523-625f3569-1cae-4de2-a240-f663d0c55d86.jpg)


## Use Cases
We don't have an API for this demo but we can create the Use Cases so we can design the features and user flow

### Load Squad Data from Remote Use Case

- Input Data: URL
- Primary course (happy path)

1. Execute “load squad data” command with above input data
2. System downloads data from the url
3. System validates downloaded data
4. System creates Squad Details from valid data
5. System delivers Squad Details 

#### Invalid Data - error course (sad path).
1. System delivers invalid data error

#### No Connectivity - error course (sad path).
1. System delivers connectivity error.

### Load Squad Data from Cache Use Case

- Input Data: Cache

#### Primary course (happy path) 

1. Execute “load squad data” command with above input data
2. System retrieves data from the cache
3. System validates retrieved data
4. System creates Squad Details from valid data
5. System delivers Squad Details 

#### Invalid Data - error course (sad path).
1. System delivers invalid data error

#### Expired Cache - error course (sad path).
1. System delivers no Squad Details

#### Empty Cache - error course (sad path).
1. System delivers no Squad Details
