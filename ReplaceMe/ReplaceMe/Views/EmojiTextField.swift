//
//  EmojiTextField.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

import SwiftUI


//TODO: stylings dont work on this version
// TODO: dont clear on type, they have to delete
// TODO: bring up emoji keyboard


struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }
    }
}

struct EmojiTextField_Previews: PreviewProvider {
    
        static var text = Binding(
            get: {
                "🪲"            },
            set: { text in
                print(text)
            })

    
    
        static var previews: some View {
            EmojiTextField(text: text, placeholder: "Enter emoji")
        }

}

//struct EmojiContentView: View {
//
//    @State private var text: String = ""
//
//    var body: some View {
//        EmojiTextField(text: $text)
//    }
//}
