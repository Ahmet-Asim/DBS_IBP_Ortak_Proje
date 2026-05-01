<?php
$host = "localhost";
$user = "root";
$pass = "";
$db_name = "akademik_yayin_ve_dijitalmakale_havuzu";

// Veritabanı bağlantısı başlatılıyor
$baglanti = new mysqli($host, $user, $pass, $db_name);

// Bağlantı hatası kontrolü
if ($baglanti->connect_error) {
    die("Bağlantı hatası: " . $baglanti->connect_error);
}

// Türkçe karakter desteği (Verilerin bozuk görünmemesi için)
$baglanti->set_charset("utf8mb4");

echo "Sistem aktif: Veritabanı bağlantısı başarıyla kuruldu!";
$sorgu = $baglanti->query("SELECT Ad_Soyad FROM KULLANICI WHERE Kullanici_ID = 2");
$kullanici = $sorgu->fetch_assoc();
echo "<br>Sisteme giriş yapan öğrenci: " . $kullanici['Ad_Soyad'];
?>