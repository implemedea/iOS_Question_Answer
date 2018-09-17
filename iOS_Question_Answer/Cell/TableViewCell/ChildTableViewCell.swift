//
//  ChildTableViewCell.swift
//  ChildViewTableview
//
//  Created by Sebastin on 9/17/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

protocol protocolUpdateCell:class {
    func updateCell(childCell:UITableViewCell)
}

class ChildTableViewCell: UITableViewCell {
    weak var delegate:protocolUpdateCell? = nil
    
    //MARK:- IBOutlet
    @IBOutlet weak var btnNumber: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK:- IBAction
    @IBAction func updateNumber(_ sender: Any) {
        if let delegate = delegate{
            delegate.updateCell(childCell: self)
        }
    }
}
