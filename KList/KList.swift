//
//  KList.swift
//  KList
//
//  Created by Kirill Varshamov on 21.04.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

public class KList<T> {
    private var HeadNode: KListNode<T>?
    private var TailNode: KListNode<T>?
    
    private var nodeCount = 0
    
    public var count: Int {
        return nodeCount
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public init() {
        
    }
}

//MARK: Add/Delete element
extension KList {
    public func append(_ newElement: T) {
        if HeadNode == nil {
            HeadNode = KListNode(data: newElement)
            TailNode = HeadNode
        } else {
            let newLastNode = KListNode(data: newElement)
            newLastNode.previousNode = TailNode
            TailNode?.nextNode = newLastNode
            TailNode = newLastNode
        }
        nodeCount += 1
    }
    
    public func remove(at i: Int) {
        let tmpBool = self.isEmpty
        
        guard !tmpBool else {
            return
        }
        
        var node: KListNode? = HeadNode
        
        for _ in 0..<i {
            node = node?.nextNode
        }
        
        let prev = node?.previousNode
        let next = node?.nextNode
        
        prev?.nextNode = next
        next?.previousNode = prev
        
        if node === TailNode {
            TailNode = prev
        }
        
        node = nil
        
        nodeCount -= 1
    }
    
    public func removeAll() {
        HeadNode = nil
        TailNode = nil
        nodeCount = 0
    }
    
    public func insert(_ newElement: T, at i: Int) {
        var node: KListNode? = HeadNode
        
        for _ in 0..<i {
            node = node?.nextNode
        }
        
        let next = node?.nextNode
        
        let newNode = KListNode(data: newElement)
        
        node?.nextNode = newNode
        newNode.previousNode = node
        
        next?.previousNode = newNode
        newNode.nextNode = next
        
        if node === TailNode {
            TailNode = newNode
        }
        
        nodeCount += 1
    }
}

//MARK: Access Methods
extension KList {
    public func lastElement() -> T? {
        return TailNode?.data
    }
    
    public func firstElement() -> T? {
        return HeadNode?.data
    }
    
    public subscript(dataIndex: Int) -> T? {
        get {
            var node: KListNode? = HeadNode
            
            for _ in 0..<dataIndex {
                node = node?.nextNode
            }
            
            let data: T? = node?.data
            
            return data
        }
        set {
            var node: KListNode? = HeadNode
            
            for _ in 0..<dataIndex {
                node = node?.nextNode
            }
            
            node?.data = newValue
        }
    }
}

//MARK: ListNode
private extension KList {
    class KListNode<T> {
        var previousNode: KListNode?
        var nextNode: KListNode?
        
        var data: T?
        
        init(data: T) {
            self.data = data
        }
    }
}
