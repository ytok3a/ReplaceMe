//
//  PresetItems.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/3/23.
//

import Foundation

let item0: Item = Item(name: "", icon: "")

let item1: Item = Item(name: "Fire Extinguisher", 
                       icon: "🧯", 
                       replaceEvery: DateDuration(value: 1, unit: .months),
                       remindBefore: DateDuration(value: 1, unit: .days),
                       notes: "Check the pressure gauge. The needle should be in the green area, and if it isn’t, it’s time to replace the extinguisher (or have it recharged, if that’s an option!)",
                       category: "")
let item2: Item = Item(name: "Water Filter",
                       icon: "💧", 
                       replaceEvery: DateDuration(value: 2, unit: .months),
                       remindBefore: DateDuration(value: 1, unit: .weeks), notes: "",
                       category: "")
let item3: Item = Item(name: "Contact Lens Case",
                       icon: "👁",
                       replaceEvery: DateDuration(value: 3, unit: .months),
                       remindBefore: DateDuration(value: 1, unit: .weeks), notes: "",
                       category: "")
let item4: Item = Item(name: "Toothbrush",
                       icon: "🪥",
                       replaceEvery: DateDuration(value: 3, unit: .months),
                       remindBefore: DateDuration(value: 1, unit: .weeks),
                       notes: "",
                       category: "")
let item5: Item = Item(name: "Sponges",
                       icon: "🧽",
                       replaceEvery: DateDuration(value: 2, unit: .weeks),
                       remindBefore: DateDuration(value: 1, unit: .weeks),
                       notes: "",
                       category: "")
let item6: Item = Item(name: "Pillows",
                       icon: "🛌",
                       replaceEvery: DateDuration(value: 1, unit: .years),
                       remindBefore: DateDuration(value: 1, unit: .weeks),
                       notes: "",
                       category: "")
let item7: Item = Item(name: "Air Filter",
                       icon: "🏠",
                       replaceEvery: DateDuration(value: 1, unit: .years),
                       remindBefore: DateDuration(value: 1, unit: .weeks),
                       notes: "",
                       category: "")
let item8: Item = Item(name: "Smoke Alarm Batteries",
                       icon: "🔋",
                       lastReplaced: Date(),
                       replaceEvery: DateDuration(value: 1, unit: .years),
                       remindBefore: DateDuration(value: 1, unit: .weeks),
                       notes: "",
                       category: "")

let presets = [item0, item1, item2, item3, item4, item5, item6, item7, item8]

