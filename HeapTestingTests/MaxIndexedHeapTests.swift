//
//  MinIndexedHeapTests.swift
//  HeapTestingTests
//
//  Created by Tiger Nixon on 5/11/23.
//

import Foundation

import XCTest
@testable import HeapTesting

final class MaxIndexedHeapTests: XCTestCase {
    
    struct HeapElement: MaxHeapIndexedElement {
        var value: Int
        var index: Int = 0
        init(value: Int) {
            self.value = value
        }
        
        static func < (lhs: MaxIndexedHeapTests.HeapElement, rhs: MaxIndexedHeapTests.HeapElement) -> Bool {
            lhs.value < rhs.value
        }
    }
    
    func testRigorous() {
        
        for k in 0...100000 {
            
            if ((k % 100) == 0) {
                print("\(k) iteration")
            }
            
            var heap = MaxIndexedHeap<HeapElement>()
            var sortedArray = [Int]()
            
            let actionCount = Int.random(in: 1...1000)
            
            for _ in 0..<actionCount {
                
                if Int.random(in: 0...255) == 0 {
                    while heap.count > 0 && sortedArray.count > 0 {
                        let popHeap = heap.pop()!
                        let popArray = sortedArray.popLast()!
                        
                        guard popHeap.value == popArray else {
                            XCTFail("heap pop \(popHeap) != array pop \(popArray)")
                            return
                        }
                        
                        for index in 0..<heap.count {
                            if heap.data[index].index != index {
                                XCTFail("heap index mismatch on: \(index)")
                                return
                            }
                        }
                        
                    }
                }
                
                let action = Int.random(in: 0...6)
                if action <= 4 {
                    let number = Int.random(in: 0...24)
                    sortedArray.append(number)
                    sortedArray.sort()
                    
                    let element = HeapElement(value: number)
                    heap.insert(element)
                    
                    guard heap.count == sortedArray.count else {
                        XCTFail("heap count: \(heap.count) != array count: \(sortedArray.count)")
                        return
                    }
                    if heap.count > 0 {
                        for index in 0..<heap.count {
                            if heap.data[index].index != index {
                                XCTFail("heap index mismatch on: \(index)")
                                return
                            }
                        }
                        guard heap.peek()!.value == sortedArray.last! else {
                            XCTFail("heap peek \(heap.peek()!) != array last \(sortedArray.last!)")
                            return
                        }
                        if !heap.isValid() {
                            XCTFail("heap invalid")
                            return
                        }
                    }
                    
                } else if action <= 5 {
                    guard heap.count == sortedArray.count else {
                        XCTFail("heap count: \(heap.count) != array count: \(sortedArray.count)")
                        return
                    }
                    if heap.count > 0 {
                        
                        let popHeap = heap.pop()!
                        let popArray = sortedArray.popLast()!
                        
                        guard popHeap.value == popArray else {
                            XCTFail("heap pop \(popHeap) != array pop \(popArray)")
                            return
                        }
                        
                        for index in 0..<heap.count {
                            if heap.data[index].index != index {
                                XCTFail("heap index mismatch on: \(index)")
                                return
                            }
                        }
                        
                        if heap.count > 0 {
                            guard heap.peek()!.value == sortedArray.last! else {
                                XCTFail("heap peek \(heap.peek()!) != array last \(sortedArray.last!)")
                                return
                            }
                        }
                        
                        if !heap.isValid() {
                            XCTFail("heap invalid")
                            return
                        }
                        
                    }
                } else if action <= 6 {
                    
                    guard heap.count == sortedArray.count else {
                        XCTFail("heap count: \(heap.count) != array count: \(sortedArray.count)")
                        return
                    }
                    
                    if heap.count > 0 {
                        let index = Int.random(in: 0..<heap.count)
                        let value = heap.data[index].value
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
                        
                        if heap.count > 0 {
                            guard heap.peek()!.value == sortedArray.last! else {
                                XCTFail("heap peek \(heap.peek()!) != array last \(sortedArray.last!)")
                                return
                            }
                        }
                        
                        for index in 0..<heap.count {
                            if heap.data[index].index != index {
                                XCTFail("heap index mismatch on: \(index)")
                                return
                            }
                        }
                        
                        if !heap.isValid() {
                            XCTFail("heap invalid")
                            return
                        }
                    }
                }
            }
        }
    }
    
    
}
