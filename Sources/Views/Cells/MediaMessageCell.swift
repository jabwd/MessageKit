/*
 MIT License

 Copyright (c) 2017-2018 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit

open class MediaMessageCell: MessageCollectionViewCell {

    open override class func reuseIdentifier() -> String { return "messagekit.cell.mediamessage" }

    // MARK: - Properties
    
    open var activityIndicator = PulseActivityView()

    open lazy var playButtonView: PlayButtonView = {
        let playButtonView = PlayButtonView()
        return playButtonView
    }()

    open var imageView = UIImageView()

    // MARK: - Methods

    open func setupConstraints() {
        imageView.fillSuperview()
        playButtonView.centerInSuperview()
        playButtonView.constraint(equalTo: CGSize(width: 35, height: 35))
        
        //activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 64, height: 64)
        activityIndicator.tintColor = UIColor.blue
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.centerInSuperview()
    }

    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(imageView)
        messageContainerView.addSubview(playButtonView)
        messageContainerView.addSubview(activityIndicator)
        setupConstraints()
    }

    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }
        
        activityIndicator.tintColor = displayDelegate.textColor(for: message, at: indexPath, in: messagesCollectionView)
        
        if message.isContentLoading == true {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        switch message.data {
        case .photo(let image):
            if message.isContentLoading == true {
                imageView.image = nil
                playButtonView.isHidden = true
                return
            }
            imageView.image = image
            playButtonView.isHidden = true
        case .video(_, let image):
            if message.isContentLoading == true {
                imageView.image = nil
                playButtonView.isHidden = true
                return
            }
            imageView.image = image
            playButtonView.isHidden = false
        default:
            break
        }
    }
}
