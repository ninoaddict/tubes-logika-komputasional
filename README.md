<br />
<div align="center">

  <h1 align="center">Tugas Besar IF2110 Algoritma & Struktur Data ITB</h1>

  <p align="center">
    <h3> Global Conquest: Battle for Supremacy </h3>
    <h4> Program Permainan Board Game berbasis CLI (command-line interface) dalam bahasa Prolog </h4>
    <br />
  </p>
</div>

<!-- CONTRIBUTOR -->
<div align="center" id="contributor">
  <strong>
    <h3>Dibuat oleh Kelompok BeTeKa</h3>
    <table align="center">
      <tr>
        <td style="text-align: center;">NIM</td>
        <td style="text-align: center;">Nama</td>
      </tr>
      <tr>
        <td style="text-align: center;">13522068</td>
        <td style="text-align: center;">Adril Putra Merin</td>
      </tr>
      <tr>
        <td style="text-align: center;">13522093</td>
        <td style="text-align: center;">Matthew Vladimir Hutabarat</td>
      </tr>
      <tr>
        <td style="text-align: center;">13522098</td>
        <td style="text-align: center;">Suthasoma Mahardhika Munthe</td>
      </tr>
      <tr>
        <td style="text-align: center;">13522118</td>
        <td style="text-align: center;">Berto Richardo Togatorop</td>
      </tr>
    </table>
  </strong>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li>
        <details>
          <summary><a href="#features">Features</a></summary>
          <ol>
            <li><a href="#1. Map">1. Map</a></li>
            <li><a href="#2. Initiating">2. Initiating</a></li>
            <li><a href="#3. Turn">3. User</a></li>
            <li><a href="#4. Wilayah">4. Wilayah</a></li>
            <li><a href="#5. Player">5. Player</a></li>
          <ol>
        </details>
        </li>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project
Global Conquest: Battle for Supremacy merupakan simulasi permainan board game yang dimainkan oleh 2-4 orang.

<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

Untuk melakukan kompilasi, diperlukan 

* GNU PROLOG
* IDE


### Installation
1. Buka IDE
2. Clone the repo
   ```sh
   git clone https://github.com/GAIB21/tugas-besar-if2121-logika-komputasional-2023-beteka.git
   ```
3. Buka GNU PROLOG
4. Change Directory di GNU PROLOG
   ```sh
   change_directory('path/to/your/cloned/folder/tugas-besar-if2121-logika-komputasional-2023-beteka/src').
   ```
5. consult main
   ```sh
   [main].
   ```

<!-- FEATURES -->
## Features
### 1. Map

World map terdiri dari 24 wilayah dan 6 benua. Implementasi world map dapat memanfaatkan struktur data undirected graph, dimana node merupakan wilayah dan edge merupakan hubungan ketetanggaan antara dua wilayah.  
Daftar perintah : 
- `displayMap.` : Menampilkan kondisi map pada saat ini, termasuk jumlah troops yang menempati setiap teritory.

### 2. Initiating

Menginisasi sehingga permainan dapat dimulai.  
Daftar perintah : 
- `startGame.` : Pengguna memasukkan jumlah pemain dan nama setiap pemain. Program akan secara otomatis melemparkan 2 buah dadu untuk menentukan urutan pemain.  
- `takeLocation(teritoryCode).` : Pemain akan secara berurutan memilih lokasi yang akan ditempati di awal hingga setiap teritory ditempati. 
- `placeTroops(teritoryCode, troopsNb).` : Pemain yang meletakkan troopsnya sebanyak troopsNb ke teritory dengan kode teritoryCode. 
-`placeAutomatic.` : Pemain dapat memilih agar troopsnya diletakkan secara random oleh program.

### 3. Turn
Pada setiap turn atau putaran permainan Risk, pemain dapat memanggil perintah draft, move, risk, attack, dan end turn.
#### a. End Turn
- `endTurn.` : Pemain sekarang mengakhiri gilirannya dan dilanjutkan pemain selanjutnya. Pemain selanjutnya mendapatkan tentara tambahan berdasarkan jumlah wilayah yang dimiliki dan jumlah benua yang dimiliki.

#### b. Draft 
- `draft(teritoryCode, troopsNb).` : 
menempatkan tentara tambahan sebanyak troopsNb ke teritory dengan kode teritoryCode. 

#### c. Move 
- `move(origin, destination, troopsNb).` : memindahkan troops sebanyak troopsNb dari teritory origin menuju destination.

#### d. Attack
- `attack.` : menyerang wilayah pemain lain yang bersebelahan dengan wilayah player sekarang.

#### e. Risk
- `risk.` : mengambil salah satu risk card secara acak. Risk hanya dapat dipanggil satu kali tiap giliran.
  ##### i. Cease Fire : 
  Pemain lawan tidak bisa menyerang territory pemain sekarang.

  ##### ii. Super Soldier Serum : 
  Hingga giliran berikutnya, semua hasil lemparan dadu saat penyerangan dan pertahanan akan bernilai 6. 

  ##### iii. Auxilary Troops : 
  Tentara tambahan yang akan diterima pemain pada putaran selanjutnya bernilai 2 kali lipat. 

  ##### iv. Rebelion : 
  Salah satu wilayah acak pemain berpindah kekuasaan menjadi milik lawan (acak).

  ##### v. Disease Outbreak : 
  Hingga giliran berikutnya, semua hasil lemparan dadu saat penyerangan dan pertahanan akan bernilai 1. 

  ##### vi. Supply Chain Issue : 
  Pemain tidak mendapatkan tentara tambahan pada giliran berikutnya. 

### 4. Wilayah 
Setiap wilayah memiliki atributnya sendiri.  
Daftar perintah: 
- `checkLocationDetail(territoryCode).` : Menampilkan detail dari wilayah dengan kode territoryCode. Detail yang ditampilkan adalah kode wilayah, nama wilayah, pemilik, total tentara, dan semua tetangga wilayah yang dipilih.

### 5. Player : 
Setiap pemain memiliki atributnya sendiri.  
- `checkPlayerDetail(playerCode)` : Menampilkan detail dari player dengan kode playerCode. Detail yang ditampilkan adalah nama pemain, benua yang dikuasai, total wilayah, total tentara aktif, dan total tentara tambahan. 
- `checkPlayerTerritories(playerCode).` : Menampilkan setiap wilayah yang dikuasai oleh player. 
- `checkIncomingTroops(playerCode).` : Menampilkan detail tentara tambahan yang akan diterima oleh pemain pada giliran berikutnya.

<!--CONTRIBUTING-->
## Contributing

Jika Anda ingin berkontribusi atau melanjutkan perkembangan program, silahkan fork repository ini dan gunakan branch fitur.  
