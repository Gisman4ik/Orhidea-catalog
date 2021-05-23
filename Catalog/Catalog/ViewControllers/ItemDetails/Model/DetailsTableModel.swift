import Foundation

enum DetailsTableModel: CaseIterable {
    case itemImage
    case article
    case price
    case color
    case sizeChart
    case addToCart
    
    func getAvailableCells(data: Product?) -> [DetailsTableModel] {
        
        var cellsArray: [DetailsTableModel] = []
        
        if data?.imageURLString != nil {
            cellsArray.append(Self.itemImage)
        }
        if data?.title != nil {
            cellsArray.append(Self.article)
        }
        if data?.price != nil {
            cellsArray.append(Self.price)
        }
        if data?.color != nil {
            cellsArray.append(Self.color)
        }
        if data?.sizeChart != nil {
            cellsArray.append(Self.sizeChart)
        }
        cellsArray.append(contentsOf: [Self.addToCart])
        
        return cellsArray
    }
}
