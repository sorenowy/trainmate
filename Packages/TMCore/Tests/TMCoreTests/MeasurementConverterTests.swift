import Testing
@testable import TMCore
import Foundation

@Suite("[TMCore] Measurement Converter Tests")
struct MeasurementConverterTests {
    
    @Test("Formatting distance based on region")
    func testDistanceFormattingBasedOnLocale() {
        let distance = Measurement(value: 5, unit: UnitLength.kilometers)
        
        let formattedDistance = MeasurementConverter.formatDistance(distance)
        
        let currentRegion = Locale.current.region?.identifier ?? "PL"
        
        if currentRegion == "US" {
            #expect(formattedDistance.contains("mi"), "Converter failed to convert to miles")
            #expect(formattedDistance.contains("3.1"), "Converter failed to convert to miles from km")
        } else {
            #expect(formattedDistance.contains("5 km"), "Converter failed to keep it as KM")
            #expect(formattedDistance.contains("5"), "Converter failed to keep it as KM")
        }
    }
}
