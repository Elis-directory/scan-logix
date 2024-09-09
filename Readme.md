# BOS_Scanner

**BOS_Scanner** is an iOS application designed for barcode scanning, item management, and searching functionality. The app allows users to scan barcodes, look up item details, add new items, search through existing entries, and manage settings, all within a clean, easy-to-use interface.

## Features

### 1. Barcode Scanning
   - **File:** `Scan/BarcodeScannerView.swift`
   - Utilizes `AVFoundation` to scan barcodes and match them to existing items in the database.
   - If no match is found, users are prompted to add a new item.

### 2. Item Management
   - **Files:**
     - `Home/AddItemView.swift`: Allows users to add new items to the database.
     - `Home/DisplayEntry.swift`: Displays detailed information for a specific entry.
   - Supports adding, editing, and deleting entries related to scanned items.

### 3. Search Functionality
   - **File:** `Search/SearchPage.swift`
   - Provides a search interface for users to filter items by name, UPC, or category.
   - Includes real-time updates based on the search query.

### 4. Settings Management
   - **File:** `Settings/SettingsPage.swift`
   - Allows users to toggle preferences such as dark mode, tracking, local storage, and data sharing.
   - Displays privacy information and user disclaimers.

### 5. Experimental Features
   - **File:** `Experimental/MainAppView.swift`
   - This section is for testing and experimenting with new features before they are finalized.

## Project Structure

The project is organized into the following main directories:

### **Home**
   Handles the main functionality for adding, displaying, and managing items.

   - **Files:**
     - `Title.swift`: Provides title UI components for the home screen.
     - `CameraView.swift`: Provides functionality for capturing photos or videos.
     - `AddItemView.swift`: View for adding new entries to the database.
     - `HomePage.swift`: The main page for navigating through the home screen.
     - `DisplayEntry.swift`: Shows detailed information about specific entries.

### **Scan**
   - Includes the `BarcodeScannerView.swift` file, which handles barcode scanning functionality using `AVFoundation` and matching barcodes to existing items in the database.

### **Search**
   - The `SearchPage.swift` file handles the search functionality, allowing users to search for items by name, UPC, or category.

### **Settings**
   - Includes the `SettingsPage.swift` file, which contains user settings and privacy-related information.

### **Experimental**
   - The `MainAppView.swift` file is used for testing new features before implementing them into the core application.

### **Assets.xcassets**
   - Contains image and color assets for the app.

## Getting Started

### Prerequisites
- Xcode 14 or later
- iOS 17.0 or later for device or simulator

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/BOS_Scanner.git
    ```
2. Open the project in Xcode:
    ```bash
    open BOS_Scanner.xcodeproj
    ```
3. Run the app on a simulator or device:
    - Select a target device or simulator from the toolbar.
    - Click the **Run** button or press `Cmd + R`.

## Usage

### Barcode Scanning
- Navigate to the **Scan** tab to start scanning barcodes.
- If the scanned barcode matches an existing item, it will display the item's details.
- If no match is found, an alert will prompt you to add a new item.

### Search Items
- Navigate to the **Search** tab and type into the search bar to filter items by name, UPC, or category.

### Settings
- Navigate to the **Settings** tab to modify preferences such as dark mode, tracking, local storage, and data sharing. You can also review the privacy statement and app disclaimer.

## Future Development

- The app structure allows easy expansion with future features.
- The **Experimental** folder contains a space for trying out new components and features.

## Contributing

Contributions are welcome! If you have suggestions for new features, improvements, or bug fixes, feel free to submit a pull request.


