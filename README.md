This is a small project that allows a user to record audio on a button press, name the file, and listen to it when accessed in a table view.

In a larger architecture, the recording feature would be accessed from anywhere within an app. Upon the completion of the recording, the user would be able to indicate the location at which it should be associated, whether that is the current location or one chosen by the user. The user would also be able to add to or edit the recording. The date and time of the recording (and possibly each edit) would also be saved with it.

The recordings could be stored locally in a database (such as Sqlite), along with their date, time, and location. They could then be pushed to a database in the cloud when an internet connection permits. Other clients would be able to access this data when connected.

Within the current user’s app, the recordings could populate on a map, which, when loaded, would query the database to look for recordings that were made within the map’s bounds. When retrieved, the recordings could populate the map with icons placed at their recording locations. The recordings could be accessed and played by tapping on the icons.