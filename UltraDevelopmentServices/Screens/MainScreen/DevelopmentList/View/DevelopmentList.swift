//
//  ContentView.swift
//  UltraDevelopmentServices
//
//  Created by Никита Рассказов on 05.12.2023.
//

import SwiftUI

struct DevelopmentList: View {

    @StateObject private var viewModel = MainViewModel()
    @State private var searchBarText = ""
    private var filteredDevs: [DevelopmentModel] {
        viewModel.seachTitles(searchText: searchBarText)
    }

    var body: some View {
        /// Навигация нашего приложения, чтобы мы могли вернуться к экрану
        NavigationStack {
            /// Скролл вью, чтобы могли скролить
            ScrollView(showsIndicators: false) {
                /// То же самое, что и VStack, но он ленивый. Т.е переиспользует ячейки. Используеют, когда данных много.
                LazyVStack {
                    /// Тут перебираем наши треки. Т.к DevelopmentModel подписан на `Identifiable` мы можем по нему итерироваться.
                    ForEach(filteredDevs) { developmentService in
                        /// Это место, куда мы будем переходить при нажатии
                        NavigationLink {
                            /// Экран, который откроем при нажатии
                            DevelopmentDetails(developmentService: developmentService)
                        } label: {
                            /// наша ячейка
                            DevelopmentCell(developmentService: developmentService)
                        }
                        .padding(.bottom)
                    }
                    .padding(.horizontal, 15)
                }
            }
            /// Фон
            .background(Color.appBackground)
            /// Наш сёрч бар выше
            .searchable(text: $searchBarText, prompt: "Поиск")
            /// Наш заголовок
            .navigationBarTitle("Виды разработки")
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
}

// MARK: - Preview

#Preview {
    DevelopmentList()
    /// Не теряем!
        .environmentObject(MainViewModel())
}
