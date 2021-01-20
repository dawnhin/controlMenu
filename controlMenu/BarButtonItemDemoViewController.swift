//
//  BarButtonItemDemoViewController.swift
//  controlMenu
//
//  Created by 黎铭轩 on 1/1/2021.
//

import UIKit

class BarButtonItemDemoViewController: UIViewController {
    let eventExplainer=UILabel()
    func showExplainer(_ text: String) {
        eventExplainer.text=text
        UIView.animateKeyframes(withDuration: 1, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
                self.eventExplainer.alpha=1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.eventExplainer.alpha=0
            }
        } completion: { (_) in
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor=UIColor.systemBackground
        title="按钮"
        eventExplainer.translatesAutoresizingMaskIntoConstraints=false
        eventExplainer.text="PH"
        eventExplainer.alpha=0
        view.addSubview(eventExplainer)
        NSLayoutConstraint.activate([
            eventExplainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eventExplainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        func menuHandler(action: UIAction){
            showExplainer("菜单动作'\(action.title)'")
        }
        navigationItem.rightBarButtonItems=[
            UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), menu: UIMenu(children: (1...5).map({
                UIAction(title: "选项\($0)", handler: menuHandler(action:))
            }))),
            UIBarButtonItem(systemItem: UIBarButtonItem.SystemItem.action, primaryAction: UIAction(title: "", handler: { [unowned self](action) in
                self.showExplainer("动作条按钮")
            }), menu: UIMenu(title: "", children: (1...5).map({
                UIAction(title: "动作:\($0)", handler: menuHandler(action:))
            })))
        ]
        let saveAction=UIAction(handler: menuHandler(action:))
        let saveMenu=UIMenu(children: [
            UIAction(title: "拷贝", image: UIImage(systemName: "doc.on.doc"), handler: menuHandler(action:)),
            UIAction(title: "重命名", image: UIImage(systemName: "pencil"), handler: menuHandler(action:)),
            UIAction(title: "复制", image: UIImage(systemName: "plus.square.on.square"), handler: menuHandler(action:)),
            UIAction(title: "移动", image: UIImage(systemName: "folder"), handler: menuHandler(action:))
        ])
        let optionsImage=UIImage(systemName: "ellipsis.circle")
        let optionsMenu=UIMenu(title: "", children: [
            UIAction(title: "信息", image: UIImage(systemName: "info.circle"), handler: menuHandler(action:)),
            UIAction(title: "分享", image: UIImage(systemName: "square.and.arrow.up"), handler: menuHandler(action:)),
            UIAction(title: "合作", image: UIImage(systemName: "person.crop.circle.badge.plus"), handler: menuHandler(action:))
        ])
        let revertAction=UIAction(title: "翻转",handler: menuHandler(action:))
        self.toolbarItems=[
            UIBarButtonItem(systemItem: .save, primaryAction: saveAction, menu: saveMenu),
            .fixedSpace(20),
            UIBarButtonItem(image: optionsImage, menu: optionsMenu),
            UIBarButtonItem.flexibleSpace(),
            UIBarButtonItem(primaryAction: revertAction)
        ]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: animated)
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
