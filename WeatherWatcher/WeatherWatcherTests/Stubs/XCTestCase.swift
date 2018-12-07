//
//  XCTestCase.swift
//  WeatherWatcherTests
//
//  Created by Rick Williams on 11/29/18.
//  Copyright © 2018 Rick Williams. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        return try! Data(contentsOf: url!)
    }
}

