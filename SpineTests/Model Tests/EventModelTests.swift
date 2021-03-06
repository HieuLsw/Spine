//
//  EventModelTests.swift
//  SpineTests
//
//  Created by Max Gribov on 05/02/2018.
//  Copyright © 2018 Max Gribov. All rights reserved.
//

import XCTest
@testable import Spine

class EventModelTests: XCTestCase {
    
    func testNormal() {
        
        //given
        let json = """
            {
                "skeleton": {
                    "hash": "FrNJhva2RVZ1bbIjdNspNttett4",
                    "spine": "3.6.32",
                    "width": 419.84,
                    "height": 686.08,
                    "images": "./images/"
                },
                "events": {
                    "footstep": {
                        "int": 1,
                        "float": 1.0,
                        "string": "string-value"
                    }
                }
            }
            """.data(using: .utf8)!
        
        //when
        let spineModel = try? JSONDecoder().decode(SpineModel.self, from: json)
        
        //then
        if let events = spineModel?.events {
            
            if let event = events.first(where: { $0.name == "footstep" }) {
                
                XCTAssertEqual(event.int, 1)
                XCTAssertEqual(event.float, 1.0, accuracy: CGFloat.ulpOfOne)
                XCTAssertEqual(event.string, "string-value")
                
            } else {
                
                XCTFail("event should not be nil")
            }
            
        } else {
            
            XCTFail("events should not be nil")
        }  
    }
    
    func testOmitted() {
        
        //given
        let json = """
            {
                "skeleton": {
                    "hash": "FrNJhva2RVZ1bbIjdNspNttett4",
                    "spine": "3.6.32",
                    "width": 419.84,
                    "height": 686.08,
                    "images": "./images/"
                },
                "events": {
                    "footstep-omitted": {}
                }
            }
            """.data(using: .utf8)!
        
        //when
        let spineModel = try? JSONDecoder().decode(SpineModel.self, from: json)
        
        //then
        if let events = spineModel?.events {
            
            if let event = events.first(where: { $0.name == "footstep-omitted"}) {

                XCTAssertEqual(event.int, 0)
                XCTAssertEqual(event.float, 0, accuracy: CGFloat.ulpOfOne)
                XCTAssertNil(event.string)
                
            } else {
                
                XCTFail("event should not be nil")
            }
            
        } else {
            
            XCTFail("events should not be nil")
        }
    }
}
