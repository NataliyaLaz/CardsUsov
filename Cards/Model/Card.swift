//
//  Card.swift
//  Cards
//
//  Created by Nataliya Lazouskaya on 19.08.22.
//

import Foundation

enum CardType: CaseIterable {
    case circle
    case cross
    case square
    case fill
    case circleNotFilled
}

enum CardColor: CaseIterable {
    case red
    case green
    case black
    case gray
    case brown
    case yellow
    case purple
    case orange
}

typealias Card = (type: CardType, color: CardColor)
