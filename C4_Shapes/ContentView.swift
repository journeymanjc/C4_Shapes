//
//  ContentView.swift
//  C4_Shapes
//
//  Created by Jae Cho on 5/26/22.
//

import SwiftUI

//Making a pointed up arrow
struct Arrow : Shape {
	
	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.midX - 100, y: rect.minY + 100))
		path.addLine(to: CGPoint(x: rect.midX - 50, y: rect.minY + 100))
		path.addLine(to: CGPoint(x: rect.midX - 50, y: rect.minY + 200))
		path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.minY + 200))
		path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.minY + 100))
		path.addLine(to: CGPoint(x: rect.midX + 100, y: rect.minY + 100))
		path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		
		return path
	}
}

struct ColorCyclingRectangle : View{
	var amount = 0.9
	var steps : Int = 100
	var body: some View {
		ZStack{
			ForEach(0..<steps) { value in
				Circle()
					.inset(by: CGFloat(value))
					.strokeBorder(LinearGradient(gradient:
						Gradient(colors: [
							self.color(for: value, brightness: 1),
							self.color(for: value, brightness: 0.1)
						])
						, startPoint: .top,
						  endPoint: .bottom),
						lineWidth: 2)
			}
		}
	}
	
	func color(for value: Int, brightness: Double) -> Color {
		var targetHue = Double(value) / Double(self.steps) + self.amount
		
		if targetHue > 1 { targetHue -= 1 }
		return Color(hue: targetHue, saturation: 1, brightness: brightness)
	}
}


struct ContentView: View {
	@State private var thiknessAmount = 10.0
	@State private var colorCycle = 0.0
	
    var body: some View {
		 
		 VStack {
			 Arrow()
				 .stroke(.blue, style: StrokeStyle(lineWidth: thiknessAmount, lineCap: .round, lineJoin: .round))
				 .onTapGesture {
					 withAnimation {
						 thiknessAmount = Double.random(in: 10...90)
					 }
				 }
			 ColorCyclingRectangle(amount: self.colorCycle)
				 .frame(width: 300, height: 300)
			 Slider(value: $colorCycle)
		 }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
