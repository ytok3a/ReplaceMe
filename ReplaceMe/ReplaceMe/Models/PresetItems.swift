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
                       category: "",
                       disclaimer: "The National Fire Protection Association (NFPA) recommends changing the batteries in your smoke detectors every year. ",
                       link: "https://www.nfpa.org/News-and-Research/Publications-and-media/Blogs-Landing-Page/Safety-Source/Blog-Posts/2022/03/11/Change-your-clocks-check-your-smoke-alarm-batteries#:~:text=Smoke%20alarms%20with%20non%2Dreplaceable,at%20least%20once%20a%20year.")

let presets = [item0, item1, item2, item3, item4, item5, item6, item7, item8]

