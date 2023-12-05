//
//  DevelopmentDetails.swift
//  UltraDevelopmentServices
//
//  Created by Никита Рассказов on 05.12.2023.
//

import SwiftUI

struct DevelopmentDetails: View {
    @EnvironmentObject var viewModel: MainViewModel
    var developmentService: DevelopmentModel!

    var body: some View {
        GeometryReader {
            let size = $0.size
            ScrollView {
                VStack {
                    ImageView(size)

                    DevelopmentTextInfo
                        .padding()
                }
            }
        }
        .padding(.horizontal)
        .environmentObject(viewModel)
        .navigationBarTitle("", displayMode: .inline)
        .colorScheme(.dark)
        .background(Color.appBackground)
    }
}

func formatPrice(_ price: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
}

// MARK: - SongDetails

private extension DevelopmentDetails {
    
    
    /// Вьюха картинки
    /// - Parameter size: размер фото
    /// - Returns: кастомную фотку
    func ImageView(_ size: CGSize) -> some View {
        AsyncImage(url: developmentService.imageURL) { img in
            img
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.width)
                .clipShape(RoundedRectangle(cornerRadius: 20))

        } placeholder: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.shimmerColor)
                ProgressView()
            }
            .frame(width: size.width, height: size.width)
        }
    }
    
    /// Наше тело со всей текстой информацией
    var DevelopmentTextInfo: some View {
        VStack {
            Text(developmentService.title ?? "Название не указано")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 22, weight: .semibold, design: .rounded))

            Text(developmentService.description ?? "Описание не задано")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundStyle(.secondary)
            
            if let collectionTechnology = developmentService.technology {
                HStack {
                    Text("Исользуемые технологии: \(collectionTechnology)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 18, weight: .thin, design: .rounded))
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 1)
            }

            HStack {
                Text("Стоимость")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                Spacer()

                /// Если стоимость задана, то выводим её, иначе текст `не задана`
                if let collectionPrice = developmentService.price {
                    Text("от " + formatPrice(collectionPrice) + " ₽")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } else {
                    Text("не задана")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.top, 20).padding(.bottom, 1)
            
            HStack {
                Text("За один день работы")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.secondary)
                Spacer()

                /// Если детальная стоимость задана, то выводим её, иначе текст `не задано`
                if let collectionDetailedCost = developmentService.detailedPrice {
                    Text(formatPrice(collectionDetailedCost) + " ₽")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundStyle(.secondary)
                } else {
                    Text("не задано")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        DevelopmentDetails(developmentService: .mockData)
    }
    .environmentObject(MainViewModel())
}
