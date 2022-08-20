//
//  CardViewFactory.swift
//  Cards
//
//  Created by Nataliya Lazouskaya on 20.08.22.
//

import UIKit

class CardViewFactory {
    func get(_ shape: CardType, withSize size: CGSize, andColor color: CardColor) -> UIView {
        let frame = CGRect(origin: .zero, size: size)
        let viewColor = getViewColorBy(modelColor: color)
        
        switch shape {
        case .circle:
            return CardView<CircleShape>(frame: frame, color: viewColor)
        case .cross:
            return CardView<CrossShape>(frame: frame, color: viewColor)
        case .square:
            return CardView<SquareShape>(frame: frame, color: viewColor)
        case .fill:
            return CardView<FillShape>(frame: frame, color: viewColor)
        case .circleNotFilled:
            return CardView<CircleNotFilledShape>(frame: frame, color: viewColor)
        }
    }
    
    private func getViewColorBy(modelColor: CardColor) -> UIColor {
        switch modelColor {
        case .red: return .red
        case .green: return .green
        case .black: return .black
        case .gray: return .gray
        case .brown: return .brown
        case .yellow: return .yellow
        case .purple: return .purple
        case .orange: return .orange
        }
    }
}

