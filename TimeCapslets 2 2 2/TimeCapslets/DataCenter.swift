//
//  DataCenter.swift
//  LogInSample
//
//  Created by Bo-Young PARK on 5/7/2017.
//  Copyright © 2017 Bo-Young PARK. All rights reserved.
//

import Foundation

class DataCenter {
    
    static let shared:DataCenter = DataCenter.init()
    
    // User Array
    private var userArray:[User]!
    
    var dataArray:[User] {
        get{
            return userArray
        }
    }
    
    // User
    private var user:User?
    
    var currentUser: User {
        get {
            return user!
        }
    }
    
//    private var capsule:[Capsule]?
//    private var userId:[[String:Any]] = [[:]]
    
    private let fileManager:FileManager = FileManager()
    private let docPath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! + "/Capslets.plist"
    
    private init() {
        if fileManager.fileExists(atPath: docPath) {
            loadFromDoc()
            print("도큐멘터 파일 있음")
        }else{
            loadFromBundle()
        }
    }
    
    private func loadFromBundle() {
        let bundlePath:String = Bundle.main.path(forResource: Authentification.plistFileName, ofType: Authentification.plistFileType)!
        if let loadedArray = NSArray.init(contentsOfFile: bundlePath) as? [[String:Any]] {
            parseUsers(loadedArray)
        }
        try? fileManager.copyItem(atPath: bundlePath, toPath: docPath)
    }
    
    private func loadFromDoc() {
        
        if let loadedArray = NSArray.init(contentsOfFile: docPath) as? [[String:Any]] {
            parseUsers(loadedArray)
        print("loadFromDoc \(loadedArray)")
        }
    }
    
    private func parseUsers(_ array:[[String:Any]]) {
        self.userArray = array.map({ (dictionary:[String:Any]) -> User in
            return User.init(dictionary: dictionary)
            
        })
    }

    //보영
    private func parseCapsules(_ array:[[String:Any]]) {
        self.userArray = array.map({ (dictionary: [String:Any]) -> User in
            return User.init(dictionary: dictionary)
            
        })
    }

    private func saveToDoc() {
        print("savaDo\(userArray)")
        let nsArray:NSArray = NSArray.init(array: self.userArray.map({ (user:User) -> [String:Any] in
            return user.dictionary
        }))
        nsArray.write(toFile: docPath, atomically: true)
    }
    
    // User 추가
    func addUser(_ dict:[String:Any]) {
        
        self.userArray.append(User.init(dictionary: dict))
        self.saveToDoc()
    }
    
    func editUser() {
        
        self.userArray[currentUser.userId] = user!
        
        print("Edit User .......................")
        print(userArray)
    }
    
    // User 설정
    func setUser() {
        
        let userEmail = UserDefaults.standard.object(forKey: "currentUser") as! String
        
        for index in userArray {
            if index.userEmail == userEmail {
                user = index
            }
        }
    }
    
    // Capsule 추가
    func addCapsuleData(_ dict: [String: Any]) {
        print("**********************",dict)
        
        print("user Array .......................")
        print(userArray)
        
        print("User ...................")
        print(user)
        
        user?.userData.append(Capsule(data: dict))
        
        self.saveToDoc()
        
        print("user.usreDAta ...............................")
        print(user?.userData)
        
        editUser()
    }
    
}
