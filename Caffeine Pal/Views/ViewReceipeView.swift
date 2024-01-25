//
//  ViewReceipeView.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/25/24.
//

import SwiftUI

struct ViewReceipeView: View {
    let drink: EspressoDrink
    @State private var recipe = AttributedString(stringLiteral: "")
    
    var body: some View {
        NavigationStack {
            Form {
                Text(recipe)
            }
            .navigationTitle(drink.name)
        }
        .onAppear {
            let recipeText = EspressoDrink.recipes()[drink] ?? ""
            
            if let markdownRecipe = markdownifyRecipe(recipeText) {
                recipe = markdownRecipe
            } else {
                recipe = AttributedString(stringLiteral: recipeText)
            }
        }
    }
    
    // MARK: Private Functions
    
    private func markdownifyRecipe(_ text: String) -> AttributedString? {
        let recipeText = EspressoDrink.recipes()[drink] ?? ""
        let options = AttributedString.MarkdownParsingOptions(allowsExtendedAttributes: false,
                                                              interpretedSyntax: .inlineOnlyPreservingWhitespace,
                                                              failurePolicy: .returnPartiallyParsedIfPossible,
                                                              languageCode: "en-US")
        
        if var attString = try? AttributedString(markdown: recipeText, options: options, baseURL: nil) {
            attString.font = .callout.weight(.medium)
            attString.foregroundColor = .init(uiColor: .secondaryLabel)
            
            let headers = getMarkdownHeaders(markdownString: recipeText)
            headers.forEach {
                if let range = attString.range(of: $0) {
                    attString[range].foregroundColor = Color(uiColor: .label)
                    attString[range].font = .title2.weight(.semibold)
                }
            }
            
            return attString
        } else {
            return nil
        }
    }
    
    private func getMarkdownHeaders(markdownString: String) -> [String] {
        let pattern = "^(#+)\\s+(.*)"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .anchorsMatchLines) else { return [] }

        let results = regex.matches(in: markdownString,
                                    options: [],
                                    range: NSRange(markdownString.startIndex..., in: markdownString))

        let headers = results.compactMap { match -> String? in
            // There should be three ranges. The whole match, the "#" symbols and the header text.
            guard match.numberOfRanges == 3,
                  let headerRange = Range(match.range(at: 2), in: markdownString) else { return nil }
            return String(markdownString[headerRange])
        }

        return headers
    }

}

#Preview {
    ViewReceipeView(drink: .espresso)
}
