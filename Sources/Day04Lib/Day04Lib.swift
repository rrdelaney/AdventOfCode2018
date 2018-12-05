import Foundation

enum Event: Comparable {
  case beginShift(Date, String)
  case fallAsleep(Date)
  case wakeUp(Date)

  var date: Date {
    switch self {
    case let .beginShift(date, _): return date
    case let .fallAsleep(date): return date
    case let .wakeUp(date): return date
    }
  }

  static func ==(lhs: Event, rhs: Event) -> Bool {
      return lhs.date == rhs.date
  }
  static func <(lhs: Event, rhs: Event) -> Bool {
      return lhs.date < rhs.date
  }
}

func parseEvent(from: String) -> Event {
  let EventDateFormatter = DateFormatter()
  EventDateFormatter.locale = Locale(identifier: "en_US_POSIX")
  EventDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
  EventDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

  let split = from.components(separatedBy: "] ")
  let dateStr = String(split[0].dropFirst())
  let eventStr = split[1]

  let date = EventDateFormatter.date(from: dateStr)!

  if eventStr.starts(with: "falls") {
    return .fallAsleep(date)
  }

  if eventStr.starts(with: "wakes") {
    return .wakeUp(date)
  }

  let eventSplit = eventStr.components(separatedBy: " ")
  let id = eventSplit[1]
  return .beginShift(date, id)
}

func buildTimeline(events: [Event]) -> [(String, Date, Date)] {
  var intervals: [(String, Date, Date)] = []
  var lastSleep = Date.distantPast
  var currentGuard = ""

  for event in events {
    switch event {
    case let .beginShift(date, id):
      lastSleep = date
      currentGuard = id
    case let .fallAsleep(date):
      lastSleep = date
    case let.wakeUp(date):
      intervals.append((currentGuard, lastSleep, date))
    }
  }

  return intervals
}

func enumerateMinutes(from: Date, to: Date) -> [Int] {
  let EventDateFormatter = DateFormatter()
  EventDateFormatter.locale = Locale(identifier: "en_US_POSIX")
  EventDateFormatter.dateFormat = "mm"
  EventDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

  var minutes: [Int] = []

  var current = from
  while current < to {
    let minute = Int(EventDateFormatter.string(from: current))!
    minutes.append(minute)

    current = Calendar.current.date(byAdding: .minute, value: 1, to: current)!
  }

  return minutes
}

public func getStrategy1Guard(events eventStrs: [String]) -> Int {
  var events = eventStrs.map(parseEvent)
  events.sort()

  let timeline = buildTimeline(events: events)
  var guardByMinutes: [String: [Int]] = [:]
  for (id, start, end) in timeline {
    let minutes = enumerateMinutes(from: start, to: end)
    if let _ = guardByMinutes[id] {
      guardByMinutes[id]!.append(contentsOf: minutes)
    } else {
      guardByMinutes[id] = minutes
    }
  }

  let (id, minutes) = guardByMinutes.max { a, b in a.value.count < b.value.count }!
  let idNum = Int(String(id.dropFirst()))!

  var minuteBySleep: [Int: Int] = [:]
  for minute in minutes {
    if let _ = minuteBySleep[minute] {
      minuteBySleep[minute] = 1 + minuteBySleep[minute]!
    } else {
      minuteBySleep[minute] = 1
    }
  }

  let (maxMinutes, _) = minuteBySleep.max { a, b in a.value < b.value }!

  return idNum * maxMinutes
}

struct IdAndMinute: Hashable {
  let id: String
  let minute: Int
}

public func getStrategy2Guard(events eventStrs: [String]) -> Int {
  var events = eventStrs.map(parseEvent)
  events.sort()

  let timeline = buildTimeline(events: events)
  var guardByMinutes: [IdAndMinute: Int] = [:]
  for (id, start, end) in timeline {
    for minute in enumerateMinutes(from: start, to: end) {
      let idAndMinute = IdAndMinute(id: id, minute: minute)
      if let _ = guardByMinutes[idAndMinute] {
        guardByMinutes[idAndMinute] = 1 + guardByMinutes[idAndMinute]!
      } else {
        guardByMinutes[idAndMinute] = 1
      }
    }
  }

  let (idAndMinute, _) = guardByMinutes.max { a, b in a.value < b.value }!
  let idNum = Int(String(idAndMinute.id.dropFirst()))!
  return idNum * idAndMinute.minute
}
