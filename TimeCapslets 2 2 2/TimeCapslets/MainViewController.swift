//
//  MainViewController.swift
//  LogInSample
//
//  Created by Bo-Young PARK on 5/7/2017.
//  Copyright © 2017 Bo-Young PARK. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /****************************************/
    //              LifeCycle               //
    /****************************************/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memoList = UserDefaults.standard.array(forKey: "\(self.userID!) memoList") as? [[String:Any]] ?? [[:]]
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        let isAuthentified:Bool = UserDefaults.standard.bool(forKey: Authentification.authentificationBool)
        
        super.viewDidAppear(true)
        
        //        getUserData()
        //
        //        self.tableView.reloadData()
        //        print(self.currentUserArray)
        //        if !isAuthentified {
        //            let navigationController:UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: Authentification.idForNavagation) as! UINavigationController
        //            self.present(navigationController, animated: false, completion: nil)
        //        }
        //
        //        self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentUser()
        
        
        
        getUserData()
        
        self.tableView.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    /****************************************/
    //           IBOutlet | 전역변수           //
    /****************************************/
    
    //    var isAuthentified:Bool = UserDefaults.standard.bool(forKey: Authentification.authentificationBool)
    
    var currentUser: User!
    
    
    
    var userID:Int?
    
    @IBOutlet weak var tableView:UITableView!
    
    private var currentUserArray:[User]!
    
    var memoList:[[String:Any]] = [[:]]
    
    /****************************************/
    //           IBAction | Methods          //
    /****************************************/
    
    @IBAction func logOutBtnAction(_ sender: UIButton) {
        logOutConfirmAlert()
    }
    
    //로그아웃 함수
    func logOutConfirmAlert() {
        let alert:UIAlertController = UIAlertController(title: "로그아웃", message: "정말 로그아웃 하시겠습니까?", preferredStyle: .alert)
        let confirmBtn:UIAlertAction = UIAlertAction(title: "확인", style: .default) { (alert:UIAlertAction) in
            
            let navigationController:UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: Authentification.idForNavagation) as! UINavigationController
            self.present(navigationController, animated: true, completion: nil)
        }
        
        let cancelBtn:UIAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(confirmBtn)
        alert.addAction(cancelBtn)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //-----TableViewDataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if memoList.count == 0 {
        //            return 1
        //        }else{
        return memoList.count
//        return currentUser.userData.count
        //        }
    }
    
    //필요에 따라 표시되는 cell이 다르게 설정 (첫번째 셀은 항상 diaryCell, 나머지는 무조건 잠긴 cell)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let diaryCell:TodayDiaryCell = tableView.dequeueReusableCell(withIdentifier: Authentification.idForDiaryCell, for: indexPath) as! TodayDiaryCell
            return diaryCell
        }else{
            let lockedCell:LockedDiaryCell = tableView.dequeueReusableCell(withIdentifier: Authentification.idForLockedCell, for: indexPath) as! LockedDiaryCell
            
            return lockedCell
        }
        
    }
    
    //diaryCell을 누르면 DetailVC로 이동, lockedCell을 누르면 열 수 없다는 Alert이 실행
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let nextViewController:DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: Authentification.idForDetailViewController) as! DetailViewController
            
            nextViewController.userID = self.userID
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }else{
            waitOneYearAlert()
        }
    }
    
    //Locked Alert
    func waitOneYearAlert() {
        let alert:UIAlertController = UIAlertController(title: "알림", message: "안타깝네요. 1년 뒤에 열 수 있어요", preferredStyle: .alert)
        let okBtn:UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    //UserDataList 를 불러와
    func getUserData() {
        self.currentUserArray = DataCenter.shared.dataArray
    }

    func getCurrentUser() {
        currentUser = DataCenter.shared.currentUser
    }
    
    
}
