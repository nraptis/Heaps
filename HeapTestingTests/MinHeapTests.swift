//
//  HeapTestingTests.swift
//  HeapTestingTests
//
//  Created by Nicky Taylor on 10/20/22.
//

import XCTest
@testable import HeapTesting

final class MinHeapTests: XCTestCase {
    
    func testHeapExists() {
        let heap = MinHeap<Int>()
    }
    
    func testHeapAddOneElement() {
        var heap = MinHeap<Int>()
        heap.insert(5)
        XCTAssert(heap.count == 1)
    }
    
    func testHeapPopOneElement() {
        var heap = MinHeap<Int>()
        heap.insert(5)
        let top = heap.pop()!
        XCTAssert(top == 5)
    }
    
    func testHeapLotsOfStuff() {
        
        var sortedArray = [Int]()
        var heap = MinHeap<Int>()
        
        for _ in 0..<10000 {
            
            let random = Int.random(in: 0...10)
            
            if random < 7 {
                //add something to heap and array
                
                var number = Int.random(in: 0...100)
                sortedArray.append(number)
                sortedArray.sort()
                sortedArray = sortedArray.reversed()
                
                heap.insert(number)
                
                XCTAssert(heap.peek()! == sortedArray.last!)
                XCTAssert(heap.count == sortedArray.count)
            } else {
                if heap.count > 0 && sortedArray.count > 0 {
                    let pop = heap.pop()!
                    let arrback = sortedArray.popLast()!
                    XCTAssert(pop == arrback)
                    XCTAssert(heap.count == sortedArray.count)
                }
            }
            
            let killSwitch = Int.random(in: 0...100) == 5
            if killSwitch {
                while heap.count > 0 && sortedArray.count > 0 {
                    let pop = heap.pop()!
                    let arrback = sortedArray.popLast()!
                    XCTAssert(pop == arrback)
                    XCTAssert(heap.count == sortedArray.count)
                    
                }
            }
        }
    }
}
