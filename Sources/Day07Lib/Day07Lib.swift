import Foundation

class Task: Comparable, Hashable {
  let name: Character

  var done = false
  var dependents: [Task] = []
  var dependencies: [Task] = []

  var ready: Bool {
    return self.dependencies.allSatisfy { $0.done }
  }

  init(name: Character) {
    self.name = name
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.name)
  }

  static func <(lhs: Task, rhs: Task) -> Bool {
    return lhs.name < rhs.name
  }

  static func ==(lhs: Task, rhs: Task) -> Bool {
    return lhs.name == rhs.name
  }
}

class TaskGraph {
  var tasksByName: [Character: Task] = [:]

  func declareDependency(_ task: Character, dependsOn: Character) {
    if self.tasksByName[task] == nil {
      self.tasksByName[task] = Task(name: task)
    }

    if self.tasksByName[dependsOn] == nil {
      self.tasksByName[dependsOn] = Task(name: dependsOn)
    }

    guard let parent = self.tasksByName[dependsOn] else {
      return
    }

    guard let child = self.tasksByName[task] else {
      return
    }

    parent.dependents.append(child)
    child.dependencies.append(parent)
  }

  var roots: [Task] {
    return self.tasksByName.values.filter { $0.dependencies.count == 0}
  }

  init(steps stepStrs: [String]) {
    for step in stepStrs {
      let dependency = step[step.index(step.startIndex, offsetBy: 5)]
      let dependent = step[step.index(step.startIndex, offsetBy: 36)]
      self.declareDependency(dependent, dependsOn: dependency)
    }
  }
}

public func getComputationOrder(steps stepStrs: [String]) -> String {
  let taskGraph = TaskGraph(steps: stepStrs)
  var currentTasks: Set<Task> = Set(taskGraph.roots)
  var taskOrder = ""

  while currentTasks.count > 0 {
    guard let nextTask = currentTasks.sorted().first(where: { $0.ready }) else {
      break
    }

    taskOrder += String(nextTask.name)
    nextTask.done = true
    currentTasks.remove(nextTask)
    currentTasks.formUnion(nextTask.dependents)
  }

  return taskOrder
}

struct UnitOfWork {
  let doneAt: Int
  let task: Task

  init(task: Task, currentTime: Int, taskStartupDelay: Int) {
    self.task = task
    self.doneAt = currentTime + (Int(task.name.unicodeScalars.first!.value) - 64) + taskStartupDelay
  }
}

public func getTimeForComputation(steps stepStrs: [String], numWorkers: Int, taskStartupDelay: Int) -> Int {
  let taskGraph = TaskGraph(steps: stepStrs)
  var workers = [UnitOfWork?](repeating: nil, count: numWorkers)

  var currentTime = 0
  var currentTasks: Set<Task> = Set(taskGraph.roots)

  while currentTasks.count > 0 || workers.contains(where: { $0 != nil }) {
    var readyTasks = currentTasks.sorted().filter({ $0.ready })

    for workerNum in 0..<workers.count {
      if let uow = workers[workerNum] {
        if uow.doneAt == currentTime {
          workers[workerNum] = nil
          let completedTask = uow.task
          completedTask.done = true
          currentTasks.formUnion(completedTask.dependents)
          readyTasks = currentTasks.sorted().filter({ $0.ready })
        }
      }

      if workers[workerNum] == nil && readyTasks.count > 0 {
        let nextTask = readyTasks.removeFirst()
        currentTasks.remove(nextTask)
        workers[workerNum] = UnitOfWork(task: nextTask, currentTime: currentTime, taskStartupDelay: taskStartupDelay)
      }
    }

    currentTime += 1
  }

  return currentTime - 1
}
