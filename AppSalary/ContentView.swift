//
//  ContentView.swift
//  AppSalary
//
//  Created by Nariman Vildanov on 13.04.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = BudgetModel()
    @State private var tabBarOffset: CGFloat = 0
    @State private var selection = 0
    @State private var selectedTabBar = "0"
    @State public var xOffSet: CGFloat = 0
    let tabList: [String] = ["0", "1", "2"]
    
    init() { UITabBar.appearance().isHidden = true }
    
    var body: some View {
        ZStack (alignment: Alignment(horizontal: .center,
                                     vertical: .bottom)) {
            TabView(selection: $selection) {
                BudgetInputView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "dollarsign.circle")
                        Text("Budget")
                    }
                    .tag(0)
                
                BudgetDisplayView(budget: viewModel)
                    .tabItem {
                        Image(systemName: "dollarsign.square")
                        Text("Counter")
                    }
                    .tag(1)
                
                BudgetSettingsView(budget: viewModel)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                    .tag(2)
            }
            
            HStack(spacing: 0) {
                ForEach(tabList, id: \.self) { image in
                    GeometryReader { reader in
                        TabbarButton(image: image, selectedTabBar: selectedTabBar, reader: reader) {
                            withAnimation(Animation.linear(duration: 0.3)) {
                                selectedTabBar = image
                                selection = Int(image) ?? 0
                                xOffSet = reader.frame(in: .global).minX
                            }
                        }
                        .onAppear {
                            if image == tabList.first {
                                xOffSet = reader.frame(in: .global).minX
                            }
                        }
                    }
                    .frame(width: 30, height: 30)
                    if image != tabList.last { Spacer(minLength: 0) }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical)
            .background(Color.chainGangGrey.clipShape(CustomShape(xOffSet: xOffSet)).cornerRadius(10))
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
