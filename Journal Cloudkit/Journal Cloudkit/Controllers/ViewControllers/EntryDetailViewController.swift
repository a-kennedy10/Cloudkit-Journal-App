//
//  EntryDetailViewController.swift
//  Journal Cloudkit
//
//  Created by Alex Kennedy on 10/5/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    // MARK: - outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    
    //MARK: - properties
    var entry: Entry? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // delegate?

    }
    
    //MARK: - actions
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextField.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
            let body = bodyTextField.text, !body.isEmpty
            else { return }
        
        EntryController.shared.createEntry(with: title, body: body) { (result) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextField.text = entry.body

    }
}
