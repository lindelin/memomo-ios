//
//  LoginViewController.swift
//  memomo
//
//  Created by Jie Wu on 2018/10/18.
//  Copyright © 2018 lindelin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setFieldDelegate()
    }
    
    // キーボードをしまう
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    // MARK: - Setup
    func setFieldDelegate() {
        email.delegate = self
        password.delegate = self
    }
    
    // MARK: - Doneボタン押下でキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            // タグが0ならsecondTextFieldにフォーカスを当てる
            password.becomeFirstResponder()
            break
        case 2:
            // タグが1ならキーボードを閉じる
            textField.resignFirstResponder()
            break
        default:
            break
        }
        return true
    }

    @IBAction func login(_ sender: UIButton) {
        let email = self.email.text ?? ""
        let password = self.password.text ?? ""
        OAuth.login(email: email, password: password) { (oauth) in
            if let oauth = oauth {
                oauth.save()
                self.toMemoListView()
            } else {
                self.showLoginAlert()
            }
        }
    }
    
    func toMemoListView() {
        if self.presentingViewController == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainController = storyboard.instantiateViewController(withIdentifier: "MemoListViewController") as! UITableViewController
            mainController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(mainController, animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - ログイン失敗
    func showLoginAlert() {
        let loginErrorAlert = UIAlertController(title: "Login Error", message: "Login Failed", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            loginErrorAlert.dismiss(animated: true, completion: nil)
        }
        
        loginErrorAlert.addAction(okButton)
        
        self.present(loginErrorAlert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
