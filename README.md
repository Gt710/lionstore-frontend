# LionStore - Repair Service CRM 🛠️

**LionStore** is a modern cross-platform application built with Flutter designed to streamline operations for repair service centers. It allows technicians and administrators to efficiently manage repair tickets, track statuses, and organize team workflows.

---

## 📱 Interface & Design

The application features a clean, responsive UI designed for efficiency. While the screenshots below demonstrate the **Light Theme**, the application fully supports a professional **Dark Mode** for low-light environments.

|  |  |
|:---:|:---:|
| ![Dashboard](assets/screenshots/Screenshot%201.png) | ![Create Ticket](assets/screenshots/Screenshot%202.png) |
|  |  |

|  |  |
|:---:|:---:|
| ![Search](assets/screenshots/Screenshot%203.png) | ![Admin Profile](assets/screenshots/Screenshot%204.png) |
|  |  |

*(Screenshots are located in `assets/screenshots/`)*

---

## ✨ Key Features

* **📊 Activity Dashboard:** Real-time overview of recent repair tickets with status indicators (In Progress, Ready, Waiting).
* **🎫 Ticket Management:**
    * Create and edit repair entries.
    * Track device details (e.g., iPhone 13 Pro, MacBook Air).
    * Manage customer information and repair costs.
* **🎨 Dynamic Theming:** Built-in support for **Light** and **Dark** themes, adjustable in settings or following the system preference.
* **👥 Admin & Team:**
    * Administrator profile management.
    * Team management capabilities for overseeing technicians.
* **📱 Cross-Platform:** Optimized for Android, iOS, Web, and Desktop usage.

## 🛠️ Tech Stack

This project implements modern Flutter best practices:

* **Framework:** Flutter (Dart 3.10+)
* **State Management:** Provider (`ChangeNotifier`)
* **Architecture:** Clean Architecture (separated into `presentation`, `domain`, `core` layers)
* **UI Components:** Material Design 3, Cupertino Icons, Google Fonts
* **Routing:** Standard Flutter Navigator

## 🚀 Getting Started

To run this project locally, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/lionstore.git](https://github.com/your-username/lionstore.git)
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    ```bash
    flutter run
    ```

## 📂 Project Structure

```text
lib/
├── core/            # Core configuration (themes, providers)
├── domain/          # Data models (RepairTicket)
├── presentation/    # UI Layer
│   ├── pages/       # Screens (Dashboard, CreateTicket, Admin, etc.)
│   └── widgets/     # Reusable components (RepairTile, StatusBadge)
└── main.dart        # Entry point