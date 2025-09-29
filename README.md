# addressing-logistics



# Depo Barkod Sistemi 📦
<img width="446" height="932" alt="Ekran Resmi 2025-09-29 ÖS 11 43 53" src="https://github.com/user-attachments/assets/6c821e0b-8a80-485a-9bec-0d01755044e4" />


Flutter ile geliştirilmiş modern ve kullanıcı dostu depo lokasyon barkod üretici uygulaması.


## 🎯 Özellikler

- **Dinamik Barkod Üretimi**: Seçilen lokasyona göre otomatik Code128 barkod oluşturma
- **Kolay Lokasyon Seçimi**: Kaydırılabilir wheel picker'lar ile hızlı seçim
- **Responsive Tasarım**: Tüm ekran boyutlarına uyumlu, yüzdesel ölçeklendirme
- **Modern UI**: Material Design 3 ile şık ve minimalist arayüz
- **Gerçek Zamanlı Önizleme**: Seçim yaparken anlık barkod güncelleme

## 📱 Lokasyon Formatı

Lokasyon kodu formatı: `Z[Koridor]-[Sıra]-[Raf]-[Yön]` - Örnek: `Z1-001-10-L`

**Seçenekler:**
- Koridor: Z1 - Z12 (12 koridor)
- Sıra: 001 - 092 (92 sıra)
- Raf: 10, 20, 30, 40, 50, 60 (6 raf seviyesi)
- Yön: L (Sol) / R (Sağ)

## 🚀 Kurulum
```bash
flutter pub add barcode_widget
flutter pub get
flutter run


dependencies:
  flutter:
    sdk: flutter
  barcode_widget: ^2.0.4

