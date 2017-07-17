
//
//  User.swift
//  TimeCapslets
//
//  Created by 샤인 on 2017. 7. 6..
//  Copyright © 2017년 IosCamp. All rights reserved.
//

import Foundation


struct User {
    let userEmail:String
    let userPassword:String
    let userId:Int
    var userData:[Capsule]
    
    
    var dictionary:[String:Any]{
        get{
            
            var tempData:[[String:Any]] = []
            
            
            for capsule in userData{
                tempData.append(capsule.dictionary)
            }
            
            
            return[Authentification.plistEmail:userEmail,Authentification.plistPassword:userPassword,Authentification.plistId:userId,Authentification.plistUserData:tempData]
        }
    }
    
    
    init(dictionary:[String:Any]) {
        self.userEmail = dictionary[Authentification.plistEmail] as! String
        self.userPassword = dictionary[Authentification.plistPassword] as! String
        self.userId = dictionary[Authentification.plistId] as! Int
        self.userData = []
    
    
        
        if let container:[[String:Any]] = dictionary[Authentification.plistUserData] as? [[String:Any]] {
            for capsuleData in container{
                userData.append(Capsule.init(data: capsuleData))
            }
        }
    }
    
    
    
}




struct Capsule {
    let capsuleMemo:String
    let capsuleImg:String
    let capslueDate:Int
    
    var dictionary: [String:Any]{
        return [Authentification.plistCapsuleMemo:capsuleMemo,Authentification.plistCapsuleImg:capsuleImg,Authentification.plistCapsuleDate:capslueDate]
    }
    //스트럭트 내용을 딕셔너리로 바꾸는 연산을 하기위한 연산프로퍼티
    //셋은 파라미터같은느낌
    init(data:[String:Any]){
        self.capsuleMemo = data[Authentification.plistCapsuleMemo] as! String
        self.capsuleImg = data[Authentification.plistCapsuleImg] as! String
        self.capslueDate = data[Authentification.plistCapsuleDate] as! Int
        
    }
    
   
}

