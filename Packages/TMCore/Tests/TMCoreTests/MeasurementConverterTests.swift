import Foundation
import Testing
@testable import TMCore

@Suite("[TMCore] Measurement Converter Tests")
struct MeasurementConverterTests {
    @Test("Formatting distance based on region")
    func distanceFormattingBasedOnLocale() {
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
    
    @Test("Determining local mass unit based on system")
    func localMassUnitResolution() {
        let isUS = Locale.current.measurementSystem == .us
        
        if isUS {
            #expect(MeasurementConverter.localWeightunit == .pounds)
        } else {
            #expect(MeasurementConverter.localWeightunit == .kilograms)
        }
    }
    
    @Test("Determining local height/length unit based on system")
    func localHeightUnitResolution() {
        let isUS = Locale.current.measurementSystem == .us
        
        if isUS {
            #expect(MeasurementConverter.localHeightUnit == .feet)
        } else {
            #expect(MeasurementConverter.localHeightUnit == .centimeters)
        }
    }
}
