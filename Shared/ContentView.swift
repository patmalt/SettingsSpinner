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
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray)
                .frame(width: 160, height: 160)
            Circle()
                .fill(Color.black)
                .frame(width: 145, height: 145)
                .shadow(radius: 4)
            SpikeCircle()
                .frame(width: 75, height: 75)
                .rotationEffect(Angle.init(degrees: isRotated ? 0 : 360))
                .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false))
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 67, height: 67)
            SpikeCircle()
                .frame(width: 125, height: 125)
                .rotationEffect(Angle.init(degrees: isRotated ? 360 : 0))
                .animation(Animation.linear(duration: 25).repeatForever(autoreverses: false))
            Gear()
                .fill(Color.gray)
                .frame(width: 115, height: 115)
                .offset(x: -1, y: -0.5)
                .rotationEffect(Angle.init(degrees: isRotated ? 360 : 0))
                .animation(Animation.linear(duration: 25).repeatForever(autoreverses: false))
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
        replicatorInstanceLayer.fillColor = UIColor.darkGray.cgColor
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

struct Gear: Shape {
    func path(in rect: CGRect) -> Path {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 110.45, y: 80.13))
        bezierPath.addCurve(to: CGPoint(x: 86.9, y: 106.23), controlPoint1: CGPoint(x: 104.39, y: 91.04), controlPoint2: CGPoint(x: 103.33, y: 95.57))
        bezierPath.addCurve(to: CGPoint(x: 42.31, y: 105.54), controlPoint1: CGPoint(x: 66.55, y: 119.43), controlPoint2: CGPoint(x: 41.53, y: 112.05))
        bezierPath.addCurve(to: CGPoint(x: 63.96, y: 65.41), controlPoint1: CGPoint(x: 44.3, y: 88.85), controlPoint2: CGPoint(x: 58.45, y: 68.92))
        bezierPath.addLine(to: CGPoint(x: 64.09, y: 65.19))
        bezierPath.addCurve(to: CGPoint(x: 110.45, y: 80.13), controlPoint1: CGPoint(x: 68.19, y: 61.99), controlPoint2: CGPoint(x: 125.34, y: 53.32))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 19.8, y: 92.23))
        bezierPath.addCurve(to: CGPoint(x: 7.16, y: 59.59), controlPoint1: CGPoint(x: 12.78, y: 81.91), controlPoint2: CGPoint(x: 9.19, y: 78.89))
        bezierPath.addCurve(to: CGPoint(x: 28.29, y: 20.8), controlPoint1: CGPoint(x: 4.64, y: 35.67), controlPoint2: CGPoint(x: 22.79, y: 17.12))
        bezierPath.addCurve(to: CGPoint(x: 54.41, y: 58.24), controlPoint1: CGPoint(x: 42.37, y: 30.22), controlPoint2: CGPoint(x: 53.79, y: 51.79))
        bezierPath.addLine(to: CGPoint(x: 54.55, y: 58.45))
        bezierPath.addCurve(to: CGPoint(x: 19.8, y: 92.23), controlPoint1: CGPoint(x: 55.54, y: 63.52), controlPoint2: CGPoint(x: 37.06, y: 117.63))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 55.39, y: 7.47))
        bezierPath.addCurve(to: CGPoint(x: 89.88, y: 15.31), controlPoint1: CGPoint(x: 67.99, y: 7.47), controlPoint2: CGPoint(x: 72.52, y: 6.22))
        bezierPath.addCurve(to: CGPoint(x: 110.71, y: 54.26), controlPoint1: CGPoint(x: 111.39, y: 26.58), controlPoint2: CGPoint(x: 116.87, y: 51.8))
        bezierPath.addCurve(to: CGPoint(x: 64.67, y: 54.81), controlPoint1: CGPoint(x: 94.93, y: 60.55), controlPoint2: CGPoint(x: 70.44, y: 57.89))
        bezierPath.addLine(to: CGPoint(x: 64.42, y: 54.8))
        bezierPath.addCurve(to: CGPoint(x: 55.39, y: 7.47), controlPoint1: CGPoint(x: 59.6, y: 52.79), controlPoint2: CGPoint(x: 24.42, y: 7.47))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 60, y: 2.5))
        bezierPath.addCurve(to: CGPoint(x: 2.5, y: 60), controlPoint1: CGPoint(x: 28.24, y: 2.5), controlPoint2: CGPoint(x: 2.5, y: 28.24))
        bezierPath.addCurve(to: CGPoint(x: 60, y: 117.5), controlPoint1: CGPoint(x: 2.5, y: 91.76), controlPoint2: CGPoint(x: 28.24, y: 117.5))
        bezierPath.addCurve(to: CGPoint(x: 117.5, y: 60), controlPoint1: CGPoint(x: 91.76, y: 117.5), controlPoint2: CGPoint(x: 117.5, y: 91.76))
        bezierPath.addCurve(to: CGPoint(x: 60, y: 2.5), controlPoint1: CGPoint(x: 117.5, y: 28.24), controlPoint2: CGPoint(x: 91.76, y: 2.5))
        bezierPath.close()
        return Path(bezierPath.cgPath)
    }
}

struct SpikeCircle: UIViewRepresentable {
    typealias UIViewType = SpikeCircleView

    func makeUIView(context: Context) -> SpikeCircleView {
        SpikeCircleView()
    }

    func updateUIView(_ uiView: SpikeCircleView, context: Context) {}
}
