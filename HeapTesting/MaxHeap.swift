//
//  MaxHeap.swift
//  HeapyHeaps
//
//  Created by Nicky Taylor on 10/20/22.
//

import Foundation

struct MaxHeap<Element: Comparable> {
    
    private(set) var data = [Element]()
    private(set) var count: Int = 0
    
    mutating func insert(_ element: Element?) {
        if let element = element {
            if count < data.count {
                data[count] = element
            } else {
                data.append(element)
            }
            var bubble = count
            var parent = (((bubble - 1)) >> 1)
            count += 1
            while bubble > 0 {
                if data[bubble] > data[parent] {
                    data.swapAt(bubble, parent)
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
            var bubble = 0
            var leftChild = 1
            var rightChild = 2
            var maxChild = 0
            while leftChild < count {
                maxChild = leftChild
                if rightChild < count && data[rightChild] > data[leftChild] {
                    maxChild = rightChild
                }
                if data[bubble] < data[maxChild] {
                    data.swapAt(bubble, maxChild)
                    bubble = maxChild
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
        data.count == 0
    }
    
    mutating func remove(at index: Int) -> Element? {
        let newCount = count - 1
        if index != newCount {
            data.swapAt(index, newCount)
            var bubble = index
            var leftChild = bubble * 2 + 1
            var rightChild = leftChild + 1
            var maxChild = 0
            while leftChild < newCount {
                maxChild = leftChild
                if rightChild < newCount && data[rightChild] > data[leftChild] {
                    maxChild = rightChild
                }
                if data[bubble] < data[maxChild] {
                    data.swapAt(bubble, maxChild)
                    bubble = maxChild
                    leftChild = bubble * 2 + 1
                    rightChild = leftChild + 1
                } else {
                    break
                }
            }
            bubble = index
            var parent = (((bubble - 1)) >> 1)
            while bubble > 0 {
                if data[bubble] > data[parent] {
                    data.swapAt(bubble, parent)
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
            if data[leftChild] > data[index] {
                return false
            }
            if !isValid(index: leftChild) {
                return false
            }
        }
        
        let rightChild = leftChild + 1
        if rightChild < count {
            if data[rightChild] > data[index] {
                return false
            }
            if !isValid(index: rightChild) {
                return false
            }
        }
        return true
    }
}

