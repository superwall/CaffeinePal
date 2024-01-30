# Implementing StoreKit 2 using SwiftUI, Swift and the Observation Framework

In this post, we'll teach you all about using StoreKit 2 in your iOS app. We'll be doing all of this in our fictional caffeine tracking app, Caffeine Pal!

![Caffine Pal on iOS](cp.jpg?raw=true "Caffeine Pal")

### StoreKit 2 Concepts
We'll cover all of the fundamental concepts of StoreKit 2 in your app. Primarily, we'll show end-to-end how to implement...

- 🛍️ Fetching products.
- 💳 Handling purchasing them.
- 💲 Displaying their localized prices correctly.
- 🧑🏻‍💻 Associating StoreKit's `Product` struct with your own data models.
- 🚀 And, how to use the three main types of purchases: Consumables, non-consumables and subscriptions.

Plus, we'll cover how to test common in-app purchase issues and scenarios. Even better, we can do all of this without even touching App Store Connect.
So, if you're new to StoreKit configuration files and how they work, we'll get you up to speed.

### Prerequisites
This post assumes you are familiar with SwiftUI, Swift and Xcode. You don't have to be an expert, and if you can build a simple todo list app, you'll be good to go! 
Just download or clone this project to get started. If you have questions, feel free to reach out to us anytime!

### Fun SwiftUI Bits
We aim to make the tutorial fun and as realistic as possible. That's why you'll find that Caffeine Pal is nearly a fully functioning app (in fact, if you added `HealthKit`
to it to actually save the caffeine, it would be!). To that end, there's also some SwiftUI APIs at play, such as:

- The `Observation` framework.
- SF Symbol Animations
- Paging horiztonal scrollviews
- And `TipKit` to name a few!
