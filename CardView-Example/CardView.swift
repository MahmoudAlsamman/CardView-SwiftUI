//
//  CardView.swift
//  CardView-Example
//
//  Created by Mahmoud Alsamman on 31/05/2021.
//

import SwiftUI

/// CardView view appears over the app current view.
/// Use modifier  .CardView(isPresented: Bool) { View you want to embed in }.
struct CardView<EmbededView: View>: ViewModifier {
    
    // MARK: - Properties
    
    /// Presentation state.
    @Binding private var isPresented: Bool
    /// Default offset for  CardView.
    @State private var cardOffset: CGFloat = 10.0
    /// CardView title.
    private let title: String?
    /// Card content views.
    private let embededContent: EmbededView
    /// Maximum allowed drage distance.
    private let dragDistance: CGFloat = 150.0
    
    // MARK: - View initializer
    
    /// CardView initializer
    /// - Parameters:
    ///   - title: Card title.
    ///   - isPresented: If card should be presented.
    ///   - contents: Card content views.
    init(
        title: String?,
        isPresented: Binding<Bool>,
        @ViewBuilder embededContent: @escaping () -> EmbededView
    ) {
        self.title = title
        self._isPresented = isPresented
        self.embededContent = embededContent()
    }
    
    // MARK: - Views
    
    @ViewBuilder
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            ZStack {
                // Current view.
                content
                // Mask view between current view and CardView.
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .opacity(isPresented ? 0.5 : 0)
                    .animation(.default)
                    .onTapGesture { isPresented = false }
                
                VStack {
                    Spacer(minLength: 0)
                    // Card view
                    VStack(spacing: 5)  {
                        cardTopView
                            .padding(.top, 5)
                        embededContent
                            .padding(.bottom, 30)
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .gesture(
                        DragGesture()
                            .onChanged { drag in
                                if drag.translation.height > 0 {
                                    cardOffset = drag.translation.height
                                }
                            }
                            .onEnded { drag in
                                if drag.translation.height > dragDistance {
                                    isPresented = false
                                    resetCardOffset()
                                } else {
                                    resetCardOffset()
                                }
                            }
                    )
                    .animation(.spring(response: 0.35, dampingFraction: 1))
                }
                .offset(y: isPresented ? cardOffset : proxy.size.height)
                .frame(width: proxy.size.width)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    /// View consists of card title, close button and small rounded rectangle.
    private var cardTopView: some View {
        VStack {
            RoundedRectangle(cornerRadius: CGFloat(5.0) / 2.0)
                .frame(width: 40, height: 5)
                .foregroundColor(.gray)
            HStack {
                Spacer()
                Text(title ?? "")
                    .font(.title)
                    .padding(.leading, 40)
                    .multilineTextAlignment(.center)
                Spacer()
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .trailing)
                        .foregroundColor(.gray)
                        .padding(.trailing, 16)
                }
            }
        }
    }
    
    // MARK: - Methods
    
    /// Resets the cardView offset to the default.
    private func resetCardOffset() {
        cardOffset = 10
    }
}

// MARK: - View modifier

extension View {
    func cardView<content: View>(
        title: String? = nil,
        isPresented: Binding<Bool>,
        content: @escaping () -> content
    ) -> some View {
        self.modifier(CardView(title: title, isPresented: isPresented, embededContent: content))
    }
}
