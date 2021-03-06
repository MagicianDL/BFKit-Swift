//
//  UIDeviceExtensionTests.swift
//  BFKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 - 2017 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import XCTest
import Foundation
import UIKit
@testable import BFKit

class UIDeviceExtensionTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testOsVersionEqual() {
        let osVersion = osVersionEqual("7.0")
        
        XCTAssertFalse(osVersion)
    }
    
    func testOsVersionGreater() {
        let osVersion = osVersionGreaterThan("9.2")
        
        XCTAssertTrue(osVersion)
    }
    
    func testOsVersionGreaterOrEqual() {
        let osVersion = osVersionGreaterThanOrEqual("9.2")
        
        XCTAssertTrue(osVersion)
    }
    
    func testOsVersionLess() {
        let osVersion = osVersionLessThan("11.0")
        
        XCTAssertTrue(osVersion)
    }
    
    func testOsVersionLessOrEqual() {
        let osVersion = osVersionLessThanOrEqual("11.0")
        
        XCTAssertTrue(osVersion)
    }
    
    func testOsVersion() {
        let osVersion = UIDevice.osVersion.substring(to: ".")
        
        XCTAssertEqual(osVersion, "10")
    }
    
    func testOsMajorVersion() {
        let osVersion = UIDevice.osMajorVersion
        
        XCTAssertEqual(osVersion, 10)
    }
    
    func testHardwareModel() {
        let model = UIDevice.hardwareModel
        
        XCTAssert(model == "i386" || model == "x86_64")
    }
    
    func testDetailedModel() {
        let model = UIDevice.detailedModel
        
        XCTAssertEqual(model, "Simulator")
    }
    
    func testCPUFrequency() {
        let frequency = UIDevice.cpuFrequency
        
        XCTAssertNotEqual(frequency, 0)
    }
    
    func testBUSFrequency() {
        let frequency = UIDevice.busFrequency
        
        XCTAssertNotEqual(frequency, 0)
    }
    
    func testRamSize() {
        let ramSize = UIDevice.ramSize
        
        XCTAssertNotEqual(ramSize, 0)
    }
    
    func testCPUSNumber() {
        let cpusNumber = UIDevice.cpusNumber
        
        XCTAssertNotEqual(cpusNumber, 0)
    }
    
    func testTotalMemory() {
        let totalMemory = UIDevice.totalMemory
        
        XCTAssertNotEqual(totalMemory, 0)
    }
    
    func testUserMemory() {
        let userMemory = UIDevice.userMemory
        
        XCTAssertNotEqual(userMemory, 0)
    }
    
    @available(iOS 9.0, *)
    func testIsLowPowerModeEnabled() {
        let isLowPowerMode = UIDevice.isLowPowerModeEnabled
        
        XCTAssertFalse(isLowPowerMode)
    }
    
    @available(iOS 9.0, *)
    func testLowPowerModeChanged() {
        let testExpectation = expectation(description: "Low Power Mode Changed")
        
        UIDevice.lowPowerModeChanged { isLowPowerModeEnabled in
            XCTAssertFalse(isLowPowerModeEnabled)
            
            testExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Something went horribly wrong.")
        })
    }
    
    func testIsPhone() {
        let device = UIDevice.isPhone()
        
        XCTAssertFalse(device)
    }
    
    func testIsPad() {
        let device = UIDevice.isPad()
        
        XCTAssertFalse(device)
    }
    
    func testIsPod() {
        let device = UIDevice.isPod()
        
        XCTAssertFalse(device)
    }
    
    func testIsTV() {
        let device = UIDevice.isTV()
        
        XCTAssertFalse(device)
    }
    
    func testIsWatch() {
        let device = UIDevice.isWatch()
        
        XCTAssertFalse(device)
    }
    
    func testIsSimulator() {
        let device = UIDevice.isSimulator()
        
        XCTAssertTrue(device)
    }
    
    func testIsJailbroken() {
        let jailbroken = UIDevice.isJailbroken()
        
        XCTAssertTrue(jailbroken)
    }
    
    func testUptime() {
        let uptime = UIDevice.uptime()
        
        XCTAssertGreaterThan(uptime, 0)
    }
    
    func testUptimeDate() {
        let uptimeDate = UIDevice.uptimeDate()
        
        XCTAssertLessThan(uptimeDate, Date())
    }
    
    func testTotalDiskSpace() {
        let totalDiskSpace = UIDevice.totalDiskSpace()
        
        XCTAssertNotEqual(totalDiskSpace, 0.0)
    }
    
    func testFreeDiskSpace() {
        let freeDiskSpace = UIDevice.freeDiskSpace()
        
        XCTAssertNotEqual(freeDiskSpace, 0.0)
    }
    
    func testGenerateUniqueIdentifier() {
        let uuid = UIDevice.generateUniqueIdentifier()
        let uuid2 = UIDevice.generateUniqueIdentifier()
        
        XCTAssertEqual(uuid.length, 36)
        XCTAssertNotEqual(uuid, uuid2)
    }
    
    func testSaveAPNSIdentifier() {
        let testExpectation = expectation(description: "Save APNS Identifier")
        let uuid = UIDevice.generateUniqueIdentifier()
        
        UIDevice.saveAPNSIdentifier(uuid, completion: { isValid, needsUpdate, _, newUUID in
            XCTAssertTrue(isValid)
            XCTAssertTrue(needsUpdate)
            XCTAssertNotNil(newUUID)
            
            testExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Something went horribly wrong.")
        })
    }
}
