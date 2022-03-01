//
//  DashedView.swift
//  BrainUp
//
//  Created by Andrei Trukhan on 26/02/2022.
//

import UIKit

final class DashedView: UIView {
    
    struct Configuration {
        var color: UIColor
        var dashLength: CGFloat
        var dashGap: CGFloat
    }

    class var lineHeight: CGFloat { 1.0 }
    private var dashedLayer: CAShapeLayer?

    override public var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: Self.lineHeight)
    }

    private var config: Configuration {
        didSet {
            drawDottedLine()
        }
    }

    init(config: Configuration) {
        self.config = config
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // We only redraw the dashes if the width has changed.
        guard bounds.width != dashedLayer?.frame.width else { return }
        
        drawDottedLine()
    }
    
    // MARK: - Drawing
}

private extension DashedView {
    func drawDottedLine() {
        if dashedLayer != nil {
            dashedLayer?.removeFromSuperlayer()
        }

        dashedLayer = drawDottedLine(
            start: bounds.origin,
            end: CGPoint(x: bounds.width, y: bounds.origin.y),
            config: config)
    }

    func drawDottedLine(start: CGPoint, end: CGPoint, config: Configuration) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = config.color.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.lineWidth = Self.lineHeight
        shapeLayer.lineDashPattern = [config.dashLength as NSNumber, config.dashGap as NSNumber]

        let path = CGMutablePath()
        path.addLines(between: [start, end])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)

        return shapeLayer
    }
}
