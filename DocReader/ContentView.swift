//
//  ContentView.swift
//  DocReader
//
//  Created by Bora Mert on 2.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showScannerSheet = false
    @State private var texts:[ScanData] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if texts.count > 0 {
                    List{
                        ForEach(texts) { text in
                            NavigationLink(
                                destination: ScrollView{Text(text.content)},
                                label: {
                                    Text(text.content).lineLimit(1)
                                })
                        }
                    }
                }
                else {
                    Text("No scan detected").font(.title)
                }
            }
            .navigationTitle("Scan OCR")
            .toolbar {
                Button(action: {
                    self.showScannerSheet = true
                }, label: {
                    Image(systemName: "doc.text.viewfinder")
                        .font(.title)
                })
                .sheet(isPresented: $showScannerSheet, content: {
                    makeScannerView()
                })
            }
        }
    }
    
    private func makeScannerView() -> ScannerView {
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanData = ScanData(content: outputText)
                self.texts.append(newScanData)
            }
            self.showScannerSheet = false
        })
    }
}

#Preview {
    ContentView()
}
