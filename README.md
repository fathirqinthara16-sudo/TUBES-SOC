<h1 align="center">Laporan Tugas Besar</h1>
<h1 align="center">Desain FPGA dan SoC 2025</h2>

**Desain FPGA dan SoC**

---

**Kelompok**            : Kelompok 3  
**Nama – NIM Anggota 1**: Muhammad Fathir Qinthara - 1102223006  
**Nama – NIM Anggota 2**: Vincentius Artyanta Mahesa - 1102223079  
**Nama – NIM Anggota 3**: Ivan Horas Hamonangan Simaremare - 1102223105  

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
  <img src="https://github.com/fathirqinthara16-sudo/TUBES-SOC/blob/3fc71130d7cebac58aca4e10895c3ab0c6ed8f63/Flowchart_SoC.jpg" alt="Flowchart Sistem SoC" width="700">
</p>
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

<p align="center">
  <img src="https://github.com/fathirqinthara16-sudo/TUBES-SOC/blob/d4d51b342e362bec287e2df5d28006d759d3371e/Blok%20Diagram%20SoC.png" 
       alt="Diagram Blok Deteksi Suhu dan Kelembapan Berbasis FPGA" 
       width="700">
</p>

<p align="center">
  <b>Gambar 2.</b> Diagram Blok Deteksi Suhu dan Kelembapan Berbasis FPGA
</p>

- **Sensor DHT11** berfungsi sebagai perangkat input yang membaca data suhu dan kelembapan dari lingkungan. Data yang dihasilkan oleh sensor ini dikirimkan dalam bentuk sinyal digital menuju FPGA 
- **FPGA** berperan sebagai proses atau pengendali utama. Pada bagian ini, data dari DHT11 diproses menggunakan rangkaian logika yang dirancang dengan Verilog HDL  
- **Hasil pengolahan data dari FPGA** selanjutnya ditampilkan pada seven segment display untuk menunjukkan nilai suhu atau kelembapan dalam bentuk angka. Selain itu, LED indikator digunakan sebagai penanda mode tampilan, di mana LED menunjukkan apakah sistem sedang menampilkan suhu atau kelembapan..  
---

## Finite State Machine (FSM)

<p align="center">
  <img src="https://raw.githubusercontent.com/fathirqinthara16-sudo/TUBES-SOC/d4d51b342e362bec287e2df5d28006d759d3371e/FSM_SoC.png"
       alt="Finite State Machine Sistem Deteksi Suhu dan Kelembapan Berbasis FPGA"
       width="700">
</p>

<p align="center">
  <b>Gambar 3.</b> Finite State Machine Sistem Deteksi Suhu dan Kelembapan Berbasis FPGA
</p>

Finite State Machine (FSM) digunakan untuk mengatur pergantian mode tampilan suhu dan kelembapan secara otomatis berdasarkan waktu simulasi. FSM bekerja secara sinkron terhadap clock lambat (slow clock) dan akan berpindah state ketika kondisi transisi terpenuhi.

### State S_TEMP (Temperature Mode)
- Pada state ini, sistem menampilkan nilai suhu (25°C) pada seven-segment display 
- Output aktif:	LEDR0 = 1 (indikator suhu menyala) dan LEDR1 = 0  
- Kondisi bertahan: FSM tetap berada di S_TEMP selama counter waktu belum mencapai nilai SIM_SWITCH
- Transisi: Jika counter mencapai batas waktu, FSM berpindah ke state S_WAIT.

### State S_WAIT (State Transisi)
- State ini berfungsi sebagai state perantara antara mode suhu dan mode kelembapan.
- Transisi: FSM langsung berpindah ke state S_HUM pada siklus clock berikutnya  

### State S_HUM (Humidity Mode)
- Pada state ini, sistem menampilkan nilai kelembapan (54%) pada seven-segment display
- Output aktif:	LEDR0 = 0 dan LEDR1 = 1 (indikator suhu menyala) 
- Kondisi bertahan: FSM tetap berada di S_HUM selama counter waktu belum mencapai nilai SIM_SWITCH
- Transisi: Jika waktu tercapai, FSM kembali ke state S_TEMP.

---

## Hasil Simulasi dan Analisis

