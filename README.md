# Cleanify (di mobile)

[![Status build](https://img.shields.io/github/workflow/status/A03-PBP-2022/cleanify-mobile/Build%20app?logo=github-actions&logoColor=white)](https://github.com/A03-PBP-2022/proyek/actions/workflows/build.yml)
[![Status build](https://img.shields.io/github/workflow/status/A03-PBP-2022/cleanify-mobile/Release%20app?logo=github&logoColor=white&label=release)](https://github.com/A03-PBP-2022/proyek/actions/workflows/release.yml)
![App Center status]

Cleanify merupakan aplikasi berbasis platform yang menawarkan jasa untuk membantu membersihkan sampah di sekitar kita. Aplikasi ini memudahkan masyarakat untuk menjaga lingkungan yang lebih bersih lagi. Platform ini juga mempunyai tujuan untuk meningkatkan awareness masyarakat terhadap lingkungan sekitar.

## 📲 Gunakan

### ⬇ Unduh

| Status | Android (*.apk) |  
| -: | - |
| [![Master build status]](https://github.com/A03-PBP-2022/proyek/actions/workflows/build.yml) | [![Download from nightly.link]](https://nightly.link/A03-PBP-2022/cleanify-mobile/workflows/build/master/android.zip)
| [![Dev build status]](https://github.com/A03-PBP-2022/proyek/actions/workflows/build.yml) | [![Download from nightly.link]](https://nightly.link/A03-PBP-2022/cleanify-mobile/workflows/build/dev/android.zip)
| [![Release status]](https://install.appcenter.ms/orgs/a03-pbp-2022/apps/cleanify/distribution_groups/public) | [![Download from GitHub]](https://github.com/A03-PBP-2022/cleanify-mobile/releases/latest)
| [![App Center status]](https://install.appcenter.ms/orgs/a03-pbp-2022/apps/cleanify/distribution_groups/public) | [![Download from App Center]](https://install.appcenter.ms/orgs/a03-pbp-2022/apps/cleanify/distribution_groups/public)

[Master build status]: https://img.shields.io/github/workflow/status/A03-PBP-2022/cleanify-mobile/Build%20app/master?logo=github-actions&logoColor=white&label=master
[Dev build status]: https://img.shields.io/github/workflow/status/A03-PBP-2022/cleanify-mobile/Build%20app/dev?logo=github-actions&logoColor=white&label=dev
[Release status]: https://img.shields.io/github/workflow/status/A03-PBP-2022/cleanify-mobile/Release%20app?logo=github&logoColor=white&label=release
[App center status]: https://img.shields.io/visual-studio-app-center/builds/A03-PBP-2022/Cleanify/master/ca4d4f04292771289c9ec1897f4a1840548d936c?label=appcenter&logo=azure-pipelines
[Download from nightly.link]: https://img.shields.io/badge/nightly.link-download-540054
[Download from GitHub]: https://img.shields.io/github/v/release/A03-PBP-2022/cleanify-mobile?label=github&sort=semver
[Download from App Center]: https://img.shields.io/visual-studio-app-center/releases/version/A03-PBP-2022/Cleanify/ca4d4f04292771289c9ec1897f4a1840548d936c?label=appcenter

### 🌐 Web

Aplikasi *mobile* Cleanify dapat diakses di https://a03-pbp-2022.github.io/cleanify-mobile/.


## 👨‍👨‍👧‍👧 Anggota

1. Hans Tikynaro Manurung (2106750295, [@HansTM](https://github.com/HansTM))
2. Naiya Dwita Ayunir (2106651976, [@naiyayunir](https://github.com/naiyayunir))
3. Thalia Fortuna (2106751890, [@thaliafortuna](https://github.com/thaliafortuna))
4. Muhammad Alif Ilham (2106751341, [@Alifilhmm](https://github.com/Alifilhmm))
5. Muhammad Rafi Adiwibowo (2106653855, [@rafiadiwibowo](https://github.com/rafiadiwibowo))


### 💢 Manfaat

Dengan aplikasi ini lingkungan akan menjadi lebih bersih karena warga dapat memiliki akses yang lebih mudah untuk membuang sampah dan menjadi tidak rumit. Dengan kemudahan yang diberikan warga akan lebih peduli dengan lingkungan sekitar dan juga menanamkan sifat gotong royong serta saling membantu satu sama lain. Beberapa manfaat utama aplikasi ini adalah pembersihan wilayah sampah oleh cleaner crews dan bank sampah yang menerima sampah rumah tangga Anda untuk didaur ulang. Akan terdapat formulir pelaporan wilayah sampah, formulir bank sampah, serta FAQ mengenai visi, misi, dan penggunaan aplikasi Cleanify. Jika Anda mendaftar sebagai seorang cleaner crew, Anda dapat melihat titik-titik wilayah sampah dan informasi seputarnya untuk membantu secara suka rela dalam pembersihan wilayah sampah.

## 💾 Modul

Modul-modul yang akan diimplementasi adalah sebagai berikut.

### 1. Autentikasi

![](https://img.shields.io/badge/bagian-Naiya_Dwita_Ayunir-blue)

Modul ini berfungsi sebagai autentikasi user menggunakan aplikasi. Tedapat proses login untuk mengakses halaman-halaman yang diperlukan. Selain itu juga terdapat fitur registrasi untuk user yang ingin mendaftarkan dirinya pada aplikasi. Apabila pengguna telah berhasil melewati proses ini, maka pengguna dapat mengakses halaman-halaman tersebut. Terakhir, juga terdapat fitur logout yang berfungsi untuk keluar dari aplikasi.

### 2. Pelaporan Wilayah Sampah

![](https://img.shields.io/badge/bagian-Thalia_Fortuna-blue)

Modul ini berfungsi sebagai tempat melaporkan wilayah sampah yang perlu dibersihkan oleh crew, yang dikhususkan untuk user untuk diisi. Laporan ini nanti akan ditunjukkan pada dasbor laporan wilayah sampah.

Modul ini juga berisi dasbor yang berisi laporan-laporan wilayah sampah yang perlu dibersihkan oleh para cleaner crews. Laporan yang ditampilkan merupakan hasil pengisian form berupa pelaporan wilayah sampah yang patut dibersihkan. Dasbor ini dikhususkan untuk para cleaner crews agar mereka mendapat informasi lebih lanjut terkait wilayah sampah tersebut dan tindakan yang akan direncanakan.

### 3. Bank Sampah

![](https://img.shields.io/badge/bagian-Muhammad_Rafi_Adiwibowo-blue)

Modul ini merupakan halaman yang berisikan form untuk user melakukan setor sampah ke dalam tempat bank sampah tersebut. Setelah melakukan pengisian form tersebut, maka akan dilakukannya pengambilan sampah tersebut.

### 4. FAQ

![](https://img.shields.io/badge/bagian-Muhammad_Alif_Ilham-blue)

Modul ini berfungsi untuk menampilkan daftar pertanyaan dan jawaban yang sering ditanyakan mengenai aplikasi ini. User juga dapat mengirimkan *thumbs up* untuk menandakan bahwa sebuah pertanyaan berguna bagi para pembaca. Pertanyaan dan jawaban dengan jumlah *thumbs up* terbanyak akan ditampilkan di paling atas daftar pertanyaan. Mengambil data dari Json cleanify web. Modul ini dapat dilihat dan diakses oleh User.

### 5. Blog

![](https://img.shields.io/badge/bagian-Hans_Tikynaro_Manurung-blue)

Modul ini berisi sistem blog yang berisi artikel-artikel yang berkaitan dengan sampah dan/atau lingkungan sekitar, yang dapat ditulis oleh admin dan di baca oleh User lainnya. Pengguna juga dapat memberikan komentar pada tiap artikel yang ditulis. Diharapkan para pembaca dapat meningkatkan *awareness* terkait visi yang kita harapkan.

## 👥 Roles

Terdapat empat role dalam Cleanify.

1. User: Pengguna biasa yang terdaftar di dalam aplikasi. Ini berbeda dengan pengguna situs yang tidak terdaftar.
2. Crew: Petugas-petugas yang berkaitan dengan penindaklanjutan masukan-masukan pengguna. Merekalah yang melihat laporan wilayah sampah, bank sampah, dan menindaklanjuti isinya.
3. Moderator: Staf yang beraksi untuk melakukan moderasi terhadap input pengguna dalam modul-modul yang dapat dilihat oleh umum, seperti kolom komentar pada blog.
4. Administrator: Staf yang mengelola aplikasi. Kelompok ini akan memiliki akses superuser.

## 🖇️ Integrasi

Cara mengintegrasikan apliasi kita dengan aplikasi web Django yang telah dibuat sebelumnya adalah sebagai berikut.

1. Membuat REST API di pada Django yang membuat aplikasi dapat berinteraksi pada aplikasi web Django yang telah dibuat. 
2. Membuat aplikasi dengan antarmuka sesuai dengan desain yang telah dibuat pada proyek Django sebelumnya.
3. Membangun sebuah *class* yang dibutuhkan untuk menangani data-data yang tersedia.
4. Dengan menggunakan *package* `http`, mengintegrasikan aplikasi yang dibuat (*front-end*) dengan aplikasi Django tersebut (*back-end*) secara asinkronus.
