//
//  String+Extension.swift
//  SAS Coffee
//
//  Created by Duy Cao on 8/30/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import Foundation

extension String
{
    
    func contains(s: String) -> Bool
    {
        return (self.range(of: s) != nil) ? true : false
    }
    
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    subscript(r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            
            return self[startIndex..<endIndex]
        }
    }
    
    subscript(r: ClosedRange<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            
            return self[startIndex...endIndex]
        }
    }
    
    
    func indexOf(target: String) -> Int
    {
        var range = self.range(of: target)
        if let range = range {
            return distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return -1
        }
    }
   
    
    private var vowels: [String]
    {
        get
        {
            return ["a", "e", "i", "o", "u"]
        }
    }
    
    private var consonants: [String]
    {
        get
        {
            return ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]
        }
    }
    
    
}
