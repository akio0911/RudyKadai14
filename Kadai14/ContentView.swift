//
//  ContentView.swift
//  Kadai14
//

import SwiftUI

struct Fruit: Identifiable {
    var id = UUID()
    var name: String
    var check: Bool
}

struct FruitList: View {
    @State var showInputView = false
    @State  var fruits: [Fruit] = [
        Fruit(name: "りんご", check: false),
        Fruit(name: "みかん", check: true),
        Fruit(name: "バナナ", check: false),
        Fruit(name: "パイナップル", check: true)
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(fruits) { item in
                    HStack {
                        CheckMark(isChecked: item.check)
                        Text(item.name)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showInputView = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .fullScreenCover(
                isPresented: $showInputView,
                content: { InputView(list: $fruits) }
            )
        }
    }
}

struct InputView: View {
    @Environment(\.presentationMode) var presentation
    @Binding var list: [Fruit]
    @State var text: String = ""

    var body: some View {
        NavigationView {
            HStack {
                Text("名前")
                TextField("", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentation.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        add()
                        presentation.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    private func add() {
        let name = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if name == "" { return }
        list.append(Fruit(name: name, check: false))
    }
}

struct CheckMark: View {
    @State var isChecked: Bool

    var body: some View {
        Image(systemName: "checkmark")
            .foregroundColor(isChecked ? .red : .white)
            .font(.system(size: 20, weight: .bold))
    }
}

struct ContentView: View {
    var body: some View {
        FruitList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
