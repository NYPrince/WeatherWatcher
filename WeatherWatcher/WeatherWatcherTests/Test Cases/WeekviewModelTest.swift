//
//  WeekviewModelTest.swift
//  WeatherWatcherTests
//
//  Created by Rick Williams on 12/2/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import XCTest
@testable import WeatherWatcher


class WeekViewModelTest: XCTestCase {

    var viewModel: WeekViewModel!
    override func setUp() {
        super.setUp()
        let data = loadStub(name: "darksky", extension: "json")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let darkSkyResponse = try!decoder.decode(DarkSkyResponse.self, from: data)
        
        viewModel = WeekViewModel(weatherData: darkSkyResponse.forecast)
        
    }

    override func tearDown() {
        super.tearDown()
        
    }
    func testNumberOfDays() {
        XCTAssertEqual(viewModel.numberOfDays, 8)
    }
    func testViewModelForIndex(){
        
        let weekDayViewModel = viewModel.viewModel(for: 5)
        
        XCTAssertEqual(weekDayViewModel.day, "Saturday")
        XCTAssertEqual(weekDayViewModel.date, "December 1 ")
        
    }
    
}
