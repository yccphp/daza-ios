/**
 * Copyright (C) 2015 JianyingLi <lijy91@foxmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit

class HomeEventsController: BaseListController<Event> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("home.events.title")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.tableView.registerClass(EventItemCell.self, forCellReuseIdentifier: "EventItemCell")
        self.tableView.registerNib(UINib(nibName: "EventItemCell", bundle: nil), forCellReuseIdentifier: "EventItemCell")
        
        self.firstRefreshing()
    }
    
    override func loadData(page: Int) {
        let completionBlock = { (pagination: Pagination!, data: [Event]!, error: NSError!) -> Void in
            self.loadComplete(pagination, data)
        }
        Api.getEventList(page, completion: completionBlock)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: EventItemCell = tableView.dequeueReusableCellWithIdentifier("EventItemCell", forIndexPath: indexPath) as! EventItemCell
        
        let data = self.itemsSource[indexPath.row]
        
        cell.data = data
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        let data = self.itemsSource[indexPath.row]
        
        let controller = EventDetailController(data)
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}