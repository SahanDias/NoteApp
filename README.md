#  Flutter Notes App

A simple Flutter Notes App using **Firebase Firestore** for real-time note management. Users can **add, update, and delete** notes efficiently.

##  Features
-  Create, Read, Update, and Delete (CRUD) notes
-  Real-time synchronization with **Firebase Firestore**
-  Clean UI with highlighted notes
-  Fully responsive design

##  Technologies Used
- **Flutter** (Dart)
- **Firebase Firestore** (Database)
- **Material UI Components**

##  Installation
1. **Clone the repository**
   ```sh
   git clone https://github.com/SahanDias/NoteApp
   cd NoteApp
   ```
2. **Install dependencies**
   ```sh
   flutter pub get
   ```
3. **Set up Firebase**
   - Create a Firebase project
   - Add `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) in the respective directories

4. **Run the app**
   ```sh
   flutter run
   ```

##  Project Structure
```
📂 lib/  
 ┣ 📂 pages/  
 ┃ ┣ 📜 home_page.dart      # Main UI screen  
 ┣ 📂 services/  
 ┃ ┣ 📜 firestore.dart      # Firestore database interactions  
 ┣ 📜 main.dart    
```

## 🚀 Future Enhancements
- ✅ Add note categories
- ✅ Implement authentication (Google Sign-In)
- ✅ Cloud backup & export notes as PDF
