//
//  SnakeCell.swift
//  SnakeGame
//
//  Created by Grigore on 05.12.2023.
//

import Foundation

class GameCell: Equatable {
    
    var col: Int
    var row: Int
    
    init(col: Int, row: Int) {
        self.col = col
        self.row = row
    }
    
    static func == (lhs: GameCell, rhs: GameCell) -> Bool {
        lhs.col == rhs.col && lhs.row == rhs.row
    }

}
