# LinkSync
## https://lnkd.in/p/ekdah7Dw
## 📱 About The App
**LinkSync** is a real-time, cross-platform productivity workspace designed to capture, organize, and synchronize links, videos, and tasks seamlessly between mobile devices and laptops inside dedicated chat rooms. It eliminates the friction of losing important links across different apps or sending messages to oneself on social media, integrating directly into the system's share sheet and offering a smart, automated 4-color priority lifecycle.

---

## 🎥 Demo Video
[Watch the Demo Video Here](https://www.linkedin.com/in/)

---

## 📊 Project Statistics
* **9 Modular Features & 26+ Responsive Screens**
* **Cross-Platform Support** (Mobile: Android & iOS | Desktop: Windows, macOS, Web)
* **Real-time Synchronization Engine** (<500ms multi-device latency)
* **Firebase Backend** (Auth & Realtime Cloud Firestore)
* **Feature-First Clean Architecture**
* **100% Offline-First Persistence** (Firestore Cache)
* **Zero-Cost Device Pairing** (Camera QR Scanning & 6-Digit PIN)
* **Native System Share Intent Integration**
* **Client-Side OpenGraph Metadata Scraper**
* **Dark & Light Modern Themes**

---

## ✨ Key Features
✔ **Cross-Platform Real-Time Sync:** Instant bidirectional synchronization between phone and desktop.  
✔ **Categorized Chat Workspaces:** Organize links and tasks into dedicated topical chats (e.g., Coding, Education, Work).  
✔ **1-Tap External Share Sheet:** Capture links directly from YouTube, Chrome, or social apps without opening the app.  
✔ **Smart 4-Tier Color Status System:**  
  * 🟢 **Green:** Completed items (strikethrough text).  
  * 🟡 **Amber/Yellow:** High-priority items (remains important indefinitely).  
  * 🔴 **Red:** Overdue alerts (automatically turns red after 3 days without completion).  
  * 🔵 **Blue:** Normal, active items.  
✔ **Rich Link Previews:** Client-side OpenGraph scraping for thumbnails, titles, and site domains.  
✔ **Task Management & Subtasks:** Granular checklist subtasks, priority levels, and deadline date-pickers.  
✔ **Contextual Multi-Selection:** Long-press action mode (Mark Done, Star Important, Delete, Move to another chat).  
✔ **Seamless Device Pairing:** Instant laptop pairing via QR code or 6-digit PIN with $0 external server cost.  
✔ **Custom Chat Lists & Filtering:** Filter chats by All, Overdue, or Important.  
✔ **Personalized Chat Wallpapers:** Global and per-chat wallpaper customization (presets + gallery upload).  
✔ **Responsive Desktop Split-View:** Two-column desktop layout (Sidebar list + active chat panel).  
✔ **Dark & Light Modes:** OLED-friendly midnight slate dark mode and crisp modern light theme.  

---

## 📸 Screenshots

### Onboarding & Authentication
<p align="center">
  <img src="App Screens/splash.jpeg" width="200"/>
  <img src="App Screens/onboarding.jpeg" width="200"/>
  <img src="App Screens/login.jpeg" width="200"/>
  <img src="App Screens/register.jpeg" width="200"/>
</p>

### Home & Chat Workspaces
<p align="center">
  <img src="App Screens/home.jpeg" width="200"/>
  <img src="App Screens/chat_view.jpeg" width="200"/>
  <img src="App Screens/selection_mode.jpeg" width="200"/>
  <img src="App Screens/empty_chat.jpeg" width="200"/>
</p>

### Task Details & Sharing
<p align="center">
  <img src="App Screens/task_details.jpeg" width="200"/>
  <img src="App Screens/share_sheet.jpeg" width="200"/>
  <img src="App Screens/move_dialog.jpeg" width="200"/>
</p>

### Device Pairing & Desktop UI
<p align="center">
  <img src="App Screens/linked_devices.jpeg" width="200"/>
  <img src="App Screens/qr_scanner.jpeg" width="200"/>
  <img src="App Screens/manual_pin.jpeg" width="200"/>
  <img src="App Screens/desktop_split.jpeg" width="400"/>
</p>

### Settings & Dark Mode
<p align="center">
  <img src="App Screens/settings.jpeg" width="200"/>
  <img src="App Screens/edit_profile.jpeg" width="200"/>
  <img src="App Screens/custom_list.jpeg" width="200"/>
  <img src="App Screens/dark_chat.jpeg" width="200"/>
</p>

---

## 🛠️ Tech Stack
* **Framework & Language:** Flutter & Dart
* **State Management:** Flutter BLoC / Cubit & Equatable
* **Backend & Cloud:** Firebase Auth, Cloud Firestore, Google Sign-In
* **Dependency Injection:** GetIt (Service Locator)
* **System Integration:** `receive_sharing_intent` (Native Share Sheet)
* **Device Pairing:** `qr_flutter` (Desktop generator) & `mobile_scanner` (Camera scanner)
* **Link Scraping & Launching:** `metadata_fetch` / `any_link_preview` & `url_launcher`
* **Local Storage & Cache:** `shared_preferences` & `hive_flutter`
* **Media & UI:** `cached_network_image`, `image_picker`, `file_picker`, `intl`
* **Notifications:** `flutter_local_notifications`

---

## 🏗️ Architecture
The project strictly implements **Feature-First Clean Architecture** divided into **9 cohesive domain modules** (`lib/features/`):
```text
lib/
  ├── core/               (Theme, Routing, DI, Services, Global Widgets)
  └── features/
        ├── splash/
        ├── onboarding/
        ├── auth/         (Login, Register, Reset Password)
        ├── device_pairing/ (QR Scanner, PIN Entry, Linked Devices)
        ├── home/         (Chats List, Quick Filters, New Chat Dialog)
        ├── chat/         (Color Bubbles, Rich Previews, Selection Bar, Info)
        ├── task_details/ (Subtasks Checklist, Priority, Deadline)
        ├── share_intent/ (External Share Receiver Bottom Sheet)
        └── settings/     (Profile, Custom Lists, Wallpapers, Appearance)
```
Each feature encapsulates its own `data/` (models & repos), `logic/` (Cubit & state), and `ui/` (`views/` and dedicated separate `widgets/`), ensuring high maintainability and zero code duplication.

---

## 🔥 Technical Highlights
* **Zero-Cost Native Pairing Protocol:** Implemented a WhatsApp-style QR authentication flow using Firestore temporary session documents and reactive stream listeners (`snapshots()`), removing the need for paid WebSockets or third-party auth gateways.
* **On-Device OpenGraph Scraper:** Directly parses HTML OpenGraph meta tags on the client to extract high-resolution thumbnails, article titles, and site domains, avoiding third-party server scraper costs.
* **Reactive Color Priority Engine:** Implemented an automated background evaluation algorithm checking timestamps dynamically: items older than 3 days automatically render with crimson red urgency badges, while starred items permanently maintain high-contrast amber styling.
* **Native OS Share Intent Integration:** Configured platform-level intent filters on Android and iOS to enable immediate receiving of shared URLs and media from external apps into a dedicated modal bottom sheet.
* **Offline-First Resilience:** Backed by Firestore offline persistence and local storage fallback, allowing full browsing, subtask management, and editing without an active internet connection.
* **Strict Flutter Widget Separation:** Zero helper-methods returning widgets; every reusable component is isolated in its own file with dedicated `ViewBody` orchestration.

---

## 👨‍💻 Author
Developed by **Eslam Emad**

