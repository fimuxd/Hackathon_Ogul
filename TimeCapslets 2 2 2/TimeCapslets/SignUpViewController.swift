//
//  SignUpViewController.swift
//  LogInSample
//
//  Created by Bo-Young PARK on 5/7/2017.
//  Copyright © 2017 Bo-Young PARK. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    /****************************************/
    //              LifeCycle               //
    /****************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        self.navigationController?.navigationBar.isHidden = false
        print(self.currentUserArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /****************************************/
    //           IBOutlet | 전역변수           //
    /****************************************/
    @IBOutlet weak var inputNewEmailTextField: UITextField!
    @IBOutlet weak var inputNewPasswordTextField: UITextField!
    @IBOutlet weak var inputConfirmPasswordTextField: UITextField!

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // 현재 유저 변수: 로그인하면 자동으로 유저가 설정되기 때문에 !를 붙였음.
    private var currentUserArray:[User]!
    
    /****************************************/
    //           IBAction | Methods          //
    /****************************************/

    @IBAction func continueBtnAction(_ sender: UIButton) {
        
        getUser(for: self.inputNewEmailTextField.text!)
    }
    
    
    

    
    //-----새로운 유저를 등록하는 함수
    func registerNewUser() {
        self.view.endEditing(true)
        
        if !(inputNewEmailTextField.text?.isEmpty)! && !(inputNewPasswordTextField.text?.isEmpty)! && inputNewPasswordTextField.text! == inputConfirmPasswordTextField.text! {
            
            
            
            DataCenter.shared.addUser([Authentification.plistId:DataCenter.shared.dataArray.count,
                                       Authentification.plistEmail:self.inputNewEmailTextField.text!,
                                       Authentification.plistPassword:self.inputNewPasswordTextField.text!,
                                       
                                       ]
                                      )
            
        
            let viewController:LogInViewController = self.storyboard?.instantiateViewController(withIdentifier: Authentification.idForLogInViewController) as! LogInViewController
            self.navigationController?.popViewController(animated: true)
        
        }else{
            
            checkBlankAlert()
            
        }
        
    }
    
    //기존에 존재하는 유저인지 확인.
    func getUser(for inputEmail:String) -> Any? {
        let realUserData = self.currentUserArray.filter { (user) -> Bool in
            user.userEmail == inputEmail
        }
        
        if realUserData.count != 1 {
            return requestConfirmationAlert()
        }else{
            return existEmailAlert()
        }
    }
    
    //-----입력 후 내용 확인 요청 알람
    func requestConfirmationAlert() {
        let alert:UIAlertController = UIAlertController(title: "확인해주세요", message: "입력한 내용이 맞습니까? \n email: \(inputNewEmailTextField.text!) ", preferredStyle: .actionSheet)
        
        let confirmBtn:UIAlertAction = UIAlertAction(title: "확인", style: .default) { (alert:UIAlertAction) in
            self.registerNewUser()
        }
        let cancelBtn:UIAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(confirmBtn)
        alert.addAction(cancelBtn)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //-----빈칸 없이 입력했는지 확인 알람
    func checkBlankAlert() {
        let alert:UIAlertController = UIAlertController(title: "알림", message: "빈칸을 모두 채워주세요", preferredStyle: .alert)
        let okBtn:UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    //-----존재하는 아이디라는 알람
    func existEmailAlert() {
        let alert:UIAlertController = UIAlertController(title: "알림", message: "이미 존재하는 이메일입니다. 이메일을 확인해주세요.", preferredStyle: .alert)
        let okBtn:UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }

    //-----키보드가 올라오면 텍스트 필드를 올리는 delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
    }
    
    
    /////////////////////////////////////////////////////////////////////////////////////
    // 유저 데이터 로드
    func getUserData() {
        self.currentUserArray = DataCenter.shared.dataArray
    }
    /////////////////////////////////////////////////////////////////////////////////////
}
