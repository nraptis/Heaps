//
//  MinIndexedHeap.swift
//  HeapTesting
//
//  Created by Tiger Nixon on 5/11/23.
//

import Foundation

protocol MinHeapIndexedElement: Comparable {
    var index: Int { set get }
}

struct MinIndexedHeap<Element: MinHeapIndexedElement> {
    
    private(set) var data = [Element]()
    private(set) var count: Int = 0
    
    mutating func insert(_ element: Element?) {
        if let element = element {
            if count < data.count {
                data[count] = element
            } else {
                data.append(element)
            }
            data[count].index = count
            var bubble = count
            var parent = (((bubble - 1)) >> 1)
            count += 1
            while bubble > 0 {
                if data[bubble] < data[parent] {
                    data.swapAt(bubble, parent)
                    
                    let holdIndex = data[bubble].index
                    data[bubble].index = data[parent].index
                    data[parent].index = holdIndex
                    
                    bubble = parent
                    parent = (((bubble - 1)) >> 1)
                } else {
                    break
                }
            }
        }
    }
    
    func peek() -> Element? {
        if count > 0 { return data[0] }
        return nil
    }
    
    mutating func pop() -> Element? {
        if count > 0 {
            let result = data[0]
            count -= 1
            data[0] = data[count]
            data[0].index = 0
            
            var bubble = 0
            var leftChild = 1
            var rightChild = 2
            var minChild = 0
            while leftChild < count {
                minChild = leftChild
                if rightChild < count && data[rightChild] < data[leftChild] {
                    minChild = rightChild
                }
                if data[bubble] > data[minChild] {
                    data.swapAt(bubble, minChild)
                    
                    let holdIndex = data[bubble].index
                    data[bubble].index = data[minChild].index
                    data[minChild].index = holdIndex
                    
                    bubble = minChild
                    leftChild = bubble * 2 + 1
                    rightChild = leftChild + 1
                } else {
                    break
                }
            }
            return result
            
        }
        return nil
    }
    
    var isEmpty: Bool {
        count == 0
    }
    
    mutating func remove(_ element: Element) {
        _ = remove(at: element.index)
    }
    
    mutating func remove(at index: Int) -> Element? {
        let newCount = count - 1
        if index != newCount {
            data.swapAt(index, newCount)
            
            var holdIndex = data[index].index
            data[index].index = data[newCount].index
            data[newCount].index = holdIndex
            
            var bubble = index
            var leftChild = bubble * 2 + 1
            var rightChild = leftChild + 1
            var minChild = 0
            while leftChild < newCount {
                minChild = leftChild
                if rightChild < newCount && data[rightChild] < data[leftChild] {
                    minChild = rightChild
                }
                if data[bubble] > data[minChild] {
                    data.swapAt(bubble, minChild)
                    
                    holdIndex = data[bubble].index
                    data[bubble].index = data[minChild].index
                    data[minChild].index = holdIndex
                    
                    bubble = minChild
                    leftChild = bubble * 2 + 1
                    rightChild = leftChild + 1
                } else {
                    break
                }
            }
            
            bubble = index
            var parent = (((bubble - 1)) >> 1)
            while bubble > 0 {
                if data[bubble] < data[parent] {
                    data.swapAt(bubble, parent)
                    
                    holdIndex = data[bubble].index
                    data[bubble].index = data[parent].index
                    data[parent].index = holdIndex
                    
                    bubble = parent
                    parent = (((bubble - 1)) >> 1)
                } else {
                    break
                }
            }
        }
        count = newCount
        return data[count]
    }
    
    func isValid() -> Bool {
        if count <= 1 { return true }
        return isValid(index: 0)
    }
    
    private func isValid(index: Int) -> Bool {
        let leftChild = index * 2 + 1
        if leftChild < count {
            if data[leftChild] < data[index] {
                return false
            }
            if !isValid(index: leftChild) {
                return false
            }
        }
        
        let rightChild = leftChild + 1
        if rightChild < count {
            if data[rightChild] < data[index] {
                return false
            }
            if !isValid(index: rightChild) {
                return false
            }
        }
        return true
    }
    
}

