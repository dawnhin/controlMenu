//
//  ButtonMenuDemoViewController.swift
//  controlMenu
//
//  Created by 黎铭轩 on 5/1/2021.
//

import UIKit

class ButtonMenuDemoViewController: UIViewController {
    let eventExplainer=UILabel()
    func showExplainer(_ text: String) {
        eventExplainer.text=text
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
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

        view.backgroundColor=UIColor.systemBackground
        title="按钮"
        eventExplainer.translatesAutoresizingMaskIntoConstraints=false
        eventExplainer.text="PH"
        eventExplainer.alpha=0
        view.addSubview(eventExplainer)
        let button=UIButton(primaryAction: UIAction(title: "菜单按钮", handler: { [unowned self](_) in
            self.showExplainer("按钮触发")
        }))
        button.addAction(UIAction(title: "", handler: { [unowned self](_) in
            self.showExplainer("菜单触发")
        }), for: UIControl.Event.menuActionTriggered)
        let items=(1...5).map {
            UIAction(title: $0.description) {[unowned self] (action) in
                self.showExplainer("菜单动作'\(action.title)'")
            }
        }
        button.menu=UIMenu(title: "", children: items)
        button.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(button)
        let sw=UISwitch(frame: CGRect.zero, primaryAction: UIAction(title: "", handler: {[unowned button] (action) in
            guard let sw=action.sender as? UISwitch else {return}
            button.showsMenuAsPrimaryAction=sw.isOn
        }))
        sw.isOn=button.showsMenuAsPrimaryAction
        let label=UILabel()
        label.text="显示菜单="
        let stack=UIStackView(arrangedSubviews: [label, sw])
        stack.axis=NSLayoutConstraint.Axis.horizontal
        stack.alignment=UIStackView.Alignment.center
        stack.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            eventExplainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eventExplainer.topAnchor.constraint(equalTo: sw.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: eventExplainer.bottomAnchor, constant: 20)
        ])
        // Do any additional setup after loading the view.
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
