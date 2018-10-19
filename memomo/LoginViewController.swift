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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
