//
//  CollectionVIew.swift
//  This4That
//
//  Created by csuftitan on 4/14/24.
//

import SwiftUI

struct CollectionView: View {
    var category: String
    //@EnvironmentObject var cartManager: CartManager
    @StateObject var cartManager: CartManager
    @Environment(\.presentationMode) var mode
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    HStack{
                        Text("Order From This4That")
                            .font(.system(size: 35))
                            .padding(.trailing)
                        
                        Spacer()
                        
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            
                            
                            
                            Image(systemName: "arrow.left")
                                .imageScale(.large)
                                .padding()
                                .frame(width: 70, height: 90)
                                .overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
                        }
                        .foregroundColor(.black)
                    }
                    .padding(30)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                              content: {
                        ForEach(productList, id: \.id) {item in
                            if (item.category == category) {
                                SmallProductCard(product: item, cartManager: cartManager)
                                    .environmentObject(cartManager)
                            }
                        }
                    })
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    CollectionView(category: "All", cartManager: CartManager())
        .environmentObject(CartManager())
}

struct SmallProductCard: View {
    var product: Product
    
    //@EnvironmentObject var cartManager: CartManager
    @StateObject var cartManager: CartManager
    
    var body: some View{
        ZStack{
            Image(product.image)
                .resizable()
                .scaledToFit()
                .padding(.trailing, -200)
                .rotationEffect(Angle(degrees: 30))
            
            ZStack{
                
                VStack(alignment: .leading, content: {
                    Text("\(product.name)")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 70)
                    
                    Text(product.category)
                        .font(.system(size: 10))
                        .padding()
                        .background(.white.opacity(0.5))
                        .clipShape(Capsule())
                    Spacer()
                    
                    HStack{
                        if (cartManager.has(product: product)) {
                            Text("In Cart")
                                .font(.system(size: 14, weight: .semibold))
                        } else {
                            Text("$\(product.price).00")
                                .font(.system(size: 14, weight: .semibold))
                            
                            Spacer()
                            
                            Button {
                                cartManager.addToCart(product: product)
                            } label: {
                                Image(systemName: "basket")
                                    .imageScale(.large)
                                    .padding()
                                    .frame(width: 45, height: 40)
                                    .background(.black)
                                    .clipShape(Capsule())
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.trailing, -12)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height:45)
                    .background(.white.opacity(0.9))
                    .clipShape(Capsule())
                })
            }
            .padding(20)
            .frame(width: 170, height: 215)
            
        }
        .frame(width: 170, height: 215)
        .background(product.color.opacity(0.13))
        .clipShape(.rect(cornerRadius:  30))
        .padding(.leading, 10)
    }
}
