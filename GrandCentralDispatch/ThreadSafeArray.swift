//
//  ThreadSafeArray.swift
//  GrandCentralDispatch
//
//  Created by Gokul Sai Katragadda on 10/14/21.
//

import Foundation


struct ThreadSafeArray<Element> where Element: Hashable {
    var array = Array<Element>()
    let semaphore = DispatchSemaphore(value: 1)
    
    init(arr: [Element]) {
        append(contentsOf: arr)
    }
    
    mutating func append(_ newElement: Element) {
        semaphore.wait()
        array.append(newElement)
        semaphore.signal()
    }
    
    mutating func append(contentsOf arr: [Element]) {
        semaphore.wait()
        array.append(contentsOf: arr)
        semaphore.signal()
    }
    
    mutating func insert(_ element: Element, at index: Int) {
        semaphore.wait()
        array.insert(element, at: index)
        semaphore.signal()
    }
    
    mutating func remove(at index: Int) {
        semaphore.wait()
        array.remove(at: index)
        semaphore.signal()
    }
}
