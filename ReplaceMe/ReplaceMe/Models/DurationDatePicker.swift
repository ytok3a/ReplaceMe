//
//  DurationDatePicker.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/2/23.
//

//  Credits to Toomas Vahter on 29.01.2022.

import SwiftUI

struct DateDurationPicker: UIViewRepresentable {
    let selection: Binding<DateDuration>
    let values: [Int]
    let units: [DateDuration.Unit]
    
    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator
        return pickerView
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selection: selection, values: values, units: units)
    }
    
    final class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        let selection: Binding<DateDuration>
        let values: [Int]
        let units: [DateDuration.Unit]
        
        init(selection: Binding<DateDuration>, values: [Int], units: [DateDuration.Unit]) {
            self.selection = selection
            self.values = values
            self.units = units
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return component == 0 ? values.count : units.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if component == 0 {
                return "\(values[row])"
            }
            else {
                return units[row].rawValue
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let valueIndex = pickerView.selectedRow(inComponent: 0)
            let unitIndex = pickerView.selectedRow(inComponent: 1)
            selection.wrappedValue = DateDuration(value: values[valueIndex], unit: units[unitIndex])
        }
    }
}

struct DateDuration: Codable {
    let value: Int
    let unit: Unit
    
    enum Unit: String, CaseIterable, Codable {
        case days, weeks, months
    }
    
    var inDays: Int {
        if (unit == .days) {
            return value
        } else if (unit == .weeks) {
            return value*7
        }else if (unit == .months) {
            return value*31
        }
        return 0
    }
        
}

struct DatePickerView_Previews: PreviewProvider {
    static var selection = Binding(
        get: {
            DateDuration(value: 1, unit: .days)
        },
        set: { value in
            print(value)
        })
    
    static var previews: some View {
        DateDurationPicker(selection: selection, values: Array(1..<100), units: DateDuration.Unit.allCases)
    }
}
