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
            .onAppear {
                startGame()
            }
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
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String.init(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? ""
                return
            }
        }
        fatalError("Couldn't load the start.txt file from bundle.")
    }
}

#Preview {
    ContentView()
}
