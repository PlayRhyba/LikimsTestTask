# LikimsTestTask
Task:
The task is to write application supporting iOS 7 and above, which will provide the following functionality:
- download data from https://dl.dropboxusercontent.com/u/28129050/mockapi/ testapi.json
- import downloaded data to CoreData, the import should include the entries with valid email address only
- import should exclude duplicates
- import should be performed on user demand, while tapping a button
- import should be performed when the internet connection is available only, otherwise the user should be informed about it with an alert
- during the data import, the user should be informed by displaying the progress hud
- data gathered in CoreData should be displayed using UITableView
- the user should have the possibility to remove each entry separately
- the user should have the possibility to remove all entries using dedicated button
- the user should have the possibility to search for the data, searching should include fields: email and login
- application should be based on UINavigationController
- navigation bar should contain a button which opens UIActionSheet
- presented UIActionSheet should contain buttons for data import and data deletion, described above
- please use AFNetworking and MBProgressHUD libraries
- the libraries should be imported using cocoapods (http://cocoapods.org/)
