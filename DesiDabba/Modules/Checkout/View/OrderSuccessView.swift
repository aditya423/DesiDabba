//
//  OrderSuccessView.swift
//  DesiDabba
//
//  Created by Aditya on 25/07/25.
//

import SwiftUI

struct OrderSuccessView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: ImageConstants.systemCheck.rawValue)
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.background)

            Text(StringConstants.orderPlaced.rawValue)
                .fontWeight(.semibold)

            Text(StringConstants.thankYou.rawValue)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
                .frame(height: 10)
            
            Button(action: {
                withAnimation {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                        let homeVC = HomeViewController()
                        let navController = UINavigationController(rootViewController: homeVC)
                        window.rootViewController = navController
                        window.makeKeyAndVisible()
                    }
                }
            }) {
                Text(ButtonTitles.done.rawValue)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.background)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    OrderSuccessView()
}
