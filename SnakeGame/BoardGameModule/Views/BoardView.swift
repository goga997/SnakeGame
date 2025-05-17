//
//  BoardView.swift
//  SnakeGame
//
//  Created by Grigore on 05.12.2023.
//

import UIKit

class BoardView: UIView {
    
    private var cols = 0
    private var rows = 0
    private var cellSize: CGFloat = 0
    
    var snake: [GameCell] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var addPoint: CGPoint?
    
    override var intrinsicContentSize: CGSize {
        let heightView = cellSize * CGFloat(rows)
        return CGSize(width: UIView.noIntrinsicMetric, height: heightView)
    }
    
    //MARK: - Initialization + Draw func
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellSize = frame.width / CGFloat(cols)
        invalidateIntrinsicContentSize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.7254901961, blue: 0.6666666667, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(cols: Int, rows: Int) {
        self.init()
        self.cols = cols
        self.rows = rows
    }
    
    override func draw(_ rect: CGRect) {
        drawGrid()
        drawAddPoint()
        drawSnake()
    }
    
    // MARK: - Draw Objects
    
    private func drawGrid() {
        let gridPath = UIBezierPath()
        
        for i in 0...rows {
            gridPath.move(to: CGPoint(x: 0,
                                      y: CGFloat(i) * cellSize))
            
            gridPath.addLine(to: CGPoint(x: CGFloat(cols) * cellSize,
                                         y: CGFloat(i) * cellSize))
        }
        
        for j in 0...cols {
            gridPath.move(to: CGPoint(x: CGFloat(j) * cellSize,
                                      y: 0))
            
            gridPath.addLine(to: CGPoint(x: CGFloat(j) * cellSize,
                                         y: CGFloat(rows) * cellSize))
        }
        
        SnakeColor.grid.setStroke()
        gridPath.stroke()
    }
    
    private func drawSnake() {
        guard !snake.isEmpty, let snakeHead = snake.first else { return }
        //for head
        SnakeColor.snakeHead.setFill()
        UIBezierPath(roundedRect: CGRect(x: CGFloat(snakeHead.col) * cellSize,
                                         y: CGFloat(snakeHead.row) * cellSize,
                                         width: cellSize,
                                         height: cellSize),
                     cornerRadius: 5).fill()
        
        //for body
        SnakeColor.snakeBody.setFill()
        for i in 1..<snake.count {
            let cell = snake[i]
            UIBezierPath(roundedRect: CGRect(x: CGFloat(cell.col) * cellSize,
                                             y: CGFloat(cell.row) * cellSize,
                                             width: cellSize,
                                             height: cellSize),
                         cornerRadius: 5).fill()
        }
    }
    
    private func drawAddPoint() {
        guard let addPoint else { return }
        SnakeColor.addPoint.setFill()
        UIBezierPath(roundedRect: CGRect(x: addPoint.x * cellSize,
                                         y: addPoint.y * cellSize,
                                         width: cellSize,
                                         height: cellSize),
                     cornerRadius: 5).fill()
    }
 }
