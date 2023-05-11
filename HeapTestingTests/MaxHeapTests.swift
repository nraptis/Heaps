//
//  HeapTestingTests.swift
//  HeapTestingTests
//
//  Created by Nicky Taylor on 10/20/22.
//

import XCTest
@testable import HeapTesting

final class MaxHeapTests: XCTestCase {
    
    func testHeapExists() {
        let heap = MaxHeap<Int>()
    }
    
    func testHeapAddOneElement() {
        var heap = MaxHeap<Int>()
        heap.insert(5)
        XCTAssert(heap.count == 1)
    }
    
    func testHeapPopOneElement() {
        var heap = MaxHeap<Int>()
        heap.insert(5)
        let top = heap.pop()!
        XCTAssert(top == 5)
    }
    
    func testHeapLotsOfStuff() {
        
        var sortedArray = [Int]()
        var heap = MaxHeap<Int>()
        
        for _ in 0..<10000 {
            
            let random = Int.random(in: 0...10)
            
            if random < 7 {
                //add something to heap and array
                
                let number = Int.random(in: 0...100)
                sortedArray.append(number)
                sortedArray.sort()
                
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
    
    
    func testHeapRemoveIndex() {
        
        var heap = MaxHeap<Int>()
        for _ in 0..<100_000 {
            let random = Int.random(in: 0...10)
            
            let before = heap.data
            if random < 7 {
                //add something to heap and array
                
                let number = Int.random(in: 0...100)
                heap.insert(number)
                
                
            } else {
                if heap.count > 0 {
                    let index = Int.random(in: 0..<heap.count)
                    _ = heap.remove(at: index)
                    if !heap.isValid() {
                        XCTFail("I - Heap Failed, removing \(index)")
                        print("was: \(before)")
                        print("heap: \(heap.data)")
                        return
                    }
                }
            }
            
            let killSwitch = Int.random(in: 0...100) == 5
            if killSwitch {
                while heap.count > 0 {
                    
                    let before = heap.data
                    
                    let index = Int.random(in: 0..<heap.count)
                    _ = heap.remove(at: index)
                    if !heap.isValid() {
                        XCTFail("II - Heap Failed, removing \(index)")
                        print("was: \(before)")
                        print("heap: \(heap.data)")
                        return
                    }
                }
            }
        }
    }
    
    func testHeapLotsOfMoreStuff() {
        
        var sortedArray = [Int]()
        var heap = MaxHeap<Int>()
        
        for _ in 0..<100_000 {
            
            let random = Int.random(in: 0...10)
            
            if random < 6 {
                let number = Int.random(in: 0...100)
                sortedArray.append(number)
                sortedArray.sort()
                
                heap.insert(number)
                
                XCTAssert(heap.peek()! == sortedArray.last!)
                XCTAssert(heap.count == sortedArray.count)
            } else if random < 8 {
                
                if heap.count > 0 {
                    let index = Int.random(in: 0..<heap.count)
                    let value = heap.data[index]
                    _ = heap.remove(at: index)
                    
                    var arrayIndex = -1
                    for i in 0..<sortedArray.count {
                        if sortedArray[i] == value {
                            arrayIndex = i
                            break
                        }
                    }
                    if arrayIndex != -1 {
                        sortedArray.remove(at: arrayIndex)
                    }
                    
                    if !heap.isValid() {
                        XCTFail("I - Heap Failed, removing \(index)")
                        print("heap: \(heap.data)")
                        return
                    }
                    
                    if heap.count > 0 && sortedArray.count > 0 {
                        XCTAssert(heap.peek()! == sortedArray.last!)
                    }
                    XCTAssert(heap.count == sortedArray.count)
                    
                }
                
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
