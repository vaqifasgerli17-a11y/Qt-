# 📄 Sənəd və Keçid Meneceri (Document & Link Manager)

Qt 6 və QML texnologiyaları əsasında hazırlanmış, SQLite verilənlər bazası dəstəkli masaüstü (Desktop) tətbiqi. Bu layihə istifadəçilərin PDF sənədlərini və veb keçidlərini tək bir mərkəzdən effektiv şəkildə idarə etməsi üçün nəzərdə tutulmuşdur.

## 🚀 Özəlliklər (Features)
- **Təhlükəsiz Giriş Sistemi:** Rol əsaslı autentifikasiya (Admin paneli).
- **Dinamik Səhifə Naviqasiyası:** `QtQuick.Controls.StackView` ilə axıcı səhifə keçidləri.
- **Yerli Verilənlər Bazası (Local DB):** `QtQuick.LocalStorage` (SQLite) inteqrasiyası ilə məlumatların qalıcılığı (Hər açılışda məlumatlar avtomatik yüklənir).
- **Fayl Sistemi İnteqrasiyası:** `FileDialog` və `Qt.StandardPaths` vasitəsilə sistemdən birbaşa PDF seçimi.
- **Xarici Resurs Çağırışı:** Əlavə edilmiş linklərin və PDF-lərin birbaşa default brauzerdə/oxuyucuda açılması (`Qt.openUrlExternally`).

## 🛠️ İstifadə Olunan Texnologiyalar (Tech Stack)
- **Frontend:** QML (Qt Quick), JavaScript
- **Backend/Build:** C++, CMake
- **Database:** SQLite (LocalStorage)
- **OS Platform:** Linux (Tested on Linux Mint XFCE) / Cross-platform support

## 📦 Quraşdırma və İşə Salma (Installation)
Proqramı local mühitdə yığmaq üçün aşağıdakı əmrlərdən istifadə edə bilərsiniz:

```bash
git clone [https://github.com/vaqifasgerli17-a11y/Qt-.git](https://github.com/vaqifasgerli17-a11y/Qt-.git)
cd Qt-
mkdir build && cd build
cmake ..
cmake --build .
