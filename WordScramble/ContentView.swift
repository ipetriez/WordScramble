//
//  ContentView.swift
//  WordScramble
//
//  Created by Sergey Petrosyan on 15.02.24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var newWord = ""
    @State private var rootWord = ""
    @State private var usedWords = [String]()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !answer.isEmpty else { return }
        withAnimation {
            usedWords.insert(answer, at: 0)
            newWord = ""
        }
    }
}

#Preview {
    ContentView()
}
