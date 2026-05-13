import Foundation

public struct MeasurementConverter {
    public static func formatDistance(_ distance: Measurement<UnitLength>) -> String {
        let formatter = MeasurementFormatter()
        
        formatter.unitOptions = .naturalScale
        formatter.numberFormatter.maximumFractionDigits = 1
        
        return formatter.string(from: distance)
    }
}
