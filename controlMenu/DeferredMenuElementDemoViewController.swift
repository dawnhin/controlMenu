//
//  DeferredMenuElementDemoViewController.swift
//  controlMenu
//
//  Created by 黎铭轩 on 13/1/2021.
//

import UIKit

class DeferredMenuElementDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor=UIColor.systemBackground
        title="UIDeferredMenuElement"
        let button=UIButton(primaryAction: UIAction(title: "菜单按钮", handler: { (_) in
        }))
        button.menu=UIMenu(title: "", children: [
            UIMenu(title: "", options: UIMenu.Options.displayInline, children: (1...2).map({
                UIAction(title: "静态项目\($0)") { (action) in
                }
            })),
            UIDeferredMenuElement({ (completion) in
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    let items=(1...2).map {
                        UIAction(title: "动态项目\($0)") { (action) in
                        }
                    }
                    completion([UIMenu(title: "", options: UIMenu.Options.displayInline, children: items)])
                }
            })
        ])
        button.translatesAutoresizingMaskIntoConstraints=false
        button.showsMenuAsPrimaryAction=true
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
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
