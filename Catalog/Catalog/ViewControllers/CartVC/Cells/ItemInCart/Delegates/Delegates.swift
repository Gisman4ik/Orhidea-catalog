import Foundation

protocol DeletableItem: AnyObject {
    func deleteItem ()
}

protocol Updatable {
    func update()
}