### Skenario Pengujian
- Sistem diberikan sinyal clock dan reset aktif-low (rst_n).
-	Setelah reset dilepas, FSM memulai operasi pada mode suhu.
-	Sistem menampilkan nilai suhu 25°C pada seven segment dan menyalakan LEDR0.
-	Setelah waktu simulasi tertentu (diasumsikan 5 detik), FSM berpindah ke mode kelembapan.
-	Sistem menampilkan nilai kelembapan 54% pada seven segment dan menyalakan LEDR1.
-	Proses berlangsung secara berulang sesuai transisi FSM.
 

### Hasil Simulasi

<p align="center">
  <img src="https://raw.githubusercontent.com/fathirqinthara16-sudo/TUBES-SOC/d4d51b342e362bec287e2df5d28006d759d3371e/Simulasi_SoC.png"
       alt="Hasil Simulasi Sistem Deteksi Suhu dan Kelembapan Berbasis FPGA di ModelSim"
       width="700">
</p>

<p align="center">
  <b>Gambar 4.</b> Hasil Simulasi Sistem Deteksi Suhu dan Kelembapan Berbasis FPGA pada ModelSim
</p>

- Sinyal clk berosilasi secara stabil sebagai clock utama sistem. 
- Sinyal rst_n aktif low pada awal simulasi dan dilepas untuk memulai operasi sistem atau untuk melakukan reset.  
- Keluaran seven segment (seg_tens dan seg_units) menampilkan angka 25 pada mode suhu dan 54 pada mode kelembapan.
- LED indikator bekerja secara bergantian: LEDR0 menyala saat mode suhu aktif dan LEDR1 menyala saat mode kelembapan aktif
- Pergantian tampilan terjadi secara periodik sesuai dengan waktu simulasi yang telah ditentukan

### Analisis
Berdasarkan waveform simulasi, setelah sinyal reset (rst_n) dilepas, sistem bekerja secara normal. Saat kondisi pertama, seven segment akan menampilkan nilai 25, ditunjukkan oleh seg_tens = 0100100 (angka 2) dan seg_units = 0010010 (angka 5). Pada kondisi ini, LEDR0 bernilai 1 (menyala) dan LEDR1 bernilai 0 (mati). 

Setelah interval waktu simulasi tercapai, tampilan berubah menjadi nilai 54, dengan seg_tens = 0010010 (angka 5) dan seg_units = 0011001 (angka 4). Bersamaan dengan perubahan tampilan di seven segment, LEDR1 bernilai 1 (menyala) dan LEDR0 bernilai 0 (mati).

---

## Lampiran – Kode Verilog

### 1. **Kode Verilog Simulasi**

File kode utama sistem menggunakan Verilog HDL dapat diakses pada:  

- [Top Module (DHT.v)](https://github.com/fathirqinthara16-sudo/TUBES-SOC/blob/b1f63ff2fbac044e7c667d8b3eeaf8e7df8bc55c/DHT.v)
- [(Bcd_Converter.v)](https://github.com/fathirqinthara16-sudo/TUBES-SOC/blob/b1f63ff2fbac044e7c667d8b3eeaf8e7df8bc55c/bcd_converter.v)
- [(Clock_Divider.v)](https://github.com/fathirqinthara16-sudo/TUBES-SOC/blob/b1f63ff2fbac044e7c667d8b3eeaf8e7df8bc55c/clock_divider.v)
- [(Sensor_Simulator.v)](https://github.com/fathirqinthara16-sudo/TUBES-SOC/blob/b1f63ff2fbac044e7c667d8b3eeaf8e7df8bc55c/sensor_simulator.v)
- [(Seven_Segment_Decoder.v)](https://github.com/fathirqinthara16-sudo/TUBES-SOC/blob/b1f63ff2fbac044e7c667d8b3eeaf8e7df8bc55c/seven_segment_decoder.v)

File testbench untuk keperluan simulasi tersedia pada:  
- [Test Bench.v]([mealy_101_tb.v](https://github.com/fathirqinthara16-sudo/TUBES-SOC/blob/9e5229f2afac41b83c35b28631de5760cb123080/tb_DHT.v)


### 2. **Kode Verilog Implementasi Hardware**

File kode utama sistem menggunakan Verilog HDL dapat diakses pada:  

- [Top Module (dht11_reader.v)](https://github.com/fathirqinthara16-sudo/TUBES-SOC/blob/3d8792f6cd816d27ada2fd207780e32de9fe7119/dht11_reader.v)

## Link Video Implementasi
[Klik Link Untuk Hasil Video Implementasi Kelompok 3](https://drive.google.com/drive/folders/1a3T9kAikl_YUpCKYt6o87nv5wYIScUEy)
