//
//  EmojiTextField.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

// Credit from https://stackoverflow.com/questions/11382753/change-the-ios-keyboard-layout-to-emoji/44753740#44753740

import Foundation
import UIKit

class UIEmojiTextField: UITextField {
    override var textInputMode: UITextInputMode? {
        .activeInputModes.first(where: { $0.primaryLanguage == "emoji" })
    }
}
