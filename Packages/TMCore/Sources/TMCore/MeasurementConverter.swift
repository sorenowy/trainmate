import Foundation

public enum MeasurementConverter {
    public static func formatDistance(_ distance: Measurement<UnitLength>) -> String {
        let formatter = MeasurementFormatter()

        formatter.unitOptions = .naturalScale
        formatter.numberFormatter.maximumFractionDigits = 1

        return formatter.string(from: distance)
    }
    
    public static var localHeightUnit: UnitLength {
        Locale.current.measurementSystem == .us ? .feet : .meters
    }
    
    public static var localWeightunit: UnitMass {
        Locale.current.measurementSystem == .us ? .pounds : .kilograms
    }
    
    public static func convertWeight(value: Double) -> Double {
        let metric = Measurement(value: value, unit: UnitMass.kilograms)
        return metric.converted(to: localWeightunit).value
    }
    
    public static func convertHeight(value: Double) -> Double {
        let metric = Measurement(value: value, unit: UnitLength.centimeters)
        return metric.converted(to: localHeightUnit).value
    }
}
