//___FILEHEADER___

import UIKit

extension UITableView {
    
    /**
     Prevent app crash because of table view number of rows and table view datasource inconsistency
     Example: Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid update: bla bla bla
     
     IMPORTANT: I have tested this code only for single-section table view
     */
    func refreshDataSafely(in section: Int,
                           for dataSource: [Any],
                           _ deletions: [Int],
                           _ insertions: [Int],
                           _ modifications: [Int]) {
        
        let rowsCount = self.numberOfRows(inSection: section)
        let maxReloadIndex = modifications.max() ?? 0
        
        let countCondition = rowsCount - deletions.count + insertions.count == dataSource.count
        let reloadCondition = maxReloadIndex <= dataSource.count - 1
        
        var conflictingIndexes: [Int] = []
        deletions.forEach { deletion in
            insertions.forEach { insertion in
                if deletion == insertion {
                    conflictingIndexes.append(deletion)
                }
            }
        }
        
        guard countCondition && reloadCondition && conflictingIndexes.isEmpty else {
            self.reloadSections(IndexSet(integersIn: section...section), with: .none)
            return
        }
        // Terminating app due to uncaught exception 'NSInternalInconsistencyException',
        // reason: 'attempt to delete and reload the same index path
        var deleteAndReloadSameRow: Bool = false
        for delete in deletions {
            for mod in modifications where mod == delete {
                deleteAndReloadSameRow = true
            }
        }
        guard deleteAndReloadSameRow == false else {
            self.reloadSections(IndexSet(integersIn: section...section), with: .none)
            return
        }
        // Terminating app due to uncaught exception 'NSInternalInconsistencyException',
        // reason: 'attempt to delete and reload the same index path
        // https://habr.com/ru/post/350230/
        self.beginUpdates()
        if !deletions.isEmpty {
            self.deleteRows(at: deletions.map{ IndexPath(row: $0, section: section) }, with: .none)
        }
        if !insertions.isEmpty {
            self.insertRows(at: insertions.map{ IndexPath(row: $0, section: section) }, with: .none)
        }
        self.endUpdates()
        
        self.beginUpdates()
        self.reloadRows(at: modifications.map{ IndexPath(row: $0, section: section) }, with: .none)
        self.endUpdates()
    }
    
}
