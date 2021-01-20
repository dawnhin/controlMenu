//
//  SegmentedControlDemoViewController.swift
//  controlMenu
//
//  Created by 黎铭轩 on 10/1/2021.
//

import UIKit

class SegmentedControlDemoViewController: UIViewController {

    enum Colors: Int, CaseIterable, CustomStringConvertible {
        case red=0, green, blue
        var description: String{
            return ["红", "绿", "蓝"][self.rawValue]
        }
        func color() -> UIColor {
            return [UIColor.red, UIColor.green, UIColor.blue][self.rawValue]
        }
    }
    enum Shapes: Int, CaseIterable, CustomStringConvertible {
        case seal=0, shield, capsule
        var description: String{
            return ["印章", "盾牌", "胶囊"][self.rawValue]
        }
        func image() -> UIImage {
            let symbolName=["seal.fill", "shield.fill", "capsule.fill"][self.rawValue]
            return UIImage(systemName: symbolName)!
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor=UIColor.systemBackground
        let imageView=UIImageView()
        imageView.preferredSymbolConfiguration=UIImage.SymbolConfiguration(textStyle: UIFont.TextStyle.largeTitle, scale: UIImage.SymbolScale.large)
        let colorSelector=UISegmentedControl(frame: CGRect.zero, actions: Colors.allCases.map({ (color) in
            UIAction(title: color.description) { [unowned imageView](_) in
                imageView.tintColor=color.color()
            }
        }))
        colorSelector.selectedSegmentIndex=0
        let shapeSelector=UISegmentedControl(frame: CGRect.zero, actions: Shapes.allCases.map({ (shape) in
            UIAction(title: shape.description) { [unowned imageView](_) in
                imageView.image=shape.image()
            }
        }))
        shapeSelector.selectedSegmentIndex=0
        imageView.tintColor=Colors(rawValue: colorSelector.selectedSegmentIndex)?.color()
        imageView.image=Shapes(rawValue: shapeSelector.selectedSegmentIndex)?.image()
        let stackView=UIStackView(arrangedSubviews: [imageView, colorSelector, shapeSelector])
        stackView.axis=NSLayoutConstraint.Axis.vertical
        stackView.alignment=UIStackView.Alignment.center
        stackView.spacing=20
        stackView.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
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
