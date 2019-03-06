![alt text](https://github.com/bittercookies/chamilo/blob/master/800px-Chamilo_LMS.svg.png)


[Sekilas Tentang](#sekilas-tentang) | [Instalasi](#instalasi) | [Konfigurasi](#konfigurasi) | [Otomatisasi](#otomatisasi) | [Cara Pemakaian](#cara-pemakaian) | [Pembahasan](#pembahasan) | [Referensi](#referensi)
:---:|:---:|:---:|:---:|:---:|:---:|:---:

# Sekilas Tentang

**Chamilo** adalah aplikasi web LMS (*Learning Management System*) *open source* yang bebas untuk digunakan, dipelajari, dibagikan dan dimodifikasi berdasarkan [lisensi GNU/GPLv3+](https://campus.chamilo.org/documentation/license.html]). Dengan Chamilo, pengajar dapat membuat, mengelola, dan mempublikasikan *course* (perkuliahan) mereka melalui web. Sementara pelajar dapat mengikuti *course*, membaca konten yang dipublikasi, dan berpartisipasi dalam diskusi grup, forum, dan chat. 

[`back to top`](#)

# Instalasi

Versi stabil terbaru adalah Chamilo 1.11.x.

#### Kebutuhan Sistem:

- Linux, Windows (98, Me, NT4, 2000, XP, VISTA), Unix atau Mac OS X
- Apache Web server 2+
- PHP 5.5+ (tested on PHP 7.2)
- MySQL 5.6+ atau MariaDB versi manapun

#### Proses Instalasi:

1. Login ke server menggunakan SSH.

   ```bash
   ssh -p 2222 bitter-cookies@localhost
   ```

2. Pastikan seluruh paket sistem telah ter-install dan *up-to-date*.
    ```bash
    sudo apt-get update
    sudo apt-get install apache2
    sudo apt-get install mariadb-server mariadb-client
    sudo apt install php7.2 libapache2-mod-php7.2 php7.2-common php7.2-sqlite3 php7.2-curl php7.2-intl php7.2-mbstring php7.2-xmlrpc php7.2-mysql php7.2-gd php7.2-xml php7.2-cli php7.2-ldap php7.2-apcu php7.2-zip
    sudo apt-get install unzip
    ```


3. Buka file konfigurasi PHP (**php.ini**) dan uncomment / ubah beberapa setting berikut untuk memperlancar instalasi.
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


4. Siapkan database dan user untuk Chamilo.
    ```bash
    sudo mysql -u root -p
    ```
    ```mysql
    CREATE DATABASE chamilo;
    CREATE USER 'chamilouser'@'localhost' IDENTIFIED BY 'chamilopassword';
    GRANT ALL ON chamilo.* TO 'chamilouser'@'localhost' with GRANT OPTION;
    FLUSH PRIVILEGES;
    EXIT;
    ```


5. Unduh Chamilo LMS ke direktori kita.
    ```bash
    wget https://github.com/chamilo/chamilo-lms/releases/download/v1.11.8/chamilo-1.11.8-php7.zip 
    ```


6. Ekstraksi isi zip dan pindahkan ke direktori root default Apache2.
    ```bash
    unzip chamilo-1.11.6-php7.zip 
    sudo mv chamilo-1.11.6 /var/www/html/chamilo
    ```
    

7. Pindahkan kepemilikan ke www-data (web server).
    ```bash
    sudo chown -R www-data:www-data /var/www/html/chamilo
    ```


8. Buatlah file konfigurasi Apache2 untuk Chamilo LMS bernama **chamilo.conf**.
    ```bash
    sudo nano /etc/apache2/sites-available/chamilo.conf
    ```


    Salin konten berikut:
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
    Simpan.


9. Setelah VirtualHost dikonfigurasi di atas, enable lalu restart Apache server.
    ```bash
    sudo a2ensite chamilo.conf
    sudo a2enmod rewrite
    sudo systemctl restart apache2.service
    ```



10. Kunjungi alamat web server untuk melanjutkan instalasi.


      
   1. Klik “Install Chamilo”
   
   
   2. Pastikan semua paket yang dibutuhkan ter-install (tertulis Yes). Apabila iya, klik “New Installation”.
![alt text](https://github.com/bittercookies/chamilo/blob/master/Screenshot_2019-03-06%20—%20Chamilo%20installation%20—%20Version%201%2011%206(1).png)
      
   3. klik "accept" pada pagian step 3-license
![alt text](https://github.com/bittercookies/chamilo/blob/master/Screenshot_2019-03-06%20—%20Chamilo%20installation%20—%20Version%201%2011%206(2).png)
  
   
   4. Melakukan database setting pada MySQL
![alt text](https://github.com/bittercookies/chamilo/blob/master/Screenshot_2019-03-06%20—%20Chamilo%20installation%20—%20Version%201%2011%206(3).png)
   
   5. Config setting .
![alt text](https://github.com/bittercookies/chamilo/blob/master/Screenshot_2019-03-06%20—%20Chamilo%20installation%20—%20Version%201%2011%206(4).png)

   6. Pengecekan kembali sebelum melakukan install.
![alt text](https://github.com/bittercookies/chamilo/blob/master/Screenshot_2019-03-06%20—%20Chamilo%20installation%20—%20Version%201%2011%206(5).png)
    
   7. Proses installasi.
![alt text](https://github.com/bittercookies/chamilo/blob/master/Screenshot_2019-03-06%20—%20Chamilo%20installation%20—%20Version%201%2011%206(6).png)

   8. Chamilo telah terinstall!

[`back to top`](#)

# Konfigurasi

# Otomatisasi 
Jika instalasi terlihat sulit, Anda dapat menjalankan script shell yang otomatis akan menjalankan seluruh perintah instalasi pada terminal, seperti [setup.sh](https://github.com/bittercookies/chamilo/blob/master/setup.sh). Untuk menjalankan script, buka terminal dan ketik perintah berikut:
```bash
chmod +x setup.sh
./setup.sh
```

[`back to top`](#)

# Cara Pemakaian

![alt text](https://github.com/bittercookies/chamilo/blob/master/Screenshot_2019-03-06%20IPB%20-%20IPB%20University.png)


[`back to top`](#)

# Pembahasan

Chamilo ditulis dalam bahasa pemrograman PHP dan menyetor data dengan MySQL, yang berarti dapat dijalankan di platform apapun selama platform tersebut mendukung Apache + PHP + MySQL. 

Beberapa **kelebihan** Chamilo adalah:
- Sederhana, mudah untuk digunakan / intuitif, fleksibel.
- Infrastruktur yang ringan.
- Open Source, pengguna bebas mempelajari dan memodifikasi aplikasi.
- Sudah diterjemahkan ke lebih dari 30 bahasa di dunia.

Namun, Chamilo juga memiliki **kekurangan**, yaitu:
- Komunitas pengguna kurang terpusat untuk berbagi pengembangan aplikasi.
- User support system kurang memadai.

Perbandingan Chamilo dengan Aplikasi lain:

**Moodle**:

- Chamilo merupakan web yang bersifat open-source sehingga benar-benar gratis, Moodle juga gratis akan tetapi memiliki beberapa paket yang diharuskan pengguna untuk membayarnya.
- Moodle haya bisa digunakan di Windows dan Android, sedangkan Chamilo bisa digunakan di Windows, Android, iOS, Web-based dan Windows Mobile.


**TalentLMS**:

 - Chamilo merupakan web yang bersifat open-source sehingga benar-benar gratis, TalentLMS juga gratis akan tetapi memiliki beberapa paket yang diharuskan pengguna untuk membayarnya.
 - TalentLMS memiliki variasi bahasa lebih banyak dibandingkan dengan Chamilo.
 - TalentLMS dapat dijalankan di Windows, Android, iOS, Web-based, Windows Mobile, dan Linux.

[`back to top`](#)

# Referensi

1. [Chamilo - Documentation](https://campus.chamilo.org/documentation/index.html) - Chamilo.org
2. [Install Chamilo e-Learning Platform on Ubuntu 16.04 / 18.04 with Apache2, MariaDB and PHP 7.2](https://websiteforstudents.com/install-chamilo-e-learning-platform-on-ubuntu-16-04-18-04-with-apache2-mariadb-and-php-7-2/) - Website for Students
3. [Chamilo Reviews](https://elearningindustry.com/directory/elearning-software/chamilo) - eLearning Industry
4. [Comparisons Finances Online](https://comparisons.financesonline.com/chamilo-vs-moodle) - Comparison Chamilo vs Moodle vs TalentLMS

[`back to top`](#)
