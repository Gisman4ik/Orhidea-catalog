import Foundation

protocol ProductAmountDelegate {
    func getProductAmount (amount: Int)
    func sendProductAmount () -> Int
}
