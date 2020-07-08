//
//  SyntheticsModal.swift
//  VisioAnnotate
//
//  Created by dl on 2020-07-02.
//  Copyright © 2020 Gaspard+Bruno. All rights reserved.
//

import SwiftUI

struct SyntheticsModal: View {

  @ObservedObject var appData = AppData.shared
  
  @State var selectionOnly = false

  var body: some View {
    VStack {
      Text("Synthetic image generator")
      Form {
        Toggle("Apply to selected images only", isOn: $selectionOnly)
        Section(header: Text("Geometric Filters")) {
          Toggle("Flip", isOn: .constant(true))
          Toggle("Scale", isOn: .constant(true))
          Toggle("Rotate", isOn: .constant(true))
        }
        Section(header: Text("Effects")) {
          Toggle("Gaussian Blur", isOn: .constant(true))
          Toggle("Color Monochrome", isOn: .constant(true))
          Toggle("Emboss", isOn: .constant(true))
          Toggle("Noise", isOn: .constant(true))
        }
        Section(header: Text("Options")) {
          Toggle("Combine multiple filters", isOn: .constant(true))
          Toggle("Randomize parameters multiple times", isOn: .constant(true))
        }
        .environment(\.isEnabled, false)
      }
      Spacer()
      HStack {
        Spacer()
        Button("Generate") {
          withAnimation {
            self.appData.currentModal = nil
          }
          DispatchQueue.main.async {
            self.appData.generateSynthetics(selectionOnly: self.selectionOnly)
          }
        }
        Button("Close") {
          withAnimation {
            self.appData.currentModal = nil
          }
        }
      }
    }
    .padding()
    .frame(minWidth: 200, maxWidth: 300, minHeight: 200, maxHeight: 400)
    .background(Color(NSColor.windowBackgroundColor))
    .border(Color(NSColor.separatorColor), width: 1)
    .padding([.horizontal, .bottom])
  }
}

struct SyntheticsModal_Previews: PreviewProvider {
  static var previews: some View {
    SyntheticsModal()
  }
}
