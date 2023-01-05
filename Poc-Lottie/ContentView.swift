//
//  ContentView.swift
//  Poc-Lottie
//
//  Created by DOUARD David on 04/01/2023.
//

import SwiftUI
import DeltaDoreDesignSystem


struct customView: View {
    var modelListToggle: DDSListViewModel
    var body: some View {
        HStack {
            //LottieView(name: modelListToggle.actionTag )
            DDSList(model: modelListToggle)
        }
    }
}

struct ContentView: View {
    @ObservedObject var model: ContentViewModel
    @State var themeSelected: DDTheme.Theme = .dark
    
    var style = DDSListStyle()
    var body: some View {
        VStack {
            DDSButton(model: model.buttonModel,
                      theme: .dark)
            // ******* Add list of rows ***********
            let list = List {
                Section {
                    ForEach(model.listModelArray) { element in
                        customView(modelListToggle: element)
                        .background(Color.uiGray90)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }
            .fixedBackgroundColor()
            .background(Color.uiGray90)
            if #available(iOS 15.0, *) {
                list.listStyle(InsetGroupedListStyle())
            } else {
                list.listStyle(InsetListStyle())
            }
        }
        .padding()
        .background(Color.uiGray90)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ContentViewModel())
    }
}
