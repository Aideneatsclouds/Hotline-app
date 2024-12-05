
### **Steps to Install and Run the Hotline App**

1. **Install Flutter**  
   - Follow the instructions to install Flutter from [Flutter's official site](https://flutter.dev/docs/get-started/install).  
   - Ensure you have the Flutter SDK, and add Flutter to your system's PATH.

2. **Set Up the Editor (Visual Studio Code)**  
   - Install Visual Studio Code from [VS Code's official site](https://code.visualstudio.com/).  
   - In VS Code, install the Flutter and Dart extensions from the Extensions Marketplace for Flutter development.

3. **Download the Source Code**  
   - Download the entire project as a zip file.  
   - Extract the zip file to a location of your choice on your system.

4. **Open the Project in VS Code**  
   - Launch VS Code.  
   - Open the extracted project folder by selecting **File > Open Folder** and navigating to the project directory.

5. **Set Up an Android Device or Emulator**  
   - **Option 1: Android Device**  
     - Connect an Android device to your computer via USB.  
     - Enable **Developer Options** and **USB Debugging** on your device.  
   - **Option 2: Android Emulator**  
     - Install Android Studio and set up an Android Emulator by following [these steps](https://developer.android.com/studio/run/emulator).

6. **Fetch Dependencies**  
   - Open the integrated terminal in VS Code (`Ctrl + ` ``).  
   - Navigate to the project directory if not already there.  
   - Run the command:  
     ```bash
     flutter pub get
     ```
   - This will download all required dependencies for the project.

7. **Run the App**  
   - Ensure your Android device or emulator is detected by running:  
     ```bash
     flutter devices
     ```  
   - You should see your device or emulator listed.  
   - Run the app using the command:  
     ```bash
     flutter run
     ```  
   - Alternatively, press `F5` in VS Code to launch the app.


### **Note**  
- The app performs better on an actual Android device compared to an emulator.  
- If you encounter issues during the installation or running process, double-check the Flutter setup and device/emulator connection.  

