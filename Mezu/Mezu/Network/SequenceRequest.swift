//
//  SequenceRequest.swift
//  Mezu
//
//  Created by Artem Umanets on 23/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

typealias SequenceRequestCallback = () -> ()
class SequenceRequest {
    
    private let dispatchGroup = DispatchGroup()
    private var hasError = false
    private var numRequests: Int = 0
    
    private var requestStack = [SequenceRequestCallback]()
    
    private var before: SequenceRequestCallback?
    private var after: SequenceRequestCallback?

    @discardableResult
    func request(callback: @escaping SequenceRequestCallback) -> SequenceRequest {
        requestStack.append(callback)
        return self
    }
    
    @discardableResult
    func before(_ callback: @escaping SequenceRequestCallback) -> SequenceRequest {
        before = callback
        return self
    }
    
    @discardableResult
    func after(_ callback: @escaping SequenceRequestCallback) -> SequenceRequest {
        after = callback
        return self
    }
    
    private func executeRequests(){
        if requestStack.count > 0  && !hasError {
            numRequests += 1
            dispatchGroup.enter()
            requestStack.removeFirst()()
            executeRequests()
        }
    }
    
    func success() {
        numRequests -= 1
        executeRequests()
        dispatchGroup.leave()
    }
    
    func fail() {
        numRequests -= 1
        hasError = true
        dispatchGroup.leave()
    }
    
    @discardableResult
    func waitAll(onSuccess: @escaping SequenceRequestCallback, onError: @escaping SequenceRequestCallback) -> SequenceRequest {
        before?()
        executeRequests()
        
        dispatchGroup.notify(queue: .main) {
            guard self.numRequests == 0 else { return }
            
            if self.hasError { onError() }
            else { onSuccess() }
            self.after?()
        }
        return self
    }
}
