CREATE TABLE personel(
	personel_id INT,
	personel_isim TEXT,
	meslek TEXT,
	mudur_id INT,
	ise_baslama date,
	maas NUMERIC,
	bolum_id INT,
	PRIMARY KEY (personel_id),
	FOREIGN KEY (bolum_id) REFERENCES bolumler(bolum_id)
);

CREATE TABLE bolumler(
	bolum_id INT PRIMARY KEY,
	bolum_isim TEXT,
	konum text
);
	
INSERT INTO bolumler VALUES(10, 'MUHASEBE', 'IST');
INSERT INTO bolumler VALUES(20, 'MUDURLUK', 'ANKARA');
INSERT INTO bolumler VALUES(30, 'SATIS', 'IZMIR');
INSERT INTO bolumler VALUES(40, 'ISLETME', 'BURSA');
INSERT INTO bolumler VALUES(50, 'DEPO', 'YOZGAT');
INSERT INTO personel VALUES(7369, 'AHMET', 'KATIP', 7902, '1980-12-17', 800.0, 20);
INSERT INTO personel VALUES(7499, 'BAHATTIN', 'SATIS', 7698, '1981-02-20', 1600.0, 30);
INSERT INTO personel VALUES(7521, 'NESE', 'SATIS', 7698, '1981-02-22', 1250.0, 30);
INSERT INTO personel VALUES(7566, 'MUZAFFER', 'MUDUR', 7839, '1981-04-02', 2975.0, 20);
INSERT INTO personel VALUES(7654, 'MUHAMMET', 'SATIS', 7698, '1981-09-28', 1250.0, 30);
INSERT INTO personel VALUES(7698, 'EMINE', 'MUDUR', 7839, '1981-05-01', 2850.0, 30);
INSERT INTO personel VALUES(7782, 'HARUN', 'MUDUR', 7839, '1981-06-09', 2450.0, 10);
INSERT INTO personel VALUES(7839, 'SEHER', 'BASKAN', NULL, '1981-11-17', 5000.0, 10);
INSERT INTO personel VALUES(7844, 'DUYGU', 'SATIS', 7698, '1981-09-08', 1500.0, 30);
INSERT INTO personel VALUES(7876, 'ALI', 'KATIP', 7788, '1987-07-13', 1100.0, 20);
INSERT INTO personel VALUES(7900, 'MERVE', 'KATIP', 7698, '1981-12-03', 950.0, 30);
INSERT INTO personel VALUES(7902, 'NAZLI', 'ANALIST', 7566, '1981-12-03', 3000.0, 20);
INSERT INTO personel VALUES(7934, 'EBRU', 'KATIP', 7782, '1982-01-23', 1300.0, 10);
INSERT INTO personel VALUES(7788, 'MESUT', 'ANALIST', 7566, '1987-07-13', 3000.0, 20);

/*SORGU1: SATIS veya MUHASABE bölümlerinde çalışan personelin isimlerini ve bölümlerini,
önce bölüm sonra isim sıralı olarak listeleyiniz*/

SELECT b.bolum_isim, p.personel_isim
FROM personel p
INNER JOIN bolumler b
on p.bolum_id = b.bolum_id
where b.bolum_isim in ("SATIS", "MUHASEBE");

/*SORGU2: SATIS, ISLETME ve DEPO bölümlerinde çalışan personelin isimlerini, bölümlerini ve
işe başlama tarihlerini isim sıralı olarak listeleyiniz.
NOT: Çalışanı olmasa bile bölüm ismi gösterilmelidir.*/

SELECT * from personel ; -- personel_isim, ise_baslama isim sıralı olarak
SELECT * from bolumler; -- bolum_isim  left JOIN

SELECT p.personel_isim, b.bolum_isim, p.ise_baslama
FROM bolumler b
LEFT JOIN personel p
on b.bolum_id = p.bolum_id
WHERE b.bolum_isim IN ('SATIS', 'ISLETME', 'DEPO')
ORDER by p.personel_isim ASC;

/* SORGU3: Tüm bölümlerde çalışan personelin isimlerini, bölüm isimlerini ve maaşlarını bölüm
ve maaş sıralı listeleyiniz.
NOT: Çalışanı olmasa bile bölüm ismi gösterilmelidir.*/

SELECT p.personel_isim, b.bolum_isim, p.maas
FROM bolumler b
LEFT JOIN personel p
on b.bolum_id = p.bolum_id
ORDER by b.bolum_isim ASC, p.maas DESC;

/*SORGU4: SATIS ve MUDURLUK bölümlerinde çalışan personelin maaşları 2000'den büyük
olanlarının isim, bölüm ve maaş bilgilerini bolüme ve isme göre sıralayarak listeleyiniz.*/

SELECT p.personel_isim, b.bolum_isim, p.maas
FROM bolumler b
INNER JOIN personel p
on b.bolum_id = p.bolum_id
where b.bolum_isim in ("SATIS", "MUDURLUK") AND p.maas > 2000
ORDER by b.bolum_isim ASC, p.personel_isim ASC;

/*SORGU5: MUDUR'u Mesut veya Emine olan personelin bölümlerini, isimlerini, maaşlarını ve
mudur isimlerini maaş sıralı olarak (Çoktan aza) listeleyiniz.*/


SELECT bolumler.bolum_isim, personel.personel_isim, personel.maas, personel.mudur_id 
FROM personel
LEFT JOIN bolumler on bolumler.bolum_id = personel.bolum_id
WHERE personel.mudur_id in ( 
	SELECT personel_id
	from personel
	WHERE personel_isim in ("MESUT", "EMINE")) 
ORDER by personel.maas DESC;