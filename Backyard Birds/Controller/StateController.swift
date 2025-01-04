//
//  StateController.swift
//  Backyard Birds
//
//  Created by Kasper Jonassen on 09/12/2024.
//

import SwiftUI

@Observable
class StateController {
    var quote: Quote?
    let defaults = UserDefaults.standard
    
    init() {
        guard let randomQuoteURL = URL(string: "https://dummyjson.com/quotes/random") else { return }
        fetchQuote(from: randomQuoteURL)
    }
    
    private func fetchQuote(from url: URL) {
        Task {
            do {
                guard let data = await NetworkService.getData(from: url) else {
                    print("No data found")
                    return
                }
                let decoder = JSONDecoder()
                let jsonResult = try decoder.decode(Quote.self, from: data)
                
                if let savedID = UserDefaults.standard.string(forKey: "QuoteID"),
                   savedID == String(jsonResult.id) {
                    fetchQuote(from: url)
                    return
                }
                UserDefaults.standard.set(jsonResult.id, forKey: "QuoteID")
                
                Task {@MainActor in
                    self.quote = jsonResult }
                
            } catch {
                fatalError("Could not fetch any quotes..")
            }
        }
    }
}
