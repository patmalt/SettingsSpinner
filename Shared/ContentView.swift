//
//  ContentView.swift
//  Shared
//
//  Created by Patrick Maltagliati on 11/24/20.
//

import SwiftUI

struct ContentView: View {
    @State private var isRotated = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16).fill(Color.gray).frame(width: 200, height: 200)
            Circle().fill(Color.black).frame(width: 180, height: 180)
            SpikeCircle().frame(width: 160, height: 160).rotationEffect(Angle.init(degrees: isRotated ? 360 : 0)).animation(Animation.linear(duration: 200).repeatForever(autoreverses: false))
            SpikeCircle().frame(width: 120, height: 120).rotationEffect(Angle.init(degrees: isRotated ? 0 : 360)).animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
            SpikeCircle().frame(width: 80, height: 80).rotationEffect(Angle.init(degrees: isRotated ? 360 : 0)).animation(Animation.linear(duration: 50).repeatForever(autoreverses: false))
            SpikeCircle().frame(width: 40, height: 40).rotationEffect(Angle.init(degrees: isRotated ? 0 : 360)).animation(Animation.linear(duration: 25).repeatForever(autoreverses: false))
        }
        .onAppear {
            isRotated.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



class SpikeCircleView: UIView {
    private let replicator = CAReplicatorLayer()
    private let replicatorInstanceLayer = CAShapeLayer()
    private let spikeSize: CGFloat = 8

    override init(frame: CGRect) {
        super.init(frame: frame)
        replicatorInstanceLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        replicatorInstanceLayer.strokeColor = UIColor.darkGray.cgColor
        replicatorInstanceLayer.lineWidth = 0.5
        replicator.addSublayer(replicatorInstanceLayer)
        layer.addSublayer(replicator)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let diameter = min(bounds.width, bounds.height)
        let radius = diameter / 2
        let circumference = CGFloat.pi * diameter
        let numberOfImages = Int(circumference / spikeSize)
        let rect = CGRect(x: radius - spikeSize / 2, y: -spikeSize / 2, width: spikeSize, height: spikeSize)
        replicatorInstanceLayer.frame = rect
        replicatorInstanceLayer.path = CGPath.spike(in: rect)
        replicator.instanceCount = numberOfImages
        replicator.instanceTransform = CATransform3DRotate(CATransform3DIdentity, .pi / (CGFloat(numberOfImages) / 2), 0, 0, 1)
        replicator.frame = bounds
    }
}

extension CGPath {
    static func spike(in rect: CGRect) -> CGPath {
        let path = UIBezierPath()

        path.move(to: CGPoint(x: 3, y: 8))
        path.addCurve(to: CGPoint(x: 4, y: 1), controlPoint1: CGPoint(x: 3, y: 8), controlPoint2: CGPoint(x: 3, y: 1))
        path.addCurve(to: CGPoint(x: 5, y: 8), controlPoint1: CGPoint(x: 5, y: 1), controlPoint2: CGPoint(x: 5, y: 8))
        path.close()

        return path.cgPath
    }
}

struct SpikeCircle: UIViewRepresentable {
    typealias UIViewType = SpikeCircleView

    func makeUIView(context: Context) -> SpikeCircleView {
        SpikeCircleView()
    }

    func updateUIView(_ uiView: SpikeCircleView, context: Context) {}
}
