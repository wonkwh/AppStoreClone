//
//  Date+.swift
//  DesignKit-iOS
//
//  Created by ios_dev on 2020/01/02.
//  Copyright © 2020 vingle. All rights reserved.
//

import Foundation

public extension Date {
    enum WeekDay: Int {
        case sunday = 1
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
    }

    // get year
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }

    // get month
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }

    // get week
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }

    // get day
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }

    // get hour
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }

    // get minute
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }

    // get second
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }

    var relativeTime: String {
        let now = Date()
        let agoTextKey = "이내"
        if now.years(from: self) > 0 {
            return now.years(from: self).description + "년 \(agoTextKey)"
        }
        if now.months(from: self) > 0 {
            return now.months(from: self).description + "달 \(agoTextKey)"
        }
        if now.weeks(from: self) > 0 {
            return now.weeks(from: self).description + "주 \(agoTextKey)"
        }
        if now.days(from: self) > 0 {
//            if now.days(from: self) == 1 { return "yesterday" }
            return now.days(from: self).description + "일 \(agoTextKey)"
        }
        if now.hours(from: self) > 0 {
            return now.hours(from: self).description + "시간 \(agoTextKey)"
        }
        if now.minutes(from: self) > 0 {
            return now.minutes(from: self).description + "분 \(agoTextKey)"
        }
        if now.seconds(from: self) > 0 {
            if now.seconds(from: self) < 5 {
                return "방금 전"
            }

            if now.seconds(from: self) < 10 {
                return "10초 \(agoTextKey)"
            }
            return now.seconds(from: self).description + "초 \(agoTextKey)"
        }

        return ""
    }
}
