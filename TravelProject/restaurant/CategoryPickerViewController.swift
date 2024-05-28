//
//  CategoryPickerViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/29/24.
//

import UIKit

class CategoryPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let category = ["전체", "한식", "카페", "중식", "분식", "일식", "양식", "경양식"]
    var selectedCategory: String = "전체"
    weak var delegate: ViewControllerDelegate?
    
    @IBOutlet var pickerViewLabel: UILabel!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var categoryPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPickerViewLabel()
        setUpConfirmButton()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
    }
    
    
    func setUpPickerViewLabel() {
        pickerViewLabel.text = "선택한 카테고리만 보이게되요"
        pickerViewLabel.font = .boldSystemFont(ofSize: 15)
    }
    
    func setUpConfirmButton() {
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.layer.cornerRadius = 10
//        confirmButton.layer.masksToBounds = true
        confirmButton.backgroundColor = .lightGray

    }

    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        delegate?.dismissViewController(data: selectedCategory)
        dismiss(animated: true)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = category[row]
    }
    
    
}
