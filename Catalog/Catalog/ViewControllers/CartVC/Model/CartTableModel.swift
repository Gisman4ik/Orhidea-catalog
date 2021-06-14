import Foundation

enum CartTableModel: CaseIterable {
    case priceOnTop
    case orderBtn
    case itemInCart
    case total
    
   static func getCells() -> [[CartTableModel]] {
        var resultArr: [[CartTableModel]] = []
        let headerSection = [Self.priceOnTop, Self.orderBtn]
        var itemsInCartSection: [CartTableModel] = []
        for _ in RealmManager.shared.readFromCart() {
            itemsInCartSection.append(Self.itemInCart)
        }
        let footerSection = [Self.total]
        resultArr.append(contentsOf: [headerSection, itemsInCartSection, footerSection])
    
        return resultArr
    }
}
