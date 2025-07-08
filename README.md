# TaskFlow 📱💻🌐

**Кроссплатформенное приложение для управления задачами**  
(Flutter + Firebase для iOS, Android и Web)

[![Flutter](https://img.shields.io/badge/Flutter-3.19-blue?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Cloud-orange?logo=firebase)](https://firebase.google.com)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%20|%20Android%20|%20Web-green)](https://flutter.dev/multi-platform)

## 🔥 **Функционал**
✅ **Управление задачами**: создание, редактирование, удаление, завершение, возобновление.  
✅ **Гибкие напоминания**: за 15 мин, 30 мин, час, 6 часов, 12 часов, день, 3 дня, неделю, месяц.  
✅ **Фильтры и сортировка**. 
✅ **Авторизация** через Firebase (Email/Google).  
✅ **Push-уведомления**.  
✅ **Адаптивный дизайн** для всех устройств.  
✅ **Темная/светлая тема**.  
✅ **Мультиязычность** (поддержка переключения языков).

## 🛠 **Технологии**
- **Flutter** (с поддержкой всех платформ).
- **Firebase**:
    - Auth (авторизация).
    - RealtimeDatabase (база данных).
- **Паттерны**: Provider.
- **Интернационализация**: `l10n`.

## 📸 **Скриншоты**

### 🔐 **Авторизация и настройки**
| Регистрация | Вход |
|-------------|------|
| <img src="screenshots/registration.png" width="300" alt="Экран регистрации"/> | <img src="screenshots/login.png" width="300" alt="Экран входа"/> |
| **Сброс пароля** | **Настройки** |
| <img src="screenshots/forget_password.png" width="300" alt="Сброс пароля"/> | <img src="screenshots/settings.png" width="300" alt="Настройки приложения"/> |

### 📋 **Управление задачами**
| Фильтры | Пустой список |
|---------|---------------|
| <img src="screenshots/filters.png" width="300" alt="Фильтрация задач"/> | <img src="screenshots/no_items_dark.png" width="300" alt="Пустой список (темная тема)"/> |
| **Создание задачи** | **Напоминания** |
| <img src="screenshots/creating.png" width="300" alt="Создание новой задачи"/> | <img src="screenshots/notifications.png" width="300" alt="Выбор времени напоминания"/> |

### 📱 **Адаптивный интерфейс**
| Мобильный вид                                                                               | Планшет/Десктоп |
|---------------------------------------------------------------------------------------------|------------------|
| <img src="screenshots/tasks_screen_mobile.png" width="300" alt="Список задач на телефоне"/> | <img src="screenshots/tasks_screen_large.png" width="300" alt="Список задач на большом экране"/> |
| **Запись задачи**                                                                           | **Компактный список** |
| <img src="screenshots/task.png" width="300" alt="Просмотр задачи"/>                         | <img src="screenshots/tasks_screen_small.png" width="300" alt="Компактный вид списка"/> |

## 🚀 **Как запустить?**
1. **Клонируй репозиторий**:
   ```bash
   git clone https://github.com/darkhamu/TaskFlow.git