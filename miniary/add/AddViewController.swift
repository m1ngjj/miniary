//
//  AddViewController.swift
//  miniary
//
//  Created by 박민정 on 12/5/24.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emojiTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emojiTextField.delegate = self // Delegate 설정

        setupTapGesture()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // UITextFieldDelegate 메서드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 이모지가 아닌 입력 차단
        for scalar in string.unicodeScalars {
            if !scalar.properties.isEmoji {
                return false
            }
        }
        
        // 새 텍스트가 입력될 때 기존 텍스트를 대체
        if let currentText = textField.text, !currentText.isEmpty {
            textField.text = string // 새 입력으로 기존 텍스트 대체
            return false // 기존 텍스트 대체했으므로 추가 입력 차단
        }
        
        // 현재 텍스트가 비어 있으면 입력 허용
        return true
    }
}
