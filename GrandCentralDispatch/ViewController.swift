//
//  ViewController.swift
//  GrandCentralDispatch
//
//  Created by Gokul Sai Katragadda on 10/14/21.
//

import UIKit

class ViewController: UIViewController {
    var array = [1,2,3]
    var threadSafeArray = ThreadSafeArray(arr: [1,2,3])

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // App crashes when the append button is tapped continuously in iPhone 13 mini.
    @IBAction func appendButtonTapped(_ sender: Any) {
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.array.append(6)
            print(self.array)
        }
        
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.array.append(5)
            print(self.array)
        }
    }
    
    // App doesn't crash when the appendThreadSafe button is tapped continuously in iPhone 13 mini since the array is thread safe.
    @IBAction func appendThreadSafeTapped(_ sender: Any) {
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.threadSafeArray.append(6)
            print(self?.threadSafeArray ?? "")
        }
        
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.threadSafeArray.append(5)
            print(self?.threadSafeArray ?? "")
        }
    }
    
    @IBAction func deadLockTapped(_ sender: Any) {
        DispatchQueue.main.sync {
            print("DeadLock")
        }
    }
    
    let group = DispatchGroup()
    //the app doesn't crash any more
    @IBAction func appenUsingDispatchGroup(_ sender: Any) {
        group.wait()
        group.enter()
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.array.append(6)
            self?.group.leave()
        }
        
        group.wait()
        group.enter()
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.array.append(5)
            self?.group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            print(self?.array ?? "")
        }
    }
    
    var workItem: DispatchWorkItem?
    //add a work item to append to array asynchronously
    @IBAction func appendAsync(_ sender: Any) {
        guard workItem == nil else { return }
        workItem = DispatchWorkItem(block: {
            self.array.append(7)
            print(self.array)
            self.workItem = nil
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: workItem!)
    }
    
    //cancel the task with in 5 sec.
    @IBAction func cancelAppendTask(_ sender: Any) {
        workItem?.cancel()
        workItem = nil
    }
}

