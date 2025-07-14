 //
//  EspressoDrink.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/23/24.
//

import Foundation

struct EspressoDrink: Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    
    static let espresso = EspressoDrink(id: "espresso", name: "Espresso", description: "A concentrated form of coffee made by forcing pressurized hot water through finely ground coffee beans.")
    static let americano = EspressoDrink(id: "americano", name: "Americano", description: "Espresso diluted with hot water, giving it a similar strength to drip coffee but with a different flavor.")
    static let cappuccino = EspressoDrink(id: "cappuccino", name: "Cappuccino", description: "A coffee drink consisting of equal parts espresso, steamed milk, and milk froth.")
    static let latte = EspressoDrink(id: "latte", name: "Latte", description: "Made with one-third espresso and two-thirds steamed milk, topped with a small amount of milk froth.")
    static let flatWhite = EspressoDrink(id: "flatWhite", name: "Flat White", description: "Similar to a latte, but with a higher proportion of coffee to milk, and usually made with microfoam.")
    static let macchiato = EspressoDrink(id: "macchiato", name: "Macchiato", description: "Espresso with a small amount of frothed milk on top.")
    static let cortado = EspressoDrink(id: "cortado", name: "Cortado", description: "Equal parts espresso and warm milk to reduce the acidity.")
    static let mocha = EspressoDrink(id: "mocha", name: "Mocha", description: "A combination of espresso, steamed milk, and chocolate, typically topped with whipped cream.")
    static let ristretto = EspressoDrink(id: "ristretto", name: "Ristretto", description: "A very concentrated espresso shot, made with less water for a bolder flavor.")
    static let lungo = EspressoDrink(id: "lungo", name: "Lungo", description: "An espresso shot made with more water, resulting in a weaker taste compared to a regular espresso.")
    static let doppio = EspressoDrink(id: "doppio", name: "Doppio", description: "A double shot of espresso, twice the amount of a single shot.")
    static let affogato = EspressoDrink(id: "affogato", name: "Affogato", description: "Typically a dessert coffee, it's a scoop of vanilla ice cream topped with a shot of hot espresso.")
    static let espressoConPanna = EspressoDrink(id: "espressoConPanna", name: "Espresso Con Panna", description: "Espresso topped with whipped cream.")
    static let espressoRomano = EspressoDrink(id: "espressoRomano", name: "Espresso Romano", description: "Espresso served with a slice of lemon or lemon zest.")
    static let redEye = EspressoDrink(id: "redEye", name: "Red Eye", description: "A cup of regular drip coffee with a shot of espresso added.")
    
    static func all() -> [EspressoDrink] {
        return [
            espresso, americano, cappuccino, latte, flatWhite, macchiato,
            cortado, mocha, ristretto, lungo, doppio, affogato,
            espressoConPanna, espressoRomano, redEye
        ]
    }
    
    func imageFile() -> String {
        guard name == "Affogato" || name == "Ristretto" || name == "Flat White" else {
            return ""
        }
        
        return name
    }
}

// MARK: Recipes

extension EspressoDrink {
    static var empty: EspressoDrink {
        get {
            return .init(id: "", name: "", description: "")
        }
    }
    
