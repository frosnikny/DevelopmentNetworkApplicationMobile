//
//  DevelopmentCell.swift
//  UltraDevelopmentServices
//
//  Created by Никита Рассказов on 05.12.2023.
//

import SwiftUI

struct DevelopmentCell: View {

    @EnvironmentObject var viewModel: MainViewModel
    var developmentService: DevelopmentModel!
    
    /// Наша вьюха
    var body: some View {
        HStack {
            AsyncImage(url: developmentService.imageURL) { img in
                img
                /// Говорим, что будем менять размеры фото
                    .resizable()
                /// Формат фото  ration - fill
                    .aspectRatio(contentMode: .fill)
                /// Задаём размер фото 100 на 100
                    .frame(width: 100, height: 100)
                /// Вырезаем фигуру RoundedRectangle с углами 20 градусов. Т.е просто делаем углы у нашего фото
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } placeholder: {
                ZStack {
                    /// Просто прямоугольник с углам 20
                    RoundedRectangle(cornerRadius: 20)
                    /// Это цвет прямоугольника. shimmerColor - наш кастомный цвет из файла `Color+Extenstions`
                        .fill(Color.shimmerColor)
                    /// Это наш лоудер, который крутится
                    ProgressView()
                }
                .frame(width: 100, height: 100)
            }

            VStack(spacing: 10) {
                HStack {
                    Text(developmentService.title ?? "Название не указано")
                    /// Задаём фонт текста
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    /// Тот же фрейм. Нам надо центрировать текст по левой стороне. Т.е делаем ширину infinity и выравнивание по левой части
                        .frame(maxWidth: .infinity, alignment: .leading)
                    /// Выравнивание многострочного текста
                        .multilineTextAlignment(.leading)
                    /// Цвет текста из `Color+Extenstions`
                        .foregroundStyle(Color.appForeground)
                    /// Ограничение числа строк. `0` - это неограниченно, 1 - это одна. 2 - две и тд
                        .lineLimit(1)
                    
                    if let collectionPrice = developmentService.price {
                        Text("от " + formatPrice(collectionPrice) + " ₽")
                            .font(.system(size: 16, weight: .light, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundStyle(Color.appForeground)
                            .lineLimit(1)
                    }
                }
                Text(developmentService.description ?? "Описание не задано")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.appForeground.opacity(0.4))
                    .lineLimit(1)
            }
            /// Это наш отступ по горизонтали
            .padding(.horizontal, 5)

            Spacer()
        }
        /// Наш EnvironmentObject var viewModel: MainViewModel
        .environmentObject(viewModel)
    }
}

// MARK: - Preview

/// Это наше превью, которая создаём экран справа
#Preview {
    /// .mockData - наш мок данных для превью справа
    DevelopmentCell(developmentService: .mockData)
        .padding()
    /// Важно! Без этого не будет работать превью. Будет крашится
        .environmentObject(MainViewModel())
    /// Задаём задний фон, используя градиент
        .background(Color.appBackground)
}
