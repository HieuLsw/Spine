//
//  SlotKeyframeAttachmentModelTests.swift
//  SpineTests
//
//  Created by Max Gribov on 02/02/2018.
//  Copyright © 2018 Max Gribov. All rights reserved.
//

import XCTest
@testable import Spine

class SlotKeyframeAttachmentModelTests: XCTestCase {
    
    func testNormal() {
        
        //given
        let json = """
            {
                "time": 0,
                "name": "front-fist-open"
            }
            """.data(using: .utf8)!
        
        //when
        let keyframe = try? JSONDecoder().decode(SlotKeyframeAttachmentModel.self, from: json)
        
        //then
        if let keyframe = keyframe {
            
            XCTAssertEqual(keyframe.time, 0, accuracy: TimeInterval.ulpOfOne)
            XCTAssertEqual(keyframe.name, "front-fist-open")
            
        } else {
            
            XCTFail("keyframe should not be nil")
        }
    }
    
    func testOmitted() {
        
        //given
        let json = """
            {
                "time": 0.0667,
                "name": null
            }
            """.data(using: .utf8)!
        
        //when
        let keyframe = try? JSONDecoder().decode(SlotKeyframeAttachmentModel.self, from: json)
        
        //then
        if let keyframe = keyframe {
            
            XCTAssertEqual(keyframe.time, 0.0667, accuracy: TimeInterval.ulpOfOne)
            XCTAssertNil(keyframe.name)
            
        } else {
            
            XCTFail("keyframe should not be nil")
        }
    }
}