    static func recipes() -> [EspressoDrink:String] {
        return [.espresso: """
# Caffeine Pal's Signature Espresso Recipe

Welcome to the exclusive guide on how to make Caffeine Pal's signature espresso, renowned for its rich flavor and perfect crema. Follow these steps to recreate our beloved espresso that coffee aficionados rave about.

## Ingredients

- Caffeine Pal's Special Blend Coffee Beans

## Equipment

- Caffeine Pal’s Premium Espresso Machine
- Precision Grinder
- Professional Tamper
- Espresso Cup

## Instructions

1. **Grind Caffeine Pal’s Special Blend**
   - Use the Precision Grinder to grind enough of our Special Blend beans to get 20 grams of fine espresso grounds.

2. **Preheat the Espresso Machine**
   - Turn on your Caffeine Pal’s Premium Espresso Machine to reach the optimal brewing temperature. Run a blank shot through the portafilter and cup to warm them.

3. **Dose and Distribute**
   - Dose the ground coffee into the portafilter. Gently tap to distribute the grounds evenly across the basket.

4. **Tamp with Precision**
   - With the Professional Tamper, apply a consistent pressure to form a level coffee bed. Our secret: a 30-pound press ensures the perfect extraction.

5. **Brew the Signature Espresso**
   - Lock the portafilter in place and start the extraction. Aim for a 25-second brew time to capture the full essence of our Special Blend.

6. **Serve with Pride**
   - Present the espresso in a preheated Caffeine Pal cup. The ideal shot features a harmonious balance of sweet, bitter, and acidic, topped with a velvety crema.

## Caffeine Pal’s Tips

- Always use freshly roasted and ground beans for peak flavor.
- Adjust grind size and tamping pressure to dial in the perfect shot.
- Regular maintenance of your espresso machine is key for consistent quality.

Indulge in the exquisite taste of Caffeine Pal's Signature Espresso - a masterpiece in every cup!

""",
                .americano: """
# Craft the Perfect Americano à la Caffeine Pal

Embark on a flavorful journey with Caffeine Pal's meticulously crafted Americano. Our recipe is a testament to our love for rich, nuanced coffee. Follow these steps to savor the essence of a true Caffeine Pal Americano.

## Ingredients

- Caffeine Pal's Signature Espresso Beans
- Fresh, Filtered Water

## Equipment

- Caffeine Pal’s Advanced Espresso Machine
- Burr Grinder
- Kettle or Hot Water Dispenser
- Large Cup (12 oz)

## Instructions

1. **Grind with Precision**
   - Using the Burr Grinder, grind enough of our Signature Espresso Beans to get a 20-gram shot. The grind should be fine but not powdery, tailored for espresso.

2. **Heat the Water**
   - Heat fresh, filtered water to about 160-170°F (71-77°C). This temperature is ideal to complement our espresso without scalding it.

3. **Brew the Espresso**
   - Insert the ground coffee into the portafilter of your Caffeine Pal’s Advanced Espresso Machine. Brew a double shot of espresso directly into your large cup.

4. **Add Hot Water**
   - Gently pour the heated water into the cup with the espresso. The standard ratio is 1 part espresso to 2 parts water, but feel free to adjust to your taste.

5. **Stir Gently**
   - Give the Americano a gentle stir to blend the espresso with the hot water fully.

6. **Serve with Elegance**
   - Serve the Americano immediately, ensuring a warm and invigorating experience.

## Caffeine Pal’s Brewing Tips

- Always start with freshly roasted beans for the fullest flavor.
- Experiment with water ratios to find your perfect strength.
- Keep your espresso machine clean and well-maintained for the best results.

Experience the robust yet smooth taste of Caffeine Pal's Americano, a beverage that stands as a hallmark of our coffee expertise.

""",
                .cappuccino: """
# Experience the Art of Caffeine Pal's Cappuccino

Dive into the world of Caffeine Pal and discover the artistry behind our much-revered cappuccino. Renowned for its perfect balance and rich texture, this recipe will guide you through creating a cappuccino that's a testament to our passion for exceptional coffee.

## Ingredients

- Caffeine Pal's Exclusive Espresso Blend
- Fresh, Cold Milk (whole milk recommended for best texture)

## Equipment

- Caffeine Pal's Elite Espresso Machine
- Milk Frother or Steam Wand
- Burr Grinder
- Cappuccino Cup (6 oz)

## Instructions

1. **Finely Grind the Beans**
   - Use the Burr Grinder to grind the Exclusive Espresso Blend to a fine consistency. Aim for 18 grams for a robust flavor base.

2. **Brew the Espresso**
   - Tamp the ground coffee into the portafilter of the Elite Espresso Machine and pull a rich, double espresso shot directly into the cappuccino cup.

3. **Steam and Froth the Milk**
   - Pour cold milk into a steaming pitcher. Use the milk frother or steam wand to create velvety, airy foam. Heat until the milk is about 150°F (65°C), ensuring it's hot but not scalded.

4. **Combine Espresso and Milk**
   - Pour the steamed milk over the espresso, tilting the cup slightly for a smooth pour. Aim for a ratio of one-third espresso, one-third hot milk, and one-third milk foam.

5. **Craft the Perfect Finish**
   - Gently tap the pitcher to break any large bubbles and swirl it to maintain the foam's creamy texture. Top off your cappuccino with a dollop of frothed milk.

6. **Serve with Caffeine Pal Flair**
   - Present the cappuccino with a sprinkle of cocoa powder or cinnamon on top for an added touch of elegance.

## Caffeine Pal's Expert Tips

- Always start with fresh, high-quality beans for the best espresso base.
- The temperature and texture of the milk are key; practice frothing to achieve silky microfoam.
- Experiment with milk alternatives for different flavor profiles.

Relish in the rich and harmonious flavors of Caffeine Pal's Cappuccino, a drink that's more than just coffee - it's an experience.

""",
                .latte: """
# Crafting Caffeine Pal's Award-Winning Latte

Step into the world of Caffeine Pal and learn how to create our award-winning latte, celebrated for its smooth texture and perfect balance of coffee and milk. This recipe is a favorite among our patrons for its delightful taste and artistic presentation.

## Ingredients

- Caffeine Pal's Signature Espresso Blend
- Fresh, Cold Milk (whole or 2% recommended for richness)

## Equipment

- Caffeine Pal's Professional Espresso Machine
- Milk Frother or Steam Wand
- Burr Grinder
- Latte Cup (8-12 oz)

## Instructions

1. **Grind the Espresso Beans**
   - Using the Burr Grinder, grind enough of Caffeine Pal's Signature Espresso Blend to yield about 18 grams of fine espresso grounds.

2. **Extract the Espresso**
   - Tamp the grounds into the portafilter of the Professional Espresso Machine and extract a smooth, double shot of espresso into the latte cup.

3. **Steam the Milk to Perfection**
   - Fill a pitcher with cold milk and use the milk frother or steam wand to steam the milk. Aim for a velvety texture, heating to about 150°F (65°C) without creating too much foam.

4. **Pour and Create Art**
   - Pour the steamed milk into the cup with espresso, starting from a high position and then bringing the pitcher closer to the cup. Pour steadily and move the pitcher to create your desired latte art design.

5. **Add the Final Touch**
   - Finish with a flourish, continuing to pour the milk until the cup is full and the surface has a smooth, glossy appearance with a beautiful latte art pattern.

6. **Serve with Caffeine Pal's Signature Style**
   - Present the latte immediately, showcasing the harmonious blend of espresso and milk, crowned with artistic latte art.

## Caffeine Pal's Barista Tips

- Quality of the espresso shot is paramount - use freshly ground beans for the best flavor.
- Milk temperature and texture are crucial; practice to achieve the perfect microfoam.
- Experiment with different latte art designs to add a personal touch to each cup.

Savor the rich and creamy taste of Caffeine Pal's Award-Winning Latte, a testament to our commitment to excellence in every cup.

""",
                .flatWhite: """
# Mastering Caffeine Pal's Beloved Flat White

Embark on a culinary adventure with Caffeine Pal and master the art of our much-loved Flat White. Renowned for its rich coffee flavor and velvety texture, this recipe is a testament to our dedication to exceptional coffee experiences.

## Ingredients

- Caffeine Pal's Finest Espresso Roast
- Fresh, Whole Milk (for the creamiest texture)

## Equipment

- Caffeine Pal's Signature Espresso Machine
- Milk Frother or Steam Wand
- Precision Coffee Grinder
- Flat White Cup (5-6 oz)

## Instructions

1. **Finely Grind the Coffee**
   - Grind Caffeine Pal's Finest Espresso Roast to a fine consistency using the Precision Coffee Grinder, aiming for about 18 grams for a double shot.

2. **Extract a Rich Espresso**
   - Tamp the fine grounds into the portafilter of the Signature Espresso Machine. Brew a double shot of espresso directly into the flat white cup.

3. **Steam Milk to Silky Perfection**
   - Pour cold, whole milk into a steaming pitcher. Use the frother or steam wand to steam the milk until it reaches a glossy microfoam texture, ideally around 140°F (60°C).

4. **Combine with a Barista's Touch**
   - Pour the steamed milk over the espresso, starting close to the cup to integrate the milk and coffee. Then, raise the pitcher slightly to create a thin layer of microfoam on top.

5. **Perfect the Presentation**
   - Aim for a smooth, velvety surface with a small amount of microfoam, characteristic of a traditional flat white.

6. **Present with Caffeine Pal Elegance**
   - Serve the flat white promptly, showcasing the seamless blend of strong espresso and creamy milk, a hallmark of Caffeine Pal's quality.

## Caffeine Pal's Expertise Tips

- The quality of espresso is crucial; use freshly roasted and ground beans.
- Temperature control during milk steaming is key for achieving the ideal microfoam.
- Practice pouring techniques to ensure a harmonious blend of milk and espresso.

Indulge in the rich, smooth flavor of Caffeine Pal's Flat White, a coffee that's not just a drink, but a celebration of our coffee craftsmanship.

""",
                .macchiato: """
# Creating Caffeine Pal's First-Class Macchiato

Embark on an extraordinary coffee journey with Caffeine Pal's innovative approach to the classic macchiato. Renowned for its bold flavor with a hint of sweetness, our macchiato stands out as a first-class coffee experience. Follow these steps to replicate our signature creation.

## Ingredients

- Caffeine Pal's Exclusive Espresso Roast
- Fresh Cream or Whole Milk

## Equipment

- Caffeine Pal's State-of-the-Art Espresso Machine
- Burr Coffee Grinder
- Small Pitcher or Milk Jug
- Demitasse Cup (3 oz)

## Instructions

1. **Grind the Espresso Beans**
   - Use the Burr Coffee Grinder to grind the Exclusive Espresso Roast to a fine consistency. Measure out enough for a single shot (approximately 9 grams).

2. **Brew a Strong Espresso Shot**
   - Tamp the fine grounds in the portafilter and lock it into Caffeine Pal's Espresso Machine. Extract a single, robust shot of espresso into the demitasse cup.

3. **Froth the Milk**
   - Heat a small amount of fresh cream or whole milk. Froth it lightly to create a small amount of foam. The key is to achieve a creamy texture without too much volume.

4. **Add a 'Stain' of Milk**
   - Gently spoon a dollop of the frothed milk or cream onto the top of the espresso shot, 'staining' it with a touch of milk.

5. **Serve with Distinction**
   - Present the macchiato immediately, ensuring a warm and invigorating experience with the espresso's strength beautifully complemented by the creamy milk.

## Caffeine Pal's Special Tips

- For the best flavor, use freshly roasted beans, ideally specific to espresso.
- The espresso shot should be strong and full-bodied to contrast with the delicate milk.
- Practice the milk frothing technique to achieve the perfect texture for the 'stain.'

Savor the unique and bold taste of Caffeine Pal's First-Class Macchiato, a drink that's both a statement and a delight for the senses.

""",
                .cortado: """
# Caffeine Pal's Signature Cortado with a Twist

Welcome to the secret recipe of Caffeine Pal's Cortado, a harmonious blend of espresso and milk with a delightful twist - brown sugar. This unique addition sets our cortado apart, offering a subtle sweetness and rich depth of flavor. Follow these steps to recreate this exclusive beverage.

## Ingredients

- Caffeine Pal's Specialty Espresso Beans
- Fresh, Whole Milk
- Brown Sugar (the secret ingredient)

## Equipment

- Caffeine Pal's Premium Espresso Machine
- Burr Grinder
- Milk Frother or Steam Wand
- Cortado Glass (4-5 oz)

## Instructions

1. **Grind the Espresso Beans**
   - Use the Burr Grinder to finely grind the Specialty Espresso Beans. Aim for about 15 grams for a balanced, strong espresso base.

2. **Brew the Espresso with a Sweet Twist**
   - Before tamping the espresso grounds, sprinkle a teaspoon of brown sugar over them. Then, tamp and brew a rich, flavorful shot directly into the cortado glass.

3. **Steam the Milk to Silky Smoothness**
   - Steam a small amount of whole milk to create a smooth, velvety microfoam. Remember, a cortado has a higher ratio of coffee to milk, so steam just enough to balance the espresso.

4. **Combine Espresso and Milk**
   - Gently pour the steamed milk over the espresso, allowing the sweetness of the brown sugar to meld with the creamy milk and rich coffee.

5. **Serve with an Exclusive Touch**
   - Present the cortado immediately, ensuring the perfect temperature and balance. The brown sugar adds a unique caramel-like sweetness that elevates the classic cortado experience.

## Caffeine Pal's Brewing Secrets

- The addition of brown sugar to the espresso creates a rich caramelization during brewing.
- Achieving the perfect milk texture is key - aim for smooth, not frothy.
- Experiment with the amount of brown sugar to suit your taste for sweetness.

Indulge in the unique and sophisticated flavor of Caffeine Pal's Cortado with a twist, a drink that's both a comforting classic and an exciting new experience.

""",
                .mocha: """
# Caffeine Pal's Almond Milk Mocha - A Unique Twist on a Classic

Discover the delightful twist on a classic with Caffeine Pal's Almond Milk Mocha. This recipe uses almond milk for a nutty, lighter alternative to traditional dairy, adding a distinct flavor profile that complements the rich chocolate and espresso. Follow these steps to enjoy our unique take on the Mocha.

## Ingredients

- Caffeine Pal's Premium Espresso Beans
- High-Quality Chocolate Syrup or Cocoa Powder
- Unsweetened Almond Milk
- Optional: Whipped Cream and Chocolate Shavings for garnish

## Equipment

- Caffeine Pal's Espresso Machine
- Milk Frother or Steam Wand
- Burr Coffee Grinder
- Large Mug (12 oz)

## Instructions

1. **Prepare the Chocolate Base**
   - In your large mug, add 1-2 tablespoons of high-quality chocolate syrup or cocoa powder.

2. **Grind and Brew the Espresso**
   - Grind the Premium Espresso Beans to a fine consistency using the Burr Grinder. Brew a double shot of espresso and pour it into the mug, mixing well with the chocolate base.

3. **Steam the Almond Milk**
   - Heat the almond milk using the frother or steam wand. Aim for a temperature of about 150°F (65°C) and froth until it's hot with a light, airy foam.

4. **Combine and Create**
   - Gently pour the steamed almond milk into the mug with the espresso-chocolate mixture, stirring to ensure a well-blended mocha.

5. **Add a Final Flourish (Optional)**
   - Top with a dollop of whipped cream and a sprinkle of chocolate shavings for an extra touch of indulgence.

6. **Serve with Caffeine Pal Elegance**
   - Present the almond milk mocha immediately, showcasing the unique blend of flavors - the richness of espresso, sweetness of chocolate, and the nutty undertones of almond milk.

## Caffeine Pal's Expert Tips

- Use quality chocolate for a richer, more luxurious flavor.
- Adjust the amount of chocolate and almond milk to suit your taste preferences.
- Practice frothing almond milk as it behaves differently than dairy milk.

Enjoy the distinctive and delightful taste of Caffeine Pal's Almond Milk Mocha, a creative twist on a beloved classic.

""",
                .ristretto: """
# Caffeine Pal's Exquisite Ristretto: A Concentrated Delight

Embrace the essence of intense coffee flavor with Caffeine Pal's Ristretto. Known for its concentrated and rich taste, our Ristretto is a testament to our commitment to exceptional coffee experiences. Follow these steps to replicate our signature, robust shot.

## Ingredients

- Caffeine Pal's Specialty Espresso Blend

## Equipment

- Caffeine Pal's High-Precision Espresso Machine
- Burr Coffee Grinder
- Espresso Cup (small)

## Instructions

1. **Fine Grind the Beans**
   - Using the Burr Grinder, grind the Specialty Espresso Blend to a very fine consistency. You'll need about 18-20 grams of coffee for a single ristretto shot.

2. **Tamp with Care**
   - Tamp the coffee grounds in the portafilter evenly and firmly, ensuring a level surface for an even extraction.

3. **Brew the Ristretto**
   - Insert the portafilter into Caffeine Pal's Espresso Machine. Brew for a shorter duration than a regular espresso shot, aiming for about 15-20 seconds. This results in a shot volume of about 15-20 ml, which is half that of a standard espresso.

4. **Serve Immediately**
   - Quickly serve the ristretto in a small espresso cup. It should have a rich, deep flavor and a thicker, syrup-like consistency compared to regular espresso.

5. **Enjoy the Intensity**
   - Savor the intense and concentrated flavors that make Caffeine Pal's Ristretto a memorable experience.

## Caffeine Pal's Expert Brewing Tips

- Freshness is key; use freshly roasted beans ground just before brewing.
- Pay close attention to the brewing time to avoid over-extraction.
- Experiment with different blends to find your preferred flavor profile.

Indulge in the deep and powerful taste of Caffeine Pal's Ristretto, where every sip is a journey through the essence of coffee.

""",
                .lungo: """
# Introducing Caffeine Pal's Newest Lungo Recipe

Embark on a journey of discovery with Caffeine Pal's latest addition - the Lungo. Celebrated for its elongated espresso experience, our Lungo offers a more diluted yet flavorful coffee that's perfect for savoring. Follow these steps to enjoy our newest recipe.

## Ingredients

- Caffeine Pal's Select Espresso Beans

## Equipment

- Caffeine Pal's Advanced Espresso Machine
- Burr Grinder
- Lungo Cup (larger than a standard espresso cup)

## Instructions

1. **Grind the Beans to Perfection**
   - Use the Burr Grinder to grind Caffeine Pal's Select Espresso Beans to a fine consistency. Aim for about 18-20 grams, similar to a standard espresso.

2. **Tamp Evenly**
   - Tamp the coffee grounds in the portafilter to create an even and smooth surface, ensuring consistent water flow during extraction.

3. **Extract the Lungo**
   - Lock the portafilter into Caffeine Pal's Espresso Machine. Extract for a longer duration than a standard espresso, targeting about 40-50 seconds. This will produce around 50-60 ml of coffee, double the volume of a regular espresso.

4. **Serve in a Lungo Cup**
   - Immediately serve the lungo in a specially designed lungo cup. The larger size accommodates the increased volume and allows the flavors to develop fully.

5. **Enjoy the Extended Experience**
   - Take time to appreciate the nuanced flavors and lighter body that make Caffeine Pal's Lungo a unique and enjoyable coffee experience.

## Caffeine Pal's Brewing Insights

- The grind size and tamping pressure are key to achieving the perfect lungo.
- Monitor the extraction time closely to ensure a balanced flavor profile.
- Experiment with different bean varieties to explore a range of tastes and aromas.

Discover the delightful complexity of Caffeine Pal's newest Lungo, a coffee that extends the boundaries of traditional espresso.

""",
                .doppio: """
# Mastering Caffeine Pal's Doppio: A Double Shot of Excellence

Join us in the art of perfecting Caffeine Pal's Doppio, a double shot of espresso that packs a punch with its rich and intense flavor. Ideal for espresso enthusiasts, our Doppio is a showcase of our coffee expertise. Follow these steps to replicate this bold and robust drink.

## Ingredients

- Caffeine Pal's Premium Espresso Beans

## Equipment

- Caffeine Pal's Precision Espresso Machine
- Burr Coffee Grinder
- Espresso Cup (slightly larger than standard)

## Instructions

1. **Grind to Espresso Perfection**
   - Use the Burr Grinder to finely grind the Premium Espresso Beans. You'll need about 18-20 grams of coffee, more than a regular espresso shot.

2. **Tamp for Consistency**
   - Tamp the grounds in the portafilter evenly and firmly to ensure a consistent extraction.

3. **Extract the Doppio**
   - Brew a double shot of espresso using Caffeine Pal's Precision Espresso Machine. The extraction time should be about 25-30 seconds, resulting in approximately 60 ml of espresso.

4. **Serve in an Appropriate Cup**
   - Quickly pour the Doppio into a slightly larger espresso cup, designed to hold the double volume.

5. **Relish the Richness**
   - Enjoy the Doppio's intense flavors and rich crema, a testament to Caffeine Pal's dedication to coffee craftsmanship.

## Caffeine Pal's Expert Tips

- Ensure your beans are freshly roasted and ground for the fullest flavor.
- The extraction time is crucial - too short will under-extract, too long will over-extract.
- The Doppio is a foundation for many other coffee drinks, so mastering it opens a world of possibilities.

Savor the deep and potent essence of Caffeine Pal's Doppio, a drink that truly represents the heart and soul of espresso.

""",
                .affogato: """
# Caffeine Pal's World-Famous Affogato: A Denver Delight

Indulge in the luxurious blend of hot and cold with Caffeine Pal's world-famous Affogato. Our signature version of this classic Italian dessert drink features premium ice cream sourced exclusively from Denver, Colorado from a trusted Caffeine Pal partner. Follow these steps to recreate our globally acclaimed treat.

## Ingredients

- Caffeine Pal's Rich Espresso Blend
- Premium Vanilla Ice Cream from Denver, Colorado

## Equipment

- Caffeine Pal's High-End Espresso Machine
- Ice Cream Scoop
- Serving Glass or Cup

## Instructions

1. **Scoop the Exclusive Ice Cream**
   - Place one generous scoop of the premium Denver-sourced vanilla ice cream into a serving glass or cup. The quality of the ice cream is key to the Affogato's luxurious taste.

2. **Brew the Espresso**
   - Grind the Rich Espresso Blend to a fine consistency and use Caffeine Pal's Espresso Machine to brew a strong, hot shot of espresso.

3. **Pour and Marvel**
   - Immediately pour the freshly brewed espresso over the scoop of vanilla ice cream. The contrast between the hot espresso and the cold ice cream creates a delightful sensory experience.

4. **Serve with Elegance**
   - Present the Affogato immediately, allowing guests to experience the unique melding of flavors and temperatures.

5. **Enjoy the World-Renowned Taste**
   - Savor the creamy and rich flavors that make Caffeine Pal's Affogato a celebrated dessert beverage, adored by patrons worldwide.

## Caffeine Pal's Signature Touch

- Using premium ice cream from Denver sets our Affogato apart, offering a distinctive taste and texture.
- Quality of the espresso shot is crucial; it should be robust enough to complement the sweetness of the ice cream.
- Serve in a clear glass for an aesthetically pleasing presentation, showcasing the beautiful meld of espresso and ice cream.

Experience the decadence of Caffeine Pal's World-Famous Affogato, a testament to our commitment to blending the finest ingredients for an unforgettable dessert experience.

""",
                .espressoConPanna: """
# Caffeine Pal's Signature Espresso Con Panna: The Drink of Distinction

Step into the world of unparalleled coffee craftsmanship with Caffeine Pal's Espresso Con Panna, the drink we are best known for. Our version of this classic combines a perfect shot of espresso with a dollop of rich whipped cream, creating a harmonious balance of flavors. Here's how to recreate our signature masterpiece.

## Ingredients

- Caffeine Pal's Exclusive Espresso Blend
- Fresh Heavy Cream (for whipping)

## Equipment

- Caffeine Pal's Advanced Espresso Machine
- Burr Grinder
- Whisk or Cream Whipper
- Espresso Cup

## Instructions

1. **Whip the Cream**
   - Start by whipping the heavy cream until it forms soft peaks. For a luxurious touch, you can sweeten the cream slightly or add a dash of vanilla extract.

2. **Grind the Espresso Beans**
   - Use the Burr Grinder to finely grind Caffeine Pal's Exclusive Espresso Blend. Measure about 18 grams for a rich and robust shot.

3. **Brew the Perfect Espresso**
   - Tamp the grounds evenly and firmly in the portafilter. Brew a single, flawless shot of espresso using Caffeine Pal's Espresso Machine, directly into the espresso cup.

4. **Add the Whipped Cream**
   - Gently spoon a generous dollop of the freshly whipped cream on top of the hot espresso shot. The cream should sit atop the espresso like a cloud.

5. **Serve with Signature Flair**
   - Present the Espresso Con Panna immediately, showcasing the beautiful contrast between the dark espresso and the pure white cream.

6. **Relish the Caffeine Pal Experience**
   - Enjoy the rich espresso as it mixes with the creamy topping, creating a luxurious and indulgent coffee experience.

## Caffeine Pal's Expert Tips

- The quality of the espresso is paramount; ensure it's freshly brewed and robust.
- Whipped cream quality can elevate the drink; consider using a cream whipper for a professional touch.
- The Espresso Con Panna is a testament to simplicity and quality, making every element count.

Indulge in the renowned and exquisite flavors of Caffeine Pal's Espresso Con Panna, a drink that has become synonymous with our brand's commitment to excellence in coffee.

""",
                .espressoRomano: """
# Caffeine Pal's Espresso Romano: A Citrus-Infused Classic

Welcome to the exclusive recipe for Caffeine Pal's Espresso Romano, a delightful twist on traditional espresso. This unique beverage pairs the boldness of espresso with a zesty lemon accent, creating a sensory experience that's both invigorating and refreshing. Follow these steps to recreate our distinctive coffee creation.

## Ingredients

- Caffeine Pal's Select Espresso Beans
- Fresh Lemon (organic preferred)

## Equipment

- Caffeine Pal's Precision Espresso Machine
- Burr Coffee Grinder
- Espresso Cup
- Small Knife or Lemon Zester

## Instructions

1. **Prepare the Lemon**
   - Start by washing the lemon thoroughly. Slice a thin piece of lemon peel, avoiding the white pith as it's bitter. Alternatively, zest the lemon peel for a more subtle flavor.

2. **Grind the Espresso Beans**
   - Grind the Select Espresso Beans to a fine consistency using the Burr Grinder, aiming for about 18 grams for a deep and flavorful shot.

3. **Brew the Espresso**
   - Tamp the grounds in the portafilter and brew a single, robust shot of espresso using Caffeine Pal's Espresso Machine, directly into the espresso cup.

4. **Enhance with Lemon**
   - Rub the rim of the espresso cup with the lemon peel to infuse a citrusy aroma. Then either twist the lemon peel and drop it into the cup or garnish the rim with it.

5. **Serve with a Twist**
   - Present the Espresso Romano immediately, allowing the aroma of the espresso to mingle with the fresh, citrus scent of the lemon.

6. **Experience the Caffeine Pal Magic**
   - Savor the unique combination of the rich espresso and the bright, refreshing hint of lemon, making each sip a delightful contrast of flavors.

## Caffeine Pal's Special Touch

- The espresso should be strong and freshly brewed to stand up to the lemon's acidity.
- Experiment with the amount of lemon to find your perfect balance of citrus and coffee.
- The Espresso Romano is a celebration of simplicity and elegance, capturing the essence of Caffeine Pal's innovative spirit.

Delight in the unique and vibrant flavors of Caffeine Pal's Espresso Romano, a drink that perfectly embodies our passion for creative coffee experiences.

""",
                .redEye : """
# Caffeine Pal's Red Eye: The Ultimate Caffeine Boost

Get ready for an energizing experience with Caffeine Pal's Red Eye, a powerful combination of espresso and drip coffee that packs a whopping 400 milligrams of caffeine. Designed for those who need an extra kick, this drink is not just a coffee, it's a wake-up call. Follow these steps to recreate our high-octane coffee concoction.

## Ingredients

- Caffeine Pal's Strongest Espresso Blend
- Freshly Brewed Drip Coffee (choose a robust blend)

## Equipment

- Caffeine Pal's High-Powered Espresso Machine
- Coffee Maker or Drip Brewer
- Burr Grinder
- Large Coffee Mug

## Instructions

1. **Brew the Drip Coffee**
   - Start by brewing a strong cup of drip coffee. Use a robust blend to ensure the coffee contributes significantly to the overall caffeine content.

2. **Grind the Espresso Beans**
   - Using the Burr Grinder, grind enough of Caffeine Pal's Strongest Espresso Blend to pull a double shot. Aim for a fine grind for maximum flavor extraction.

3. **Extract the Espresso**
   - Brew a double shot of espresso using Caffeine Pal's Espresso Machine. The espresso should be rich and bold to complement the drip coffee.

4. **Combine Coffee and Espresso**
   - Pour the freshly brewed espresso directly into the mug of hot drip coffee. The combination creates the potent and energizing Red Eye.

5. **Serve with a Warning**
   - Present the Red Eye with a caution about its high caffeine content. This drink is designed for those who need an intense boost.

6. **Experience the Power of Caffeine Pal**
   - Savor the strong, complex flavors and enjoy the unparalleled energy surge that Caffeine Pal's Red Eye provides.

## Caffeine Pal's Brewing Insights

- The quality and strength of both the espresso and drip coffee are key to achieving the desired caffeine level.
- Ensure the espresso is freshly brewed for the best taste and caffeine kick.
- This drink is perfect for long nights or early mornings when you need maximum alertness.

Enjoy the intense and powerful effects of Caffeine Pal's Red Eye, a drink that's not just about taste, but also about delivering a serious caffeine punch.

"""]
    }
}
