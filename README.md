# CardView-SwiftUI

Reusable CardView created with SwiftUI

## Information

To present this CardView simply add .cardView() modifier and there you just embed content that you would like to present inside.
I added example project.

## Usage

```swift
import SwiftUI

struct ContentView: View {
    
    /// Card presentation state
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack {
            Button(action: { isPresented.toggle() }) {
                Text("Show card")
            }
        }
        .cardView(title: "Card header text here..", isPresented: $isPresented) {
            // Add view that you want to embed inside CardView.
            SelectedPhotoView()
        }
    }
}

```

## Screenshot 

![](name-of-giphy.gif)
![Gif](https://media.giphy.com/media/816iMIzaPjn6BDK7fX/giphy.gif)

## Contributing
Pull requests and contributions are welcome.

## License
[MIT](https://choosealicense.com/licenses/mit/)
