//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Tommy on 9/14/17.
//  Copyright © 2017 Tommy. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
//    MARK: Meal class test
//    Confirm that the Meal initializer returns a Meal object when passed valid parameters
    func testMealInitializationSucceeds() {
        
//        Zero rating
        let zeroRating = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRating)
        
//        Highest positive rating
        let positiveRating = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRating)
    }
    
//    Confirm that the Meal initialier returns nil when passed a negative rating or an empty name
    func testMealInitializationFails() {
//        Negative rating
        let navigateRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(navigateRatingMeal)
        
//        Empty name
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
//        Rating exceeds maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
    }
}
