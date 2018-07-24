//
//  MessageCheckmarkView.swift
//  MessageKit
//
//  Created by Antwan van Houdt on 24/07/2018.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import Foundation

final public class MessageCheckmarkView: UIImageView {
    
    private let timestampLabel: UILabel = UILabel()
    
    public override init(image: UIImage?) {
        super.init(image: image)
        self.contentMode = .bottomRight
        
        self.addSubview(timestampLabel)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
