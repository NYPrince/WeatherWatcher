//
//  WeekDayViewModelTest.swift
//  WeatherWatcherTests
//
//  Created by Rick Williams on 12/2/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import XCTest
@testable import WeatherWatcher


class WeekDayViewModelTest: XCTestCase {
    
    var viewModel: WeekDayViewModel!
    
    override func setUp() {
        
        let data = loadStub(name: "dark", extension: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let darkSkyRespnse = try! decoder.decode(DarkSkyResponse.self, from: data)
        viewModel = WeekDayViewModel(weatherData: darkSkyRespnse.forecast[5])
        
       
    }

    override func tearDown() {
            
        func testDay() {
            XCTAssertEqual(viewModel.day, "Sunday")
        }
        
        // MARK: - Tests for Date
        
        func testDate() {
            XCTAssertEqual(viewModel.date, "September 2")
        }
        
        func testTemperature() {
            XCTAssertEqual(viewModel.temperature, "61.9 °F")
        }
        
        func testWindSpeed() {
            XCTAssertEqual(viewModel.windSpeed, "2 MPH")
        }
        
        
        func testImage() {
            let viewModelImage = viewModel.image
            let imageDataViewModel = viewModelImage!.pngData()!
            let imageDataReference = UIImage(named: "cloudy")!.pngData()!
            
            XCTAssertNotNil(viewModelImage)
            XCTAssertEqual(viewModelImage!.size.width, 45.0)
            XCTAssertEqual(viewModelImage!.size.height, 33.0)
            XCTAssertEqual(imageDataViewModel, imageDataReference)
        }
        
    }

}
