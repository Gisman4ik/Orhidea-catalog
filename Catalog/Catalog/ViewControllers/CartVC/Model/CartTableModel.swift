import Foundation

enum CartTableModel: CaseIterable {
    case priceOnTop
    case orderBtn
    case itemInCart
    case total
    
    func getCells() -> [[CartTableModel]] {
        var resultArr: [[CartTableModel]] = []
        let firstSection = [Self.priceOnTop,Self.orderBtn]
        var secondSection: [CartTableModel] = []
        for _ in RealmManager.shared.readFromCart() {
            secondSection.append(Self.itemInCart)
        }
        let thirdSection = [Self.total]
        resultArr.append(contentsOf: [firstSection,secondSection,thirdSection])
        return resultArr
    }
}
