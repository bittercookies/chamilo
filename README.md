[Sekilas Tentang](#sekilas-tentang) | [Instalasi](#instalasi) | [Konfigurasi](#konfigurasi) | [Otomatisasi](#otomatisasi) | [Cara Pemakaian](#cara-pemakaian) | [Pembahasan](#pembahasan) | [Referensi](#referensi)
:---:|:---:|:---:|:---:|:---:|:---:|:---:

# Sekilas Tentang

**Chamilo** adalah aplikasi web LMS (*Learning Management System*) gratis yang bebas untuk digunakan, dipelajari, dibagikan dan dimodifikasi berdasarkan [lisensi GNU/GPLv3+](https://campus.chamilo.org/documentation/license.html]). Dengan Chamilo, pengajar dapat membuat, mengelola, dan mempublikasikan *course* (perkuliahan) mereka melalui web. Sementara pelajar dapat mengikuti *course*, membaca konten yang dipublikasi, dan berpartisipasi dalam diskusi grup, forum, dan chat. 

[return](#)

# Instalasi

Versi stabil terbaru adalah Chamilo 1.11.8.

**Kebutuhan Sistem:**

- Linux, Windows (98, Me, NT4, 2000, XP, VISTA), Unix atau Mac OS X
- Apache Web server 2+
- PHP 5.5+
- MySQL 5.6+ atau MariaDB versi manapun.

**Proses Instalasi:**

1. Pastikan seluruh paket sistem telah ter-install dan *up-to-date*.

```bash
sudo apt-get update
sudo apt-get install apache2
sudo apt-get install mariadb-server mariadb-client
sudo apt install php7.2 libapache2-mod-php7.2 php7.2-common php7.2-sqlite3 php7.2-curl php7.2-intl php7.2-mbstring php7.2-xmlrpc php7.2-mysql php7.2-gd php7.2-xml php7.2-cli php7.2-ldap php7.2-apcu php7.2-zip
sudo apt-get install unzip
```

2. Buka file konfigurasi PHP (**php.ini**) dan uncomment / ubah beberapa setting berikut untuk memperlancar instalasi.

```bash
sudo nano /etc/php/7.2/apache2/php.ini
```

```ini
file_uploads = On
allow_url_fopen = On
short_open_tag = On
memory_limit = 256M
upload_max_filesize = 100M
max_execution_time = 360
date.timezone = Asia/Jakarta
```

3. Siapkan database dan user untuk Chamilo.

```bash
sudo mysql -u root -p
```

```mysql
CREATE DATABASE chamilo;
CREATE USER 'chamilouser'@'localhost' IDENTIFIED BY 'chamilopassword'
GRANT ALL ON chamilo.* TO 'chamilouser'@'localhost' with GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;
```

4. Unduh Chamilo LMS ke direktori kita.

```bash
wget https://github.com/chamilo/chamilo-lms/releases/download/v1.11.6/chamilo-1.11.6-php7.zip 
```

5. Ekstraksi isi zip dan pindahkan ke direktori root default Apache2.

```bash
unzip chamilo-1.11.6-php7.zip 
sudo mv chamilo-1.11.6 /var/www/html/chamilo
```

6. Pindahkan kepemilikan ke www-data (web server).

```bash
sudo chown -R www-data:www-data /var/www/html/chamilo
```

7. Buatlah file konfigurasi Apache2 untuk Chamilo LMS bernama **chamilo.conf**.

```bash
sudo nano /etc/apache2/sites-available/chamilo.conf
```

​		Salin konten berikut:

```
<VirtualHost *:80>
     ServerAdmin admin@your-domain.com
     DocumentRoot /var/www/html/chamilo
     ServerName your-domain.com

     <Directory /var/www/html/chamilo/>
          Options FollowSymlinks
          AllowOverride All
          Require all granted
     </Directory>

     ErrorLog ${APACHE_LOG_DIR}/error.log
     CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>
```

​		Simpan.

8. Setelah VirtualHost dikonfigurasi di atas, enable lalu restart Apache server.

```bash
sudo a2ensite chamilo.conf
sudo a2enmod rewrite
sudo systemctl restart apache2.service
```

9. Kunjungi alamat web server untuk melanjutkan instalasi.
   1. Klik “Install Chamilo”
   2. Pastikan semua paket yang dibutuhkan ter-install (tertulis Yes). Apabila iya, klik “New Installation”.
   3. Konfigurasi database dengan informasi user & db yang telah dibuat di step 3.
   4. Buat akun admin.
10. Chamilo telah terinstall!

# Konfigurasi

# Maintenance

# Otomatisasi 

# Cara Pemakaian

# Pembahasan

# Referensi

1. [Chamilo - Documentation](https://campus.chamilo.org/documentation/index.html) - Chamilo.org
2. [Insall Chamilo e-Learning Platform on Ubuntu 16.04 / 18.04 with Aapche2, MariaDB and PHP 7.2](https://websiteforstudents.com/install-chamilo-e-learning-platform-on-ubuntu-16-04-18-04-with-apache2-mariadb-and-php-7-2/) - Website for Students
