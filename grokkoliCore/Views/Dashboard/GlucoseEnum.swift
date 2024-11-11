//
//  GlucoseEnum.swift
//  grokkoli
//  Created by Jen on 11/5/24.
//

import SwiftUI

enum GlucoseEnum {
	case high
	case borderline
	case normal
	case low
	case dangerLow
	
	var message: String {
		switch self {
			case .high:
				return "Medical Attention Needed"
			case .borderline:
				return "Consult Doctor"
			case .normal:
				return "No Action Needed"
			case .low:
				return "Consult Doctor"
			case .dangerLow:
				return "Medical Attention Needed"
		}
	}
	
	var color: Color {
		switch self {
			case .high, .dangerLow:
				return .darkRed
			case .borderline:
				return .darkOrange
			case .normal:
				return .darkGreen
			case .low:
				return .blue
		}
	}
	
	var riskLevel: String {
		switch self {
			case .high, .dangerLow:
				return "High"
			case .borderline, .low:
				return "Borderline"
			case .normal:
				return "No Risk"
		}
	}
	
	static func fromGlucoseLevel(_ level: Int) -> GlucoseEnum {
		switch level {
			case 181...:
				return .high
			case 120..<180:
				return .borderline
			case 72..<120:
				return .normal
			case 50..<72:
				return .low
			default:
				return .dangerLow
		}
	}
}
