<h1 align="center">Laporan Tugas Besar</h1>
<h1 align="center">Desain FPGA dan SoC 2025</h2>

---
**Kelompok** : 3  

- **Muhammad Fathir Qinthara** / 1102223006  
- **Vincentius Artyanta Mahesa** / 1102223079  
- **Ivan Horas Hamonangan Simaremare** / 1102223105

---

## Judul
**Sistem Deteksi Suhu dan Kelembapan Berbasis FPGA dengan Tampilan Data pada 7-Segment Display**

Judul ini menggambarkan perancangan sebuah sistem digital berbasis FPGA yang berfungsi untuk membaca, mengolah, dan menampilkan data suhu serta kelembapan lingkungan secara real-time melalui media tampilan seven-segment display.

---

## Deskripsi
Tugas besar ini bertujuan untuk merancang dan mengimplementasikan sistem pendeteksi suhu dan kelembapan berbasis FPGA. Sistem bekerja dengan menerima data dari sensor suhu dan kelembapan, kemudian data tersebut diproses menggunakan logika digital yang diimplementasikan pada FPGA. Hasil pengolahan data ditampilkan dalam bentuk nilai numerik pada seven-segment display.

Perancangan sistem mencakup pembacaan data dari sensor DHT11, pengolahan data menggunakan Verilog HDL, serta pengendalian tampilan yang terintegrasi antara perangkat keras sensor dan FPGA.

---

## Fungsi Sistem
- Mendeteksi dan membaca nilai suhu serta kelembapan dari sensor DHT11  
- Mengolah data sensor menggunakan logika digital berbasis Quartus dan FPGA  
- Menampilkan hasil pengukuran suhu dan kelembapan pada seven-segment display  

---

## Fitur dan Spesifikasi

| **Contoh Alat** | **Contoh Fitur** |
|:--------------:|:---------------:|
| Pengukur Suhu dan Kelembapan Ruangan | Mengukur nilai suhu dan kelembapan ruangan dan menampilkan nilainya secara digital |

### Contoh Spesifikasi
- Sistem mampu mengukur suhu dan kelembapan ruangan secara digital  
- Output nilai ditampilkan melalui seven-segment display dan indikator LED  
- Tampilan suhu dan kelembapan ditampilkan secara bergantian setiap 5 detik  

---

## Cara Penggunaan Sistem
<p align="center">
  <b>Gambar 1.</b> Flowchart Sistem Deteksi Suhu dan Kelembapan Berbasis FPGA
</p>

Flowchart sistem diawali dengan melakukan setup di aplikasi Quartus dan pembuatan kode program. Setelah proses inisialisasi selesai, sensor mulai membaca data suhu dan kelembapan dari lingkungan. Data yang diperoleh kemudian diolah oleh sistem sebelum ditampilkan pada seven-segment display.

Tahapan implementasi sistem meliputi:
1. Menjalankan program Verilog HDL  
2. Melakukan inisialisasi dan pengaturan pin menggunakan Pin Planner  
3. Mengunggah (upload) kode ke FPGA  

Selanjutnya, sistem menentukan jenis data yang akan ditampilkan. Apabila sistem berada pada mode suhu, maka nilai suhu ditampilkan. Sebaliknya, jika berada pada mode kelembapan, nilai kelembapan akan ditampilkan. Proses berakhir setelah data ditampilkan dan berjalan secara berulang.

---

## Blok Diagram Sistem
- **Sensor DHT11** berfungsi sebagai perangkat input untuk membaca suhu dan kelembapan lingkungan  
- **FPGA** berperan sebagai pengendali utama yang memproses data menggunakan Verilog HDL  
- **Seven-Segment Display** menampilkan nilai suhu atau kelembapan dalam bentuk angka  
- **LED Indikator** menunjukkan mode tampilan (suhu atau kelembapan)  

---

## Finite State Machine (FSM)
FSM digunakan untuk mengatur pergantian mode tampilan suhu dan kelembapan secara otomatis berdasarkan waktu.

### State S_TEMP (Temperature Mode)
- Menampilkan nilai suhu (25°C)  
- LEDR0 = 1, LEDR1 = 0  
- Bertahan hingga waktu mencapai batas yang ditentukan  

### State S_WAIT (State Transisi)
- State perantara antara suhu dan kelembapan  
- Langsung berpindah ke state S_HUM  

### State S_HUM (Humidity Mode)
- Menampilkan nilai kelembapan (54%)  
- LEDR0 = 0, LEDR1 = 1  
- Bertahan hingga waktu tercapai lalu kembali ke S_TEMP  

---

## Hasil Simulasi dan Analisis

### Skenario Pengujian
- Sistem diberikan sinyal clock dan reset aktif-low  
- Setelah reset dilepas, sistem mulai pada mode suhu  
- Menampilkan suhu 25°C dan LEDR0 menyala  
- Setelah waktu tertentu, berpindah ke mode kelembapan  
- Menampilkan kelembapan 54% dan LEDR1 menyala  
- Proses berjalan berulang sesuai FSM  

### Hasil Simulasi
- Sinyal clock berosilasi stabil  
- Seven-segment menampilkan nilai 25 dan 54 sesuai mode  
- LED indikator bekerja bergantian  
- Pergantian tampilan berlangsung periodik  

### Analisis
Sistem bekerja sesuai perancangan. Setelah reset dilepas, tampilan suhu muncul terlebih dahulu dengan LED indikator aktif. Setelah interval waktu tercapai, sistem berpindah ke mode kelembapan dan kembali ke mode suhu secara berulang tanpa kesalahan.

---

## Lampiran – Kode Verilog

### Top Module (DHT.v)
```verilog
// (kode tetap seperti yang kamu kirim, tidak diubah)
