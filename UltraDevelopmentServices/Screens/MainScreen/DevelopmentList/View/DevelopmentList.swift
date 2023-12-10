//
//  ContentView.swift
//  UltraDevelopmentServices
//
//  Created by Никита Рассказов on 05.12.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var onClear: () -> Void // Замыкание для очистки текста поиска
    var searchAction: (String) -> ()

    var body: some View {
        HStack {
            TextField("Поиск", text: $searchText, onCommit: {
                searchAction(searchText)
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
//                .foregroundColor(.white)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    /**/
                    onClear() // Вызываем замыкание при нажатии кнопки "X" для очистки текста
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing)
            }
        }
    }
}

struct DevelopmentList: View {

    @StateObject private var viewModel = MainViewModel()
    @State private var searchBarText = ""
    private var filteredDevs: [DevelopmentModel] {
        viewModel.searchTitles(searchText: searchBarText, fetchData: fetchData, fetchSearch: fetchSearch)
    }

    var body: some View {
        /// Навигация нашего приложения, чтобы мы могли вернуться к экрану
        NavigationStack {
            VStack {
                SearchBar(searchText: $searchBarText, onClear: fetchData, searchAction: fetchSearch)
                    .padding(.top, 5).padding(.bottom, 10)
                ScrollViewReader { reader in
                /// Скролл вью, чтобы могли скролить
                ScrollView(showsIndicators: false) {
                    /// То же самое, что и VStack, но он ленивый. Т.е переиспользует ячейки. Используеют, когда данных много.
                    LazyVStack {
                        /// Тут перебираем наши треки. Т.к DevelopmentModel подписан на `Identifiable` мы можем по нему итерироваться.
                        ForEach(filteredDevs) { developmentService in
                            /// Это место, куда мы будем переходить при нажатии
                            NavigationLink {
                                /// Экран, который откроем при нажатии
                                DevelopmentDetails(developmentServiceId: developmentService.dataId)
                            } label: {
                                /// наша ячейка
                                DevelopmentCell(developmentService: developmentService)
                            }
                            .padding(.bottom)
                        }
                        .padding(.horizontal, 15)
                    }
                }
            }
            /// Фон
            
            /// Наш сёрч бар выше
            //            .searchable(text: $searchBarText, prompt: "Поиск")
            /// Наш заголовок
            .navigationBarTitle("Виды разработки")
        }
            .background(Color.appBackground)
        }
        
        /// Не теряем!
        .environmentObject(viewModel)
        /// Задаём тему всегда тёмную
        .colorScheme(.dark)
        /// Перед появлением экрана будем выполнять функцию fetchData
        .onAppear(perform: fetchData)
    }
}

// MARK: - Network

private extension DevelopmentList {

    func fetchData() {
        viewModel.getDevs { error in
                    if let error {
                        print(error.localizedDescription)
                        viewModel.developmentServices = .mockData
                    }
                }
    }
    
    func fetchSearch(searchText: String) {
        viewModel.getSearch(searchStr: searchText) { error in
            if let error {
                print(error.localizedDescription)
                viewModel.developmentService = .mockData
            }
        }
    }
}

// MARK: - Preview

#Preview {
    DevelopmentList()
    /// Не теряем!
        .environmentObject(MainViewModel())
}
