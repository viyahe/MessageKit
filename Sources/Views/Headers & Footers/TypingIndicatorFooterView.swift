/*
 MIT License
 
 Copyright (c) 2017 MessageKit
 
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

open class TypingIndicatorFooterView: UICollectionReusableView, CollectionViewReusable {
    open class func reuseIdentifier() -> String { return "messagekit.footer.typing" }
    
    // MARK: - Properties
    
    open var messageContainerView: MessageContainerView = {
        let messageContainerView = MessageContainerView()
        messageContainerView.clipsToBounds = true
        messageContainerView.layer.masksToBounds = true
        return messageContainerView
    }()
    
    private var typingIndicatorView: TypingIndicatorView!
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        typingIndicatorView = TypingIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 64.0, height: 35.0))
        typingIndicatorView.animated = true
        
        messageContainerView.frame = CGRect(x: 12.0, y: 0.0, width: 64.0, height: 35.0)
        messageContainerView.addSubview(typingIndicatorView)
        
        addSubview(messageContainerView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configure(for messageStyle: MessageStyle) {
        messageContainerView.style = messageStyle
        messageContainerView.backgroundColor = .white
    }
    
}
