//
//  RealmWrapper.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/13/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import RealmSwift

class RealmWrapper: NSObject {
    static var realm : Realm! = nil
    static var config : Realm.Configuration! = nil
    static func save(obj : Object){
        do {
            try realm.write {
                realm.add(obj, update: true)
            }
            print("YES")
        } catch {
            print("FUCK")
        }
    }
    
    static func remove(obj: Object){
        do {
            try realm.write {
                realm.delete(obj)
            }
        }catch {
            print("fuck")
        }
    }
    
    static func remove(objs : [Object]){
        do {
            try realm.write {
                realm.delete(objs)
            }
        }catch {
            print("fuck")
        }
    }

    static func get(objOf: SuperModel.Type , whereTheseHappen: String!) -> [SuperModel]{
        let result = try! realm.objects(objOf)
        return Array(result) as! [SuperModel]
    }
}
