# 🛍️ Nihal Butik - Stok ve Rezervasyon Sistemi

Java FX ile geliştirdiğim butik yönetim sistemi. Abiye kiralama, satış ve stok takibi.

##  Özellikler

-  Ürün ve kategori yönetimi
-  Müşteri takibi  
-  Rezervasyon sistemi
-  SQLite veritabanı entegrasyonu
-  Java FX arayüz
-  Abiye kiralama ve satış modülü
-  Stok ve envanter takibi

##  Teknolojiler

- **Java 17** - Ana programlama dili
- **Java FX** - Modern kullanıcı arayüzü  
- **SQLite** - Hafif ve taşınabilir veritabanı
- **Maven** - Bağımlılık yönetimi ve build aracı

##  Kurulum

### Gereksinimler
- JDK 17 veya üstü
- Maven 3.6+
- Git

### Adımlar
```bash
# Projeyi klonla
git clone https://github.com/ceycey120/butik-app.git

# Proje dizinine git  
cd butik-app

# Bağımlılıkları yükle ve derle
mvn clean compile

# Uygulamayı çalıştır
mvn javafx:run
