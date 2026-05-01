-- =============================================
-- DBS & IBP ORTAK PROJE VERİTABANI ŞEMASI
-- =============================================

-- 1. KULLANICI TABLOSU (Üsttip)
CREATE TABLE IF NOT EXISTS KULLANICI (
    Kullanici_ID INT AUTO_INCREMENT PRIMARY KEY,
    Ad_Soyad VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Sifre_Hash VARCHAR(255) NOT NULL,
    Kullanici_Tipi ENUM('Ogrenci', 'Akademisyen', 'Admin') NOT NULL
);

-- 2. OGRENCI TABLOSU (Alttip)
CREATE TABLE IF NOT EXISTS OGRENCI (
    Kullanici_ID INT PRIMARY KEY,
    Ogrenci_No VARCHAR(20) UNIQUE NOT NULL,
    Universite_Adi VARCHAR(100),
    FOREIGN KEY (Kullanici_ID) REFERENCES KULLANICI(Kullanici_ID) ON DELETE CASCADE
);

-- 3. AKADEMISYEN TABLOSU (Alttip)
CREATE TABLE IF NOT EXISTS AKADEMISYEN (
    Kullanici_ID INT PRIMARY KEY,
    Unvan VARCHAR(50),
    Uzmanlik_Alani VARCHAR(100),
    FOREIGN KEY (Kullanici_ID) REFERENCES KULLANICI(Kullanici_ID) ON DELETE CASCADE
);

-- 4. KATEGORI TABLOSU (Öz-referanslı Hiyerarşik Yapı)
CREATE TABLE IF NOT EXISTS KATEGORI (
    Kategori_ID INT AUTO_INCREMENT PRIMARY KEY,
    Kategori_Adi VARCHAR(100) NOT NULL,
    Ust_Kategori_ID INT NULL,
    FOREIGN KEY (Ust_Kategori_ID) REFERENCES KATEGORI(Kategori_ID)
);

-- 5. MAKALE TABLOSU
CREATE TABLE IF NOT EXISTS MAKALE (
    Makale_ID INT AUTO_INCREMENT PRIMARY KEY,
    Baslik VARCHAR(255) NOT NULL,
    Ozet TEXT,
    PDF_URL VARCHAR(255),
    Yayin_Tarihi DATE,
    Kategori_ID INT,
    Ekleyen_Kullanici_ID INT,
    FOREIGN KEY (Kategori_ID) REFERENCES KATEGORI(Kategori_ID),
    FOREIGN KEY (Ekleyen_Kullanici_ID) REFERENCES KULLANICI(Kullanici_ID)
);

-- 6. MAKALE_YAZAR TABLOSU (Çoktan-çoğa İlişki Çözümü)
CREATE TABLE IF NOT EXISTS MAKALE_YAZAR (
    Makale_ID INT,
    Kullanici_ID INT,
    PRIMARY KEY (Makale_ID, Kullanici_ID),
    FOREIGN KEY (Makale_ID) REFERENCES MAKALE(Makale_ID) ON DELETE CASCADE,
    FOREIGN KEY (Kullanici_ID) REFERENCES KULLANICI(Kullanici_ID) ON DELETE CASCADE
);

-- 7. DEGERLENDIRME TABLOSU (Kısıt: 1-5 Puan Arası)
CREATE TABLE IF NOT EXISTS DEGERLENDIRME (
    Degerlendirme_ID INT AUTO_INCREMENT PRIMARY KEY,
    Puan INT CHECK (Puan BETWEEN 1 AND 5),
    Yorum_Metni TEXT,
    Tarih TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Makale_ID INT,
    Kullanici_ID INT,
    FOREIGN KEY (Makale_ID) REFERENCES MAKALE(Makale_ID),
    FOREIGN KEY (Kullanici_ID) REFERENCES KULLANICI(Kullanici_ID)
);