import SwiftUI

final class ToDoListViewModel: ObservableObject {
    // MARK: - Private properties
    
    private let repository: ToDoListRepositoryType
    private var arrayOfOTodLit : [ToDoItem] = []
    private var curentFilterIndex : Int = 0
    private var filteredTodoItems : [ToDoItem] = []
    // MARK: - Init
    
    init(repository: ToDoListRepositoryType) {
        self.repository = repository
        self.toDoItems = repository.loadToDoItems()
        self.toDoItems = self.arrayOfOTodLit
        
    }
    
    // MARK: - Outputs
    
    /// Publisher for the list of to-do items.
    @Published var toDoItems: [ToDoItem] = [] {
        didSet {
            repository.saveToDoItems(toDoItems)
        }
    }
    
    // MARK: - Inputs
    
    // Add a new to-do item with priority and category
    func add(item: ToDoItem) {
        arrayOfOTodLit.append(item)
        applyFilter(at:curentFilterIndex)
        
    }
    
    /// Toggles the completion status of a to-do item.
    func toggleTodoItemCompletion(_ item: ToDoItem) {
        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
            arrayOfOTodLit[index].isDone.toggle()
            applyFilter(at:curentFilterIndex)
        }
    }
    
    /// Removes a to-do item from the list.
    func removeTodoItem(_ item: ToDoItem) {
        arrayOfOTodLit.removeAll { $0.id == item.id }
        applyFilter(at:curentFilterIndex)
    }
    
    /// Apply the filter to update the list.
    func applyFilter(at index: Int) {
        // TODO: - Implement the logic for filtering
        switch index {
        case 1 : toDoItems = arrayOfOTodLit.filter{$0.isDone}
        case 2 : toDoItems = arrayOfOTodLit.filter{!$0.isDone}
        default: toDoItems = arrayOfOTodLit
        
        }
        curentFilterIndex = index
    }
}
