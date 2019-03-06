![alt text](https://github.com/bittercookies/chamilo/blob/master/800px-Chamilo_LMS.svg.png)


[Sekilas Tentang](#sekilas-tentang) | [Instalasi](#instalasi) | [Otomatisasi](#otomatisasi) | [Cara Pemakaian](#cara-pemakaian) | [Konfigurasi](#konfigurasi)| [Maintenance](#maintenance) | [Pembahasan](#pembahasan) | [Referensi](#referensi)
:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:

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
    unzip chamilo-1.11.8-php7.zip 
    sudo mv chamilo-1.11.8-php7 /var/www/html/chamilo
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



10. Kunjungi alamat web server untuk melanjutkan instalasi. Ikuti installation wizard.
    1. Klik “Install Chamilo”
    
    ![alt text](https://github.com/bittercookies/chamilo/blob/master/images/1.PNG)
   
    2. Pilih bahasa.
    
    ![alt text](https://github.com/bittercookies/chamilo/blob/master/images/2.png)
    
    3. Pastikan semua paket yang dibutuhkan ter-install (tertulis Yes). Apabila iya, klik “New Installation”.
    
    ![alt text](https://github.com/bittercookies/chamilo/blob/master/images/3.png)
      
    4. klik "I Accept" pada License & Agreement.
    
    ![alt text](https://github.com/bittercookies/chamilo/blob/master/images/4.png)
    
    5. Melakukan konfigurasi database sesuai database yang telah dibuat pada Step 4.
    
    ![alt text](https://github.com/bittercookies/chamilo/blob/master/images/5.png)
   
    6. Membuat akun admin dan melakukan konfigurasi website/portal.
    
    ![alt text](https://github.com/bittercookies/chamilo/blob/master/images/6.png)

    7. Pengecekan terakhir sebelum melakukan install.
    ![alt text](https://github.com/bittercookies/chamilo/blob/master/images/7.png)
    
    8. Instalasi diproses.
    ![alt text](https://github.com/bittercookies/chamilo/blob/master/images/8.png)

    9. Chamilo telah terinstall!
    ![alt text](https://github.com/bittercookies/chamilo/blob/master/images/9.png)
    
    Kita bisa mengikuti Security Advice pada box kuning di atas dan mengubah otorisasi pada app/config/ dengan kode:
    
    ```bash
    sudo chmod -R 0555 /var/www/html/chamilo/app/config/
    ```


[`back to top`](#)

# Otomatisasi 
Jika instalasi terlihat sulit, Anda dapat menjalankan script shell yang otomatis akan menjalankan seluruh perintah instalasi pada terminal, seperti [setup.sh](https://github.com/bittercookies/chamilo/blob/master/setup.sh). Untuk menjalankan script, buka terminal dan ketik perintah berikut:
```bash
chmod +x setup.sh
./setup.sh
```

[`back to top`](#)

# Cara Pemakaian

Pertama, Anda akan dibawa ke halaman login.

![alt text](https://github.com/bittercookies/chamilo/blob/master/images/10.png)

Disini, kita dapat melakukan login sebagai admin dengan mengisi username dan password sesuai akun admin yang telah kita buat pada proses instalasi. Setelah login admin sukses, Anda akan dibawa ke halaman utama (index) admin, yang berisi berbagai fitur Chamilo.

![alt text](https://github.com/bittercookies/chamilo/blob/master/images/11.png)

Beberapa fitur penting dapat dilihat:
- **Users** dimana admin dapat mengelola database user dari website;
- **Courses**, yang merupakan fitur terpenting dari aplikasi e-learning;
- **Portal**, dimana segala informasi berkaitan website, dari konfigurasi/bahasa/plugins sampai news/agenda/statistics. Statistics & Reports dapat memberikan statistik dan laporan aktivitas dan kejadian di website, seperti berapa login users per satuan waktu, dsb. Pada Global Agenda, admin dapat menambahkan kejadian-kejadian penting pada kalender sistem yang dinotifikasikan ke semua pengguna (bersifat global);
- **Course Sessions**, ekstensi dari Courses dimana sesi-sesi pelajaran dapat diatur;
- **System** untuk melakukan tindakan yang berhubungan dengan sistem seperti menghapus cache secara manual;
- **Skills** yang merupakan **salah satu fitur unik Chamilo** dimana pengguna memiliki dan dapat mempelajari skill-skill. Admin dapat menambahkan jenis skill dan memantau skill wheel dan ranking.

Mengeklik tab Homepage akan membawa kita ke tampilan website kita seperti dilihat oleh pengguna umum yang memiliki akun.

![alt text](https://github.com/bittercookies/chamilo/blob/master/images/12.png)

Beberapa fitur unik yang dapat dilihat disini adalah:
- Chamilo memiliki fitur social networking: pengguna dapat mengirim **invitations** pada pengguna lain untuk menjadi teman (**friends**), masuk ke **social groups** dan kirim-mengirim pesan (**messages**) antar pengguna.
- Adapula sistem **skills** dan **certificates**, dimana pengguna mendapatkan sertifikat dan "skill" baru yang terpajang pada profilnya, sesuai dengan aktivitasnya di LMS.

[`back to top`](#)

# Konfigurasi

![alt text](https://github.com/bittercookies/chamilo/blob/master/images/konf1.PNG)

Konfigurasi berbagai aspek dari Chamilo dapat diubah pada **Configuration settings** yang terletak di index admin. Beberapa halaman yang relevan:

![alt text](https://github.com/bittercookies/chamilo/blob/master/images/konf2.PNG)

- Pada **Platform**, Anda dapat mengubah nama website, URL, dsb, bahkan mengatur berapa lama sebuah akun boleh tidak aktif sampai akun tersebut dianggap tidak valid.
- Pada **Course**, Anda dapat menkonfigurasi segala yang berhubungan dengan course, termasuk default hard disk space yang dapat dialokasikan untuk sebuah course.
- Pada **Tools**, Anda dapat mengatur maximum file upload size, dsb.
- Pada **Stylesheets**, Anda dapat memperindah website dengan stylesheet custom yang Anda buat.
- Pada **Facebook**, Anda dapat melakukan *Facebook authentication*.

Direkomendasikan admin mengeksplor **Configuration settings** dan mengubah berbagai konfigurasi agar mendapatkan LMS yang sesuai kebutuhan.

# Maintenance

![alt text](https://github.com/bittercookies/chamilo/blob/master/images/sys1.PNG)

Maintenance pada Chamilo dapat dilakukan melalui **System** pada index admin. Terdapat beberapa opsi yang relevan dalam maintenance sistem.

- **Cleanup of cache and temporary files** dapat digunakan untuk membersihkan temporary files yang disimpan di /app/cache/ secara manual, apabila tidak bisa diotomatisasi dengan cron.
- **Special exports** dapat digunakan untuk membuat backup.
- **System status** dapat memberitahu status berbagai konfigurasi seperti: apakah requirements Chamilo terpenuhi, status konfigurasi PHP, dll.


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
