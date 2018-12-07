//
//  DayViewModelTest.swift
//  WeatherWatcherTests
//
//  Created by Rick Williams on 11/26/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import XCTest
@testable import WeatherWatcher

class DayViewModelTest: XCTestCase {
    
    var viewModel:DayViewModel!

    override func setUp() {
        
        let data = loadStub(name: "darksky", extension: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let darkskyRespnse = try! decoder.decode(DarkSkyResponse.self, from: data)
         viewModel = DayViewModel(weatherData: darkskyRespnse.current)
        
    }

    override func tearDown() {
        
    }
    
    func testDate(){
        XCTAssertEqual(viewModel.date, "Mon, November 26 2018")
        
    }
    
    func testTime(){
        XCTAssertEqual(viewModel.time, "04:46 PM")
        
    }
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Partly Cloudy")
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
