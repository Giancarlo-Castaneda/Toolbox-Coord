# Toolbox+Coordinator

## Movies Information app

App to show Information about a list of carousels

## Description of the problem and solution

Problem: Given an API, it is intended to show a list of carousels and their related information, for which it is necessary to first obtain an authentication token which expires after a certain time, as test requirements, a minimum of two carousels must be displayed

Solution: Develop an application that can obtain all the information from the carousels, validating the expiration of the authentication token, when at the time of obtaining the information the token has expired, it is redirected to the login screen to request authentication from the user again .

## Solution approach
The solution has integration with the API provided in the test statement, all the backend information is provided by the indicated domain, the front-end has the responsibility of showing a simple login screen, the list of carousels and their details.

## Technical choices

Architecture Pattern: MVVM using RxSwift(Reactive programming) and coordinators, the reason to choose them is mainly the good synergy that MVVM has with RxSwift or in general with the reactive programming approach, given the reactive programming allows an easy way to communicate between the View model and the view controller using observables, observers, subjects, etc. also the Rx declarative way is easy to maintain, modify and scale and is near to the new way to build UI on IOS (Swift UI + Combine). Related to the coordinators this approach allows easy control and modifying of the navigation flow of our application

Service Layer(API Calls): Implemented with Moya and RxSwift. moya is a network abstraction layer that uses Alamofire to call the requests, with the Rx implementation is easy the communication between the View model and the API Manager to return parsed models according to the endpoint. the API manager contains a generic request call method that returns the requested object if it can parse it.

Parse model: The way chosen to parse the data from the API calls was codable because is the native way to Decode / Encode information.

Save information in the cache: implemented using the Moya / Alamofire configuration to do it because it is easy to configure and manage, also because the size of the saved data is not large, currently the code is present as an additional for a possible implementation but commented so as not to modify the required behavior of the app according to the test statements.

## Trade-offs
- Implement logic back to login if token expires
- Add a detail to each item in the carousel
- Use reactive programming
- Add Video Playback

## Link to public profile

https://www.linkedin.com/in/giancarlo-castaneda-garcia
