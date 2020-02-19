//___FILEHEADER___

import UIKit

extension UITableView {
    
    /**
     Use for cases while you need to update cell content size
     */
    func reloadCellToFitContent(_ indexPath: IndexPath) {
        
        executeOnMain { [weak self] in
            self?.beginUpdates()
            self?.reloadRows(at: [indexPath], with: .none)
            self?.endUpdates()
        }
    }
    
    func isCellVisible(section: Int, row: Int) -> Bool {
        
        guard let indexes = self.indexPathsForVisibleRows else {
            return false
        }
        return indexes.contains{ $0.section == section && $0.row == row }
    }
    
    func refreshHeaderTitle(inSection section: Int) {
        
        executeOnMain { [weak self] in
            guard let `self` = self else { return }
            UIView.setAnimationsEnabled(false)
            self.beginUpdates()
            
            let headerView = self.headerView(forSection: section)
            headerView?.textLabel?.text = self.dataSource?.tableView?(self, titleForHeaderInSection: section)?.uppercased()
            headerView?.sizeToFit()
            
            self.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
    
    func refreshFooterTitle(inSection section: Int) {
        
        executeOnMain { [weak self] in
           guard let `self` = self else { return }
            UIView.setAnimationsEnabled(false)
            self.beginUpdates()
            
            let footerView = self.footerView(forSection: section)
            footerView?.textLabel?.text = self.dataSource?.tableView?(self, titleForFooterInSection: section)
            footerView?.sizeToFit()
            
            self.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
    
    func refreshFooter(inSection section: Int, isHidden: Bool) {
        
        executeOnMain { [weak self] in
            guard let `self` = self else { return }
            UIView.setAnimationsEnabled(false)
            self.beginUpdates()
            
            let footerView = self.footerView(forSection: section)
            footerView?.sizeToFit()
            footerView?.isHidden = isHidden
            
            self.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
    
    func refreshAllHeaderAndFooterTitles() {
        
        executeOnMain { [weak self] in
            guard let `self` = self else { return }
            for section in 0..<self.numberOfSections {
                self.refreshHeaderTitle(inSection: section)
                self.refreshFooterTitle(inSection: section)
            }
        }
    }
    
}
