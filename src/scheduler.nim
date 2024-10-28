type
  Task* = ref object
    id*: uint16
    stackPtr*: pointer
    entryPoint*: proc()
    state*: string
var
  tasks*: seq[Task] = @[]
  currentTask*: uint16 = 0

proc newTask*(entryPoint: proc()) =
  let taskId = tasks.len.uint16
  let newTask = Task(id: taskId, entryPoint: entryPoint, state: "ready")
  tasks.add(newTask)

proc endTask*(targetTask: Task) =
  if tasks.contains(targetTask):
    let taskRef = tasks.find(targetTask)
    tasks.delete(taskRef)
  else:
    echo "Task not found!"
