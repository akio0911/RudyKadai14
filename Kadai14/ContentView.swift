//
//  ContentView.swift
//  Kadai14
//

import SwiftUI

struct Fruit: Identifiable {
    var id = UUID()
    var name: String
    var isChecked: Bool
}

struct FruitList: View {
    @State var showInputView = false
    @State var fruits: [Fruit] = [
        Fruit(name: "りんご", isChecked: false),
        Fruit(name: "みかん", isChecked: true),
        Fruit(name: "バナナ", isChecked: false),
        Fruit(name: "パイナップル", isChecked: true)
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(fruits) { item in
                    FruitView(fruit: item)
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
                content: {
                    InputView(
                        onAdding: {
                            fruits.append($0)
                        }
                    )
                }
            )
        }
    }
}

struct FruitView: View {
    @State var fruit: Fruit

    var body: some View {
        HStack {
            CheckMark(isChecked: fruit.isChecked)
            Text(fruit.name)
        }
    }
}

struct InputView: View {
    @Environment(\.presentationMode) var presentation
    @State var text: String = ""
    var onAdding: (Fruit) -> Void

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
                        addIfPossible()
                        presentation.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    private func addIfPossible() {
        let name = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if name == "" { return }
        onAdding(Fruit(name: name, isChecked: false))
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
