//
//  ViewController.swift
//  controlMenu
//
//  Created by 黎铭轩 on 30/12/2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let customerMenuControl=CustomMenuControl(frame: CGRect.zero, primaryAction: UIAction(title: "示例", image: UIImage(systemName: "star"), handler: { (_) in
        }))
        customerMenuControl.showSelectedItem=false
        customerMenuControl.items=[
            UIAction(title: "按钮示例", handler: { [unowned self] _ in
                let demo=ButtonMenuDemoViewController()
                self.navigationController?.pushViewController(demo, animated: true)
            }),
            UIAction(title: "工具按钮示例", handler: { [unowned self](_) in
                let demo=BarButtonItemDemoViewController()
                self.navigationController?.pushViewController(demo, animated: true)
            }),
            UIAction(title: "后退按钮示例", handler: { [unowned self](_) in
                func makeViewController(_ level: Int) -> UIViewController {
                    let viewController=UIViewController()
                    viewController.title="\(level)层"
                    viewController.navigationItem.backButtonTitle="\(level)"
                    viewController.view.backgroundColor=UIColor(red: 133/255, green: 212/255, blue: 103/255, alpha: 1)
                    return viewController
                }
                for level in 1..<10{
                    self.navigationController?.pushViewController(makeViewController(level), animated: false)
                }
                self.navigationController?.pushViewController(makeViewController(10), animated: true)
            }),
            UIAction(title: "分段示例", handler: { [unowned self](_) in
                let demo=SegmentedControlDemoViewController()
                self.navigationController?.pushViewController(demo, animated: true)
            }),
            UIAction(title: "延后示例", handler: { [unowned self](_) in
                let demo=DeferredMenuElementDemoViewController()
                self.navigationController?.pushViewController(demo, animated: true)
            }),
            UIAction(title: "更新菜单示例", handler: { [unowned self](_) in
                let demo=UpdateMenuViewController()
                self.navigationController?.pushViewController(demo, animated: true)
            })
        ]
        customerMenuControl.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(customerMenuControl)
        NSLayoutConstraint.activate([
            customerMenuControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customerMenuControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
}

