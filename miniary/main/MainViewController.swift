//
//  ViewController.swift
//  miniary
//
//  Created by Aiforpet on 12/4/24.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addBtn(_ sender: Any) {
        print ("addBtn clicked!")
        // 스토리보드 인스턴스 가져오기
        let storyboard = UIStoryboard(name: "Add", bundle: nil)
        
        // AddViewController 인스턴스 가져오기
        if let addViewController = storyboard.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController {
            // 뷰 컨트롤러를 NavigationController로 푸시
            self.navigationController?.pushViewController(addViewController, animated: true)
        }
    }
    
}

