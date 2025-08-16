# 🍔 FoodOnTouch - Flutter Food Delivery App
<div align="center">
  <img src="https://raw.githubusercontent.com/HunzlaShafiq/fooddelivery/main/assets/logo.png" width="150" alt="FoodExpress Logo">
  <p>Restaurant-to-door food delivery solution with three user roles</p>
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.19.5-%2302569B?logo=flutter)](https://flutter.dev)
  [![Firebase](https://img.shields.io/badge/Firebase-12.7.1-%23FFCA28?logo=firebase)](https://firebase.google.com)
  [![Provider](https://img.shields.io/badge/Provider-6.1.2-%234285F4)](https://pub.dev/packages/provider)
  [![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
</div>

## 🚀 Features

### For Customers
- 🛍️ Browse restaurants & menus
- 🔍 Search and filter food items
- 🛒 Cart management
- 💳 Multiple payment options
- 📍 Real-time order tracking

### For Restaurant Owners
- 🏪 Store management
- 🍽️ Menu customiztions 

### For Delivery Partners
- 🗺️ route navigation
- 📱 Order pickup confirmation
- ✅ Delivery completion

---

## 📱 Screenshots
<div align="center">
  <img src="screenshots/customer_home.jpg" width="24%" alt="Customer Home">
  <img src="screenshots/restaurant_dashboard.jpg" width="24%" alt="Restaurant Dashboard">
  <img src="screenshots/delivery_app.jpg" width="24%" alt="Delivery App">
  <img src="screenshots/order_tracking.jpg" width="24%" alt="Order Tracking">
</div>

---

## 🛠️ Tech Stack
**Frontend:**
- Flutter (Material 3 Design)
- Provider (State Management)
- Google Maps API
- Razorpay Integration

**Backend:**
- Firebase Authentication
- Cloud Firestore (Database)
- Firebase Storage (Menu Images)
- Firebase Cloud Messaging (Notifications)

---

## 💻 Installation

1.  **Clone the repository**
    ```bash
    git clone [https://github.com/HunzlaShafiq/FoodOnTouch.git](https://github.com/HunzlaShafiq/FoodOnTouch.git)
    cd fooddelivery
    ```

2.  **Setup Firebase**
    ```bash
    flutter pub add firebase_core
    flutterfire configure
    ```

3.  **Install dependencies**
    ```bash
    flutter pub get
    ```

4.  **Run the app**
    ```bash
    flutter run
    ```

---

## 📂 Project Structure
```text
lib/
├── features/
│   ├── customer/       # Customer-facing features
│   ├── restaurant/     # Restaurant management
│   └── delivery/       # Delivery partner features
├── core/
│   ├── constants/      # App constants
│   ├── services/       # Shared services
│   └── widgets/        # Reusable components
└── main.dart           # Entry point
