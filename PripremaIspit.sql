/*
6_ZAMJENSKI ZNAKOVI
% 		- mijenja bilo koji broj znakova
_ 		- mijenja ta�no jedan znak


PRETRA�IVANJE

[ListaZnakova]	-	pretra�uje po bilo kojem znaku iz navedene liste pri �emu
					rezultat SADR�I bilo koji od navedenih znakova
[^ListaZnakova]	-	pretra�uje po bilo kojem znaku koji je naveden u listi pri �emu
					rezultat NE SADR�I bilo koji od navedenih znakova
[A-C]			-	pretra�uje po svim znakovima u intervalu izme�u navedenih 
					uklju�uju�i i navedene znakove, pri �emu rezultat SADR�I navedene znakove
[^A-C]			-	pretra�uje po svim znakovima u intervalu izme�u navedenih 
					uklju�uju�i i navedene znakove, pri �emu rezultat NE SADR�I navedene znakove
*/

/* 
U bazi Northwind iz tabele Customers prikazati ime kompanije kupca i kontakt telefon i to samo 
onih koji u svome imenu posjeduju rije� �Restaurant�. Ukoliko naziv kompanije sadr�i karakter (-), 
kupce izbaciti iz rezultata upita.*/


select CompanyName, Phone
from Customers
where CompanyName like '%Restaurant%' and CompanyName not like '%-%'



/*
U bazi Northwind iz tabele Products prikazati proizvode �iji naziv po�inje slovima �C� ili �G�, 
drugo slovo mo�e biti bilo koje, a tre�e slovo u nazivu je �A� ili �O�. */

select ProductName
from Products
where ProductName like '[CG]_[AO]%'

/*
U bazi Northwind iz tabele Products prikazati listu proizvoda �iji naziv po�inje 
slovima �L� ili  �T� ili je ID proizvoda = 46. Lista treba da sadr�i samo one 
proizvode �ija se cijena po komadu kre�e izme�u 10 i 50. Upit napisati na dva na�ina.*/


select ProductName
from Products
where (ProductName like '[LT]%' or ProductID = 46) and (UnitPrice > 10 and UnitPrice < 50)

/*
U bazi Northwind iz tabele Suppliers prikazati ime isporu�itelja, dr�avu i fax pri �emu 
isporu�itelji dolaze iz �panije ili Njema�ke, a nemaju une�en (nedostaje) broj faksa. 
Formatirati izlaz polja fax u obliku 'N/A'.*/

select CompanyName, Country, Fax as 'N/A'
from Suppliers
where Country = 'Spain' or Country = 'Germany' and Fax is null

/*
Iz tabele Poslodavac dati pregled kolona PoslodavacID i Naziv pri �emu naziv poslodavca po�inje slovom B. 
*/

use prihodi
go
select PoslodavacID, Naziv
from Poslodavac
where Naziv like '[B]%'

/* 
Iz tabele Poslodavac dati pregled kolona PoslodvacID i Naziv pri �emu 
naziv poslodavca po�inje slovom B, drugo mo�e biti bilo koje slovo, 
tre�e je b i ostatak naziva mogu �initi sva slova.
*/

select PoslodavacID, Naziv
from Poslodavac
where Naziv like '[B]_[b]%'


/*
Iz tabele Dr�ava dati pregled kolone Drzava pri �emu naziv dr�ave zavr�ava slovom a. 
Rezultat sortirati u rastu�em redoslijedu.
*/

select Drzava
from Drzava
where Drzava like '%[a]'
order by 1 asc

/*
Iz tabele Osoba dati pregled svih osoba kojima i ime i prezime po�inju slovom a. 
Dati prikaz OsobaID, Prezime i Ime. Rezultat sortirati po prezimenu i imenu u rastu�em redoslijedu.
*/

select OsobaID, Ime, PrezIme
from Osoba
where Ime like '[A]%' and PrezIme like '[A]%' 
order by 2, 3 asc

/*
Iz tabele Poslodavac dati pregled svih poslodavaca u �ijem nazivu se na kraju ne nalaze slova m i e. 
Dati prikaz PoslodavcID i Naziv.
*/

select PoslodavacID, Naziv
from Poslodavac
where Naziv like '%[^me]'

/*
Iz tabele Osoba dati pregled svih osoba kojima se prezime zavr�ava samoglasnikom. 
Dati prikaz OsobaID, Prezime i Ime. Rezultat sortirati po prezimenu u opadaju�em redoslijedu.
*/

select OsobaID, PrezIme, Ime
from Osoba
where PrezIme like '%[aeiou]'
order by 2 desc
/*
Iz tabele Osoba dati pregled svih osoba kojima ime po�inje bilo kojim od prvih 10 slova engleskog alfabeta. 
Dati prikaz OsobaID, Prezime i Ime. Rezultat sortirati po prezimenu u opadaju�em redoslijedu.
*/

select OsobaID, PrezIme, Ime
from Osoba
where Ime like '[A-J]%'
order by 2 desc

/*
Iz tabele Osoba dati pregled kolona OsobaID, Prezime, Ime i Adresa uz uslov da se prika�u 
samo oni zapisi koji po�inju bilo kojom cifrom u intervalu 1-9.
*/

select OsobaID, PrezIme, Ime, Adresa
from Osoba
where Adresa like '[1-9]%'


/*
Iz tabele Osoba dati pregled kolona OsobaID, Prezime, Ime i Adresa uz uslov da se 
prika�u samo oni zapisi koji ne po�inju bilo kojom cifrom u intervalu 1-9.
*/

select OsobaID, PrezIme, Ime, Adresa
from Osoba
where Adresa like '[^1-9]%'

/* 
	-------------------------------------------------------------------------------------------------------------- 
	6_KREIRANJE TABELA
*/

/*
1. Kreirati bazu podataka radna.
*/
create database radna
use radna

/*2. Vode�i ra�una o strukturi tabela kreirati odgovaraju�e veze (vanjske klju�eve) 

a) Kreirati tabelu autor koja �e se sastojati od sljede�ih polja:
	au_id		varchar(11)	primarni klju�
	au_lname	varchar(40)	
	au_fname	varchar(20)	
	phone		char(15)	
	address		varchar(40)	obavezan unos
	city		varchar(20)	obavezan unos
	state		char(2)	obavezan unos
	zip			char(5)	obavezan unos
	contract	bit	
*/

create table autor
(
	au_id varchar(11),
	au_lname varchar(40),
	au_fname varchar(20),
	phone char(15),
	address varchar(40) not null,
	city varchar(20) not null,
	state char(2) not null,
	zip char(5) not null,
	contract bit,
	CONSTRAINT pk_au_id primary key (au_id)
)
/*
b) Kreirati tabelu naslov koja �e se sastojati od sljede�ih polja:
	title_id	varchar(6), primarni klju�
	title		varchar(80)	
	type		char(12)	
	pub_id		char(4)	obavezan unos
	price		money	obavezan unos
	advance		money	obavezan unos
	royalty		int	obavezan unos
	ytd_sales	int	obavezan unos
	notes		varchar(200)	obavezan unos
	pubdate		datetime	
		
*/

create table naslov 
(
	title_id varchar(6),
	title varchar(80),
	type char(12),
	pub_id char(4),
	price money,
	advance money,
	royalty int,
	ytd_sales int,
	notes varchar(200),
	pubdate datetime,
	CONSTRAINT pk_title_id primary key(title_id)
)

/*
c) Kreirati tabelu naslov_autor koja �e se sastojati od sljede�ih polja:
	au_id		varchar(11)	
	title_id	varchar(6)	
	au_ord		tinyint	obavezan unos
	royaltyper	int	obavezan unos
*/

create table naslov_autor
(
	au_id varchar(11),
	title_id varchar(6),
	au_ord tinyint,
	royaltyper int,
	CONSTRAINT pk_naslov_autor primary key (au_id, title_id),
	CONSTRAINT fk_naslov_autor_autor foreign key(au_id) references autor (au_id),
	CONSTRAINT fk_naslov_autor_naslov foreign key (title_id) references naslov (title_id)
)
/*
3. Insert (import) podataka.
	a) u tabelu autori podatke iz tabele authors baze pubs, ali tako da se u koloni phone 
	   tabele autor prve 3 cifre smjeste u zagradu.
	b) u tabelu naslovi podatke iz tabele titles baze pubs, ali tako da se izvr�i 
	   zaokru�ivanje vrijednosti (podaci ne smiju imati decimalne vrijednosti) u koloni price
	c) u tabelu naslov_autor podatke iz tabele titleauthor baze pubs, pri �emu �e se u 
	   koloni au_ord vrijednosti iz tabele titleauthor zamijeniti na sljede�i na�in:
	1 -> 101
	2 -> 102
	3 -> 103
*/

insert into autor
select au_id, au_lname, au_fname, '(' + left (phone,3) + ')' + substring (phone, 4,9), address, city, state, zip ,contract
from pubs.dbo.authors
select*
from autor

insert into naslov
select title_id, title, type, pub_id, round(price,0), advance, royalty, ytd_sales, notes, pubdate
from pubs.dbo.titles
select * from naslov

insert into naslov_autor
select au_id, title_id, 100 + au_ord, royaltyper
from pubs.dbo.titleauthor
select * from naslov_autor
/*
4. Izvr�iti update podataka u koloni contract tabele autor po sljede�em pravilu:
	0 -> NE
	1 -> DA
*/

alter table autor
alter column contract char(2)

update autor
set contract = 'NE'
where contract = '0'

update autor
set contract = 'DA'
where contract = '1'

select contract from autor
	
/*
5. Kopirati tabelu sales iz baze pubs u tabelu prodaja u bazi radna.
*/

select *
into prodaja
from pubs.dbo.sales

select * from prodaja
select * from pubs.dbo.sales

/*
6. Kopirati tabelu autor u tabelu autor1, izbrisati sve podatke, 
a nakon toga u tabelu autor1 importovati podatke iz tabele autor uz uslov 
da ID autora zapo�inje brojevima 1, 2 ili 3 i da autor ima zaklju�en ugovor (contract).
*/
select * 
into autor1
from autor

delete autor1

insert into autor1
select *
from autor
where au_id like '[123]%' and contract = 'DA'

select * from autor1
/* 
7. U tabelu autor1 importovati podatke iz tabele autor uz uslov da adresa po�inje cifrom 3, 
a na tre�em mjestu se nalazi cifra 1.
*/
insert into autor1
select * 
from autor
where address like '[3_1]%'  

/*
8. Kopirati tabelu naslov u tabelu naslov1, izbrisati sve podatke, a nakon toga u tabelu 
   naslov1 importovati podatke iz tabele naslov na na�in da se cijena (price) koriguje na sljede�i na�in:
	- naslov �ija je cijena ve�a ili jednaka 15 KM cijenu smanjiti za 20% (podaci trebaju biti zaokru�eni na 2 decimale)
	- naslov �ija je cijena manja od 15 KM cijenu smanjiti za 15% (podaci trebaju biti zaokru�eni na 2 decimale)
*/
select *
into naslov1
from naslov

delete naslov1

insert into naslov1
select title_id, title, type, pub_id, round((price*-price*0.2), 2), advance, royalty, ytd_sales, notes, pubdate
from naslov
where price>=15 

insert into naslov1
select title_id, title, type, pub_id, round((price*-price*0.15), 2), advance, royalty, ytd_sales, notes, pubdate
from naslov
where price<15 

select * from naslov1
/*
9. Kopirati tabelu naslov_autor u tabelu naslov_autor1, a nakon toga u tabelu naslov_autor1 dodati novu kolonu isbn.
*/

select *
into naslov_autor1
from naslov_autor

alter table naslov_autor1
add isbn varchar(10)

/*
10. Kolonu isbn popuniti na na�in da se iz au_id preuzmu prve 3 cifre i srednja crta, 
te se na to dodaju posljednje 4 cifre iz title_id.
*/

update naslov_autor1
set isbn = left (au_id, 4) + right(title_id, 4)
/*
11. U tabelu autor1 dodati kolonu sifra koja �e se popunjavati slu�ajno 
generisanim nizom znakova, pri �emu je broj znakova ograni�en na 15.
*/

alter table autor1
add sifra as left (newid(), 15)
/*
12. Tabelu Order Details iz baze Northwind kopirati u tabelu detalji_narudzbe.
*/
select* 
into detalji_narudzbe
from NORTHWND.dbo.[Order Details]

delete detalji_narudzbe
/*
13. U tabelu detalji_narudzbe dodati izra�unate kolone cijena_s_popustom i ukupno. 
cijena_s_popustom �e se ra�unati pomo�u kolona UnitPrice i Discount, a ukupno pomo�u kolona Quantity i cijena_s_popustom. 
Obje kolone trebaju biti formirani kao numeri�ki tipovi sa dva decimalna mjesta.
*/

alter table detalji_narudzbe
add cijena_s_popustom as (UnitPrice-UnitPrice*Discount)

alter table detalji_narudzbe
add ukupno as (Quantity*(UnitPrice-UnitPrice*Discount))
/*
14. U tabelu detalji_narudzbe izvr�iti insert podataka iz tabele Order Details baze Northwind.
*/

insert into detalji_narudzbe
select *
from NORTHWND.dbo.[Order Details]

select * from detalji_narudzbe

/*
15. Kreirati tabelu uposlenik koja �e se sastojati od sljede�ih polja:
	uposlenikID	cjelobrojna vrijednost, primarni klju�, automatsko punjenje sa inkrementom 1 i po�etnom vrijedno��u 1
	emp_id		char(9)	
	fname		varchar(20)	
	minit		char(1)	
	lname		varchar(30)	
	job_id		smallint	
	job_lvl		tinyint	
	pub_id		char(4)	
	hire_date	datetime, defaultna vrijednost je aktivni datum	
*/

create table uposlenik
(
	uposlenikID int,
	emp_id char(9),
	fname varchar(20),
	minit char(1),
	lname varchar(30),
	job_id smallint,
	job_lvl tinyint,
	pub_id char(4),
	hire_date datetime constraint df_hire_date default getdate(),
	CONSTRAINT pk_uposlenik primary key (uposlenikID) 
)

/*
16. U sve kolone tabele uposlenik osim hire_date insertovati podatke iz tabele employee baze pubs.
*/

insert into uposlenik ( uposlenikID, emp_id,fname,minit,lname,job_id,job_lvl,pub_id)
select emp_id,fname,minit,lname,job_id,job_lvl,pub_id
from pubs.dbo.employee

/*
17. U tabelu uposlenik dodati kolonu sifra veli�ine 10 unicode karaktera, 
a nakon toga kolonu sifra popuniti slu�ajno generisanim karakterima.
*/

alter table uposlenik
add sifra unicode(10)

update uposlenik
set sifra = left(newid(),10)

/*------------------------------------------------------------------------------------------------------
  7_AGREGATNE FUNKCIJE
  7_PODUPITI
*/

/*
Iz tabele Order Details u bazi Northwind prikazati narud�be sa najmanjom i najve�om naru�enom koli�inom, 
ukupan broj narud�bi, ukupan broj naru�enih proizvoda, te srednju vrijednost naru�enih proizvoda.
*/

select min(Quantity) as minimalna, max(Quantity) as maksimalna, count(Quantity), avg(Quantity)
from NORTHWND.dbo.[Order Details]
group by ProductID



/*
Iz tabele Order Details u bazi Northwind prikazati narud�be sa najmanjom i najve�om ukupnom nov�anom vrijedno��u.*/


select ProductID, min(UnitPrice*Quantity) as minimalna, max(Unitprice*Quantity) as maksimalna
from NORTHWND.dbo.[Order Details]
group by ProductID

/*
Iz tabele Order Details u bazi Northwind prikazati broj narud�bi sa odobrenim popustom.
*/

select count(Discount)
from NORTHWND.dbo.[Order Details]

/*
Iz tabele Orders u bazi Northwind prikazati tro�ak prevoza ako je ve�i od 20000 za robu koja se 
kupila u Francuskoj, Njema�koj ili �vicarskoj. Rezultate prikazati po dr�avama.
*/

select ShipCountry, sum(Freight)
from NORTHWND.dbo.Orders
where ShipCountry in ('France', 'Germany', 'Switzerland')
group by ShipCountry
having sum(Freight)>1000


/*
Iz tabele Orders u bazi Northwind prikazati sve kupce po ID-u kod kojih ukupni tro�kovi prevoza 
nisu pre�li 7500 pri �emu se rezultat treba sortirati opadaju�im redoslijedom po visini tro�kova prevoza.
*/

select CustomerID,  sum(Freight) as suma
from NORTHWND.dbo.Orders
where Freight<=7500
group by CustomerID
order by 2 desc

/*
SELECT column-names
  FROM table-name1
 WHERE value IN (SELECT column-name
                   FROM table-name2 
                  WHERE condition)

SELECT column1 = (SELECT column-name FROM table-name WHERE condition),
       column-names
  FROM table-name
 WEHRE condition


 SELECT FirstName, LastName, 
       OrderCount = (SELECT COUNT(O.Id) FROM [Order] O WHERE O.CustomerId = C.Id)
  FROM Customer C 
  */

--northwind
/*
Koriste�i tabelu Order Details kreirati upit kojim �e se odrediti razlika izme�u:
a) minimalne i maksimalne vrijednosti UnitPrice.
b) maksimalne i srednje vrijednosti UnitPrice
*/

select (max(UnitPrice)- min(UnitPrice)) as Razlika 
from NORTHWND.dbo.[Order Details]

/*
Koriste�i tabelu Order Details kreirati upit kojim �e se odrediti srednje vrijednosti UnitPrice po narud�bama.
*/

select OrderID, avg(UnitPrice)
from NORTHWND.dbo.[Order Details]
group by OrderID


/*
Koriste�i tabelu Order Details kreirati upit kojim �e se prebrojati broj narud�bi kojima je UnitPrice:
a) za 20 KM ve�a od minimalne vrijednosti UniPrice
b) za 10 KM manja od maksimalne vrijednosti UniPrice
*/

select count(OrderID) 
from NORTHWND.dbo.[Order Details]
where UnitPrice in (select min(UnitPrice)+20
					from NORTHWND.dbo.[Order Details])

	  
/*
Koriste�i tabelu Order Details kreirati upit kojim �e se dati pregled zapisa kojima se UnitPrice 
nalazi u rasponu od +10 KM u odnosu na minimum i -10 u odnosu na maksimum. Upit traba da sadr�i OrderID.
*/

select OrderID, UnitPrice
from NORTHWND.dbo.[Order Details]
where UnitPrice between
(select min(UnitPrice) + 10
 from NORTHWND.dbo.[Order Details])
 and
 (select max(UnitPrice) - 10
 from NORTHWND.dbo.[Order Details])
 order by 2 desc


/*
Koriste�i tabelu Orders kreirati upit kojim �e se prebrojati broj naru�itelja kojima se Freight 
nalazi u rasponu od 10 KM u odnosu na srednju vrijednost Freighta. Upit traba da sadr�i CustomerID 
i ukupan broj po CustomerID.
*/

select CustomerID, count(CustomerID) as brojpoID
from NORTHWND.dbo.Orders
where Freight between
(select avg(Freight)-10
 from NORTHWND.dbo.Orders)
 and
 (select avg(Freight)+10
 from NORTHWND.dbo.Orders)
group by CustomerID
order by 2 desc

/*
Koriste�i tabele Orders i Order Details kreirati upit kojim �e se dati pregled ukupnih koli�ina ostvarenih po OrderID.
*/

select  sum(Quantity)
from NORTHWND.dbo.[Order Details] as OD inner join NORTHWND.dbo.Orders as O
on OD.OrderID = O.OrderID


/*
Koriste�i tabele Orders i Employees kreirati upit kojim �e se dati pregled ukupno realiziranih narud�bi po uposleniku.
Upit treba da sadr�i prezime i ime uposlenika, te ukupan broj narud�bi.
*/

select E.FirstName, E.LastName, count(O.OrderID) as UkupnoNarudzbi
from NORTHWND.dbo.Orders as O inner join NORTHWND.dbo.Employees as E
on O.EmployeeID = E.EmployeeID
group by E.FirstName, E.LastName

SELECT Employees.FirstName, Employees.LastName, 
		brnarudzbi = (select count (*) from Orders where Orders.EmployeeID = Employees.EmployeeID)
		from Employees
		order by 3
       

/*
Koriste�i tabele Orders i Order Details kreirati upit kojim �e se dati pregled narud�bi kupca 
u kojima je naru�ena koli�ina ve�a od 10.
Upit treba da sadr�i CustomerID i Koli�inu, te ukupan broj narud�bi.
*/


select O.CustomerID, OD.Quantity as Koli�ina, count(O.OrderID) as BrNarudzbi
from NORTHWND.dbo.Orders as O inner join NORTHWND.dbo.[Order Details] as OD
on O.OrderID = OD.OrderID
where Quantity in (select Quantity from NORTHWND.dbo.[Order Details] where Quantity>10)
group by O.CustomerID, OD.Quantity

/*

Koriste�i tabelu Products kreirati upit kojim �e se dati pregled proizvoda kojima je 
stanje na stoku ve�e od srednje vrijednosti stanja na stoku. Upit treba da sadr�i ProductName i UnitsInStock.
*/
use NORTHWND
go
select ProductName, UnitsInStock
from Products
where UnitsInStock > (select avg(UnitsInStock) from Products)


/*
Koriste�i tabelu Products kreirati upit kojim �e se prebrojati broj proizvoda 
po dobavlja�u kojima je stanje na stoku ve�e od srednje vrijednosti stanja na stoku. 
Upit treba da sadr�i SupplierID i ukupan broj proizvoda.
*/

select SupplierID, 
   UkupnoProizvoda = (select count(ProductName) from Products where UnitsInStock > (select avg(UnitsInStock) from Products))
from Products
group by SupplierID

/*
Iz tabele Order Details baze Northwind dati prikaz ID narud�be, 
ID proizvoda i jedini�ne cijene, te razliku cijene proizvoda
u odnosu na srednju vrijednost cijene za sve proizvode u tabeli. Rezultat sortirati prema vrijednosti razlike
u rastu�em redoslijedu.
*/
use NORTHWND
go
select OrderID, ProductID, UnitPrice, (select avg(UnitPrice) from [Order Details]) as srednja,
	  (UnitPrice - (select avg(UnitPrice) from [Order Details])) as razlika
from [Order Details]
order by 5

/*
Iz tabele Products baze Northwind za sve proizvoda kojih ima na stanju dati prikaz ID proizvoda, 
naziv proizvoda i stanje zaliha, te razliku stanja zaliha proizvoda u odnosu na srednju vrijednost 
stanja za sve proizvode u tabeli. Rezultat sortirati prema vrijednosti razlike u 
opadaju�em redoslijedu.*/

select ProductID, ProductName, UnitsInStock, (select avg(UnitsInStock) from dbo.Products) as srednja, 
	   (UnitsInStock - (select avg(UnitsInStock) from dbo.Products)) as razlika
from dbo.Products 
order by 5 desc

/*
Upotrebom tabela Orders i Order Details baze Northwind prikazati ID narud�be i kupca koji je kupio
vi�e od 10 komada proizvoda �iji je ID 15.*/
Use NORTHWND
select CustomerID, OrderID
from Orders
where (select Quantity from [Order Details] 
	   where  [Order Details].OrderID = Orders.OrderID and 
			   [Order Details].ProductID = 15) > 10

/*
Upotrebom tabela sales i stores baze pubs prikazati ID i naziv prodavnice u kojoj je naru�eno
vi�e od 1 komada publikacije �iji je ID 6871.*/

use pubs
go
select stor_id, stor_name
from dbo.stores
where (select qty from sales where sales.stor_id = stores.stor_id and sales.ord_num = '6871') > 1


/*------------------------------------------------------------------------------------------------------
  7_JOINI
*/

/*
INNER JOIN
Rezultat upita su samo oni zapisi u kojima se podudaraju vrijednosti spojnog polja iz obje tabele.

LEFT OUTER JOIN
Lijevi spoj je inner join kojim su pridodati i oni zapisi koji postoje u "lijevoj" tabeli, ali ne i u "desnoj".
Kod lijevog spoja, na mjestu "povezne" kolone iz desne tabele bit �e vra�ena vrijednost NULL

RIGHT OUTER JOIN
Desni spoj je inner join kojim su pridodati i oni zapisi koji postoje u "desnoj" tabeli, ali ne i u "lijevoj".
Kod desnog spoja, na mjestu "povezne" kolone iz lijeve tabele bit �e vra�ena vrijednost NULL

FULL OUTER JOIN
Kod punog spoja obje tabele imaju ulogu �glavne�. 
U rezultatu �e se na�i svi zapisi iz obje tabele koji zadovoljavaju uslov, pri �emu �e se u zapisima 
koji nisu upareni, na mjestu "poveznih" kolona iz obje tabele vratiti NULL vrijednost.
*/

/*
Iz tabela discount i stores baze pubs prikazati naziv popusta, ID i naziv prodavnice
*/

select S.stor_id, D.discounttype, S.stor_name
from discounts as D inner join stores as S
on S.stor_id = D.stor_id

/*
Iz tabela employee i jobs baze pubs prikazati ID i ime uposlenika, ID posla i naziv posla koji obavlja*/

select e.emp_id, e.fname, j.job_id, j.job_desc
from employee as e inner join jobs as j
on j.job_id = e.job_id

/*
U svim upitima treba vratiti sljede�e kolone: OsobaID iz obje tabele, RedovniPrihodiID, Neto, VanredniPrihodiID, 
IznosVanrednogPrihoda
*/

use prihodi
go
select rp.OsobaID, rp.RedovniPrihodiID, rp.Neto, vp.VanredniPrihodiID, vp.IznosVanrednogPrihoda
from VanredniPrihodi as vp inner join RedovniPrihodi as rp
on rp.OsobaID = vp.OsobaID


/*
U bazi Prihodi upotrebom:

a) left outer joina iz tabela Redovni i Vanredni prihodi prikazati id osobe iz obje tabele, neto i 
iznos vanrednog prihoda, pri �emu �e se isklju�iti zapisi u kojima je ID osobe iz tabele 
redovni prihodi NULL vrijednost, a rezultat sortirati u rastu�em redoslijedu prema ID osobe iz tabele redovni prihodi
*/

select rp.OsobaID, vp.OsobaID, rp.Neto, vp.IznosVanrednogPrihoda
from RedovniPrihodi as rp left outer join Osoba as o
on rp.OsobaID = o.OsobaID 
left outer join VanredniPrihodi as vp
on o.OsobaID = vp.OsobaID
where rp.OsobaID is not null
order by 1 asc

/*
b) right outer joina iz  tabela Redovni i Vanredni prihodi prikazati id osobe iz obje tabele, 
neto i iznos vanrednog prihoda, pri �emu �e se isklju�iti zapisi u kojima je ID osobe iz tabele redovni 
prihodi NULL vrijednost, a rezultat sortirati u rastu�em redoslijedu prema ID osobe iz tabele vanredni prihodi
*/

select rp.OsobaID, vp.OsobaID, rp.Neto, vp.IznosVanrednogPrihoda
from VanredniPrihodi as vp right outer join Osoba as o
on vp.OsobaID = o.OsobaID 
right outer join RedovniPrihodi as rp 
on o.OsobaID = rp.OsobaID
where rp.OsobaID is not null
order by vp.OsobaID asc
/*
c) full outer joina prikazati i redovne i vanredne prihode osobe, a rezultat sortirati u rastu�em 
redoslijedu prema ID osobe iz tabela redovni i vanredni prihodi
*/

select rp.OsobaID, vp.OsobaID, rp.Neto, vp.IznosVanrednogPrihoda
from RedovniPrihodi as rp full outer join Osoba as o 
on rp.OsobaID = o.OsobaID
full outer join VanredniPrihodi as vp
on o.OsobaID = vp.OsobaID
order by 1, 2 


/*
Iz tabela Employees, EmployeeTerritories, Territories i Region baze Northwind prikazati 
prezime i ime uposlenika kao polje ime i prezime, teritoriju i regiju koju pokrivaju i stariji su od 30 godina.*/

use NORTHWND
go
select e.FirstName + e.LastName as 'Ime i Prezime', e.Region, t.TerritoryDescription
from Employees as e inner join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
inner join Territories as t
on et.TerritoryID = t.TerritoryID
where (year(GETDATE()) - year(BirthDate)) > 30



/*
Iz tabela Employee, Order Details i Orders baze Northwind prikazati ime i prezime uposlenika 
kao polje ime i prezime, jedini�nu cijenu, koli�inu i ukupnu vrijednost pojedina�ne narud�be 
kao polje ukupno za sve narud�be u 1997. godini, pri �emu �e se rezultati sortirati prema novokreiranom polju ukupno.*/

use NORTHWND
select e.FirstName + e.LastName as 'Ime i Prezime', od.UnitPrice, od.Quantity, 
	   od.Quantity * od.UnitPrice as Ukupno
from Employees as e inner join Orders as o 
on e.EmployeeID = o.EmployeeID
inner join [Order Details] as od 
on o.OrderID = od.OrderID
where year(OrderDate) = 1997
order by Ukupno asc

/*
Iz tabela Employee, Order Details i Orders baze Northwind prikazati ime uposlenika i ukupnu 
vrijednost svih narud�bi koje je taj uposlenik napravio u 1996. godini ako je ukupna vrijednost 
ve�a od 50000, pri �emu �e se rezultati sortirati uzlaznim redoslijedom prema polju ime. Vrijednost 
sume zaokru�iti na dvije decimale.*/

select e.FirstName + e.LastName as 'Ime i Prezime', od.UnitPrice, od.Quantity, 
	   round(sum(od.Quantity * od.UnitPrice),2) as Ukupno
from Employees as e inner join Orders as o 
on e.EmployeeID = o.EmployeeID
inner join [Order Details] as od 
on o.OrderID = od.OrderID
where year(OrderDate) = 1996 
group by e.FirstName + e.LastName, od.UnitPrice, od.Quantity
having od.Quantity * od.UnitPrice > 5000
order by 1 asc

/*
Iz tabela Categories, Products i Suppliers baze Northwind prikazati naziv isporu�itelja (dobavlja�a), 
mjesto i dr�avu isporu�itelja (dobavlja�a) i naziv(e) proizvoda iz kategorije napitaka (pi�a) kojih na 
stanju ima vi�e od 30 jedinica. Rezultat upita sortirati po dr�avi.*/


select s.CompanyName, s.Region, s.Country, p.ProductName
from Suppliers as s inner join Products as p
on s.SupplierID = p.SupplierID 
inner join Categories as c
on  p.CategoryID = c.CategoryID 
where c.CategoryID = 1 and p.UnitsInStock > 30
order by 3 asc

select s.CompanyName, s.Region, s.Country, p.ProductName
from Categories as c inner join Products as p
on c.CategoryID = p.CategoryID
inner join Suppliers as s
on  s.SupplierID = p.SupplierID
where c.CategoryID = 1 and p.UnitsInStock > 30
order by 3 asc


/*
U tabeli Customers baze Northwind ID kupca je primarni klju�. U tabeli Orders baze Northwind ID kupca je vanjski klju�.
Dati izvje�taj:
a) koliko je ukupno kupaca evidentirano u obje tabele (lista bez ponavljanja iz obje tabele)
a.1) koliko je ukupno kupaca evidentirano u obje tabele
b) da li su svi kupci obavili narud�bu
c) koji kupci nisu napravili narud�bu*/

select CustomerID
from Customers
union
select CustomerID
from Orders

select count(CustomerID) from Customers
union all
select count(CustomerID) from Orders

select CustomerID from Customers
except
select CustomerID from Orders


/*
a) Provjeriti u koliko zapisa (slogova) tabele Orders nije unijeta vrijednost u polje regija kupovine.
b) Upotrebom tabela Customers i Orders baze Northwind prikazati ID kupca pri �emu u polje regija 
kupovine nije unijeta vrijednost, uz uslov da je kupac obavio narud�bu (kupac iz tabele Customers 
postoji u tabeli Orders). Rezultat sortirati u rastu�em redoslijedu.
*/

select count(*)
from Orders
where ShipRegion is null

select CustomerID
from Customers
intersect 
select CustomerID 
from Orders
where ShipRegion is null
order by 1 asc

/*
c) Upotrebom tabela Customers i Orders baze Northwind prikazati ID kupca pri �emu u polje regija 
kupovine nije unijeta vrijednost i kupac nije obavio ni jednu narud�bu 
(kupac iz tabele Customers ne postoji u tabeli Orders).
Rezultat sortirati u rastu�em redoslijedu.*/

select CustomerID
from Customers
except 
select CustomerID
from Orders
where ShipRegion is null
order by 1 asc

/*
Iz tabele HumanResources.Employee baze AdventureWorks2014 prikazati po 5 najstarijih zaposlenika mu�kog, 
odnosno, �enskog pola uz navo�enje sljede�ih podataka: radno mjesto na kojem se nalazi, datum ro�enja, 
korisnicko ime i godine starosti. Korisni�ko ime je dio podatka u LoginID. Rezultate sortirati prema polu 
uzlaznim, a zatim prema godinama starosti silaznim redoslijedom.*/

use AdventureWorks2014
go 
select top 5 BusinessEntityID, Gender, JobTitle, BirthDate, LoginID, year(getdate())-year(BirthDate) as 'Dob'
from HumanResources.Employee
where Gender = 'M'
union
select top 5 BusinessEntityID, Gender, JobTitle, BirthDate, LoginID, year(getdate())-year(BirthDate) as 'Dob'
from HumanResources.Employee
where Gender = 'F'
order by 2, 5 desc


/*
Iz tabele HumanResources.Employee baze AdventureWorks2014 prikazati po 2 zaposlenika sa du�im sta�om 
bez obzira da li su u braku ili ne i obavljaju poslove in�injera uz navo�enje sljede�ih podataka: radno 
mjesto na kojem se nalazi, datum zaposlenja i bra�ni status. Ako osoba nije u braku pla�a dodatni porez, 
ina�e ne pla�a. Rezultate sortirati prema bra�nom statusu uzlaznim, a zatim prema sta�u silaznim redoslijedom.*/

select top 2 BusinessEntityID, year(getdate())-year(HireDate) as 'Staz', JobTitle, HireDate, MaritalStatus
from HumanResources.Employee
where JobTitle like '%engineer%' and JobTitle not like '%engineering%' and MaritalStatus = 'S'
union
select top 2 BusinessEntityID, year(getdate())-year(HireDate) as 'Staz', JobTitle, HireDate, MaritalStatus
from HumanResources.Employee
where JobTitle like '%engineer%' and JobTitle not like '%engineering%' and MaritalStatus = 'M'

/*
Iz tabela HumanResources.Employee i Person.Person prikazati po 5 osoba prema tome da li �ele 
primati email ponude od AdventureWorksa uz navo�enje sljede�ih polja: ime i prezime osobe kao 
jedinstveno polje, organizacijski nivo na kojem se nalazi i da li prima email promocije. 
Pored ovih uvesti i polje koje �e, u ovisnosti od sadr�aja polja EmailPromotion, davati poruke: 
Ne prima, Prima selektirane i Prima. Uslov je da uposlenici rade na 1. ili 4. organizacijskom nivou. 
Rezultat sortirati prema organizacijskom nivou i dodatno uvedenom polju.
*/

select top 5 pp.FirstName + ' ' + pp.LastName as 'Ime i prezime', he.OrganizationLevel, pp.EmailPromotion, 'ne prima' mailstatus
from HumanResources.Employee as he join Person.Person as pp
on he.BusinessEntityID = pp.BusinessEntityID
where (he.OrganizationLevel = 1 or he.OrganizationLevel = 4) and EmailPromotion = 0
union
select top 5 pp.FirstName + ' ' + pp.LastName as 'Ime i prezime', he.OrganizationLevel, pp.EmailPromotion, 'prima selektirane' mailstatus
from HumanResources.Employee as he join Person.Person as pp
on he.BusinessEntityID = pp.BusinessEntityID
where (he.OrganizationLevel = 1 or he.OrganizationLevel = 4) and EmailPromotion = 1
union
select top 5 pp.FirstName + ' ' + pp.LastName as 'Ime i prezime', he.OrganizationLevel, pp.EmailPromotion, 'prima' mailstatus
from HumanResources.Employee as he join Person.Person as pp
on he.BusinessEntityID = pp.BusinessEntityID
where (he.OrganizationLevel = 1 or he.OrganizationLevel = 4) and EmailPromotion = 2
order by 2, 3 asc


/*
Iz tabela Sales.SalesOrderDetail i Production.Product prikazati 10 najskupljih stavki prodaje uz 
navo�enje polja: naziv proizvoda, koli�ina, cijena i iznos. Cijenu i iznos zaokru�iti na dvije decimale. 
Iz naziva proizvoda odstraniti posljednji dio koji sadr�ava cifre i zarez. 
U rezultatu u polju koli�ina na broj dodati 'kom.', a u polju cijena i iznos na broj dodati 'KM'.*/

select top 10 pp.Name, cast(ss.OrderQty as varchar) + 'kom', convert(varchar, round(ss.UnitPrice,2)) + 'KM', 
		      cast(round(ss.OrderQty * ss.UnitPrice,2) as varchar)+'KM' as 'Iznos'
from Production.Product as pp inner join Sales.SalesOrderDetail as ss
on pp.ProductID = ss.ProductID

/*------------------------------------------------------------------------------------------------------
  8_PODUPITI_JOINI
*/

/*
Koriste�i tabele Orders i Order Details kreirati upit koji �e dati sumu koli�ina po Order ID, pri �emu je uslov:
a) da je vrijednost Freighta ve�a od bilo koje vrijednosti Freighta narud�bi realiziranih u 12. mjesecu 1997. godine
b) da je vrijednost Freighta ve�a od svih vrijednosti Freighta narud�bi realiziranih u 12. mjesecu 1997. godine
*/
use NORTHWND
go

select OrderID, (select sum(Quantity) from [Order Details] where Orders.OrderID = [Order Details].OrderID) as suma
from Orders
where Freight > any
	  (select Freight from Orders where year(OrderDate) = 1997 and month(OrderDate) = 12)


--AdventureWorks2014
/*
Koriste�i tabele Production.Product i Production.WorkOrder kreirati upit sa podupitom koji �e 
dati sumu OrderQty po nazivu proizvoda. pri �emu se izostavljaju zapisi u kojima je suma NULL 
vrijednost. Upit treba da sadr�i naziv proizvoda i sumu po nazivu.
*/
use AdventureWorks2014
go

select pp.Name, sum(pw.OrderQty) as Suma
from Production.Product as pp inner join Production.WorkOrder as pw
on pp.ProductID = pw.ProductID
group by pp.Name
having sum(pw.OrderQty) is not null


select Name, (select sum(OrderQty) from Production.WorkOrder 
              where Production.Product.ProductID = Production.WorkOrder.ProductID) as Suma
from Production.Product
where (select sum(OrderQty) from Production.WorkOrder where Production.Product.ProductID = Production.WorkOrder.ProductID) is not null


/*
Koriste�i tabele Sales.SalesOrderHeader i Sales.SalesOrderDetail kreirati upit sa podupitom 
koji �e prebrojati CarrierTrackingNumber po SalesOrderID, pri �emu se izostavljaju zapisi 
�iji AccountNumber ne spada u klasu 10-4030. Upit treba da sadr�i SalesOrderID i prebrojani broj.
*/

select AccountNumber 
from Sales.SalesOrderHeader

select SalesOrderID, (select count(CarrierTrackingNumber) from Sales.SalesOrderDetail
					  where Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID) as Prebrojavanje
from Sales.SalesOrderHeader
where AccountNumber not like '10-4030%'

/*
Koriste�i tabele Sales.SpecialOfferProduct i Sales.SpecialOffer kreirati upit sa podupitom 
koji �e prebrojati broj proizvoda po kategorijama koji su u 2014. godini bili na specijalnoj 
ponudi pri �emu se izostavljaju one kategorije kod kojih ne postoji ni jedan proizvod koji nije bio na specijalnoj ponudi.
*/

select Category, (select count(*) from Sales.SpecialOfferProduct 
				  where Sales.SpecialOffer.SpecialOfferID = Sales.SpecialOfferProduct.SpecialOfferID)
from Sales.SpecialOffer
where year(ModifiedDate) = 2014 and Category is not null


--JOIN
--AdventureWorks2014
/*
Koriste�i tabele Person.Address, Sales.SalesOrderDetail i Sales.SalesOrderHeader kreirati 
upit koji �e dati sumu naru�enih koli�ina po gradu i godini isporuke koje su izvr�ene poslije 2012. godine.
*/

select  pa.City, sum(sod.OrderQty) as Suma, year(soh.ShipDate)
from Sales.SalesOrderDetail as sod inner join Sales.SalesOrderHeader as soh
on sod.SalesOrderID = soh.SalesOrderID
inner join Person.Address as pa
on soh.ShipToAddressID = pa.AddressID
where year(soh.ShipDate)>2012
group by pa.City, year(soh.ShipDate)

/*
Koriste�i tabele Sales.Store, Sales.SalesPerson i SalesPersonQuotaHistory kreirati upit koji �e 
dati sumu prodajnih kvota po nazivima prodavnica i ID teritorija, ali samo onih �ija je suma ve�a od 2 000 000. 
Sortirati po ID teritorije i sumi.
*/

select s.Name, sp.TerritoryID, sum(spqh.SalesQuota)
from Sales.SalesPersonQuotaHistory as spqh inner join Sales.SalesPerson as sp
on spqh.BusinessEntityID = sp.BusinessEntityID
inner join Sales.Store as s
on  sp.BusinessEntityID = s.SalesPersonID 
group by s.Name, sp.TerritoryID
having sum(spqh.SalesQuota) > 2000000
order by 2, 3


/*
Koriste�i tabele SpecialOfferProduct i SpecialOffer prebrojati broj narud�bi po kategorijama popusta 
od 0 do 15%, pri �emu treba uvesti novu kolona kategorija u koju �e biti unijeta vrijednost popusta, 
npr. 0, 1, 2... Rezultat sortirati prema koloni kategorija u rastu�em redoslijedu. Upit treba da vrati kolone: 
SpecialOfferID, prebrojani broj i kategorija.
*/
use AdventureWorks2014
select so.SpecialOfferID, count(*) as BrojNarudzbi, 0 as kategorija
from Sales.SpecialOfferProduct as sop inner join Sales.SpecialOffer as so
on sop.SpecialOfferID = so.SpecialOfferID
where so.DiscountPct = 0
union
select so.SpecialOfferID, count(*)  as BrojNarudzbi, 2 as kategorija
from Sales.SpecialOfferProduct as sop inner join Sales.SpecialOffer as so
on sop.SpecialOfferID = so.SpecialOfferID
where so.DiscountPct = 0.02
union
select so.SpecialOfferID, count(*) as BrojNarudzbi, 5 as kategorija
from Sales.SpecialOfferProduct as sop inner join Sales.SpecialOffer as so
on sop.SpecialOfferID = so.SpecialOfferID
where so.DiscountPct = 0.05
union
select so.SpecialOfferID, count(*) as BrojNarudzbi, 10 as kategorija
from Sales.SpecialOfferProduct as sop inner join Sales.SpecialOffer as so
on sop.SpecialOfferID = so.SpecialOfferID
where so.DiscountPct = 0.1
union
select so.SpecialOfferID, count(*) as BrojNarudzbi, 15 as kategorija
from Sales.SpecialOfferProduct as sop inner join Sales.SpecialOffer as so
on sop.SpecialOfferID = so.SpecialOfferID
where so.DiscountPct = 0.15

/*
Koriste�i tabele Sales.Store i Sales.Customer kreirati upit kojim �e se prebrojati koliko 
kupaca po teritorijama pokriva prodavac. Rezultat sortirati prema prodavcu i teritoriji. 
*/

select ss.SalesPersonID, sc.TerritoryID, count(*) as BrojKupaca
from Sales.Store as ss inner join Sales.Customer as sc
on ss.BusinessEntityID = sc.StoreID
group by ss.SalesPersonID, sc.TerritoryID
order by 1,2

/*
Koriste�i kolonu AccountNumber tabele Sales.Customer prebrojati broj zapisa prema broju cifara 
broj�anog dijela podatka iz ove kolone. Rezultat sortirati u rastu�em redoslijedu.
*/

select len (cast(substring(AccountNumber, charindex('W', AccountNumber)+1, len(AccountNumber)-charindex('W',AccountNumber)) as int)), count (*)
from Sales.Customer
group by 
len (cast(substring(AccountNumber, charindex('W', AccountNumber)+1, len(AccountNumber)-charindex('W',AccountNumber)) as int))
order by 1

select cast(substring(AccountNumber, charindex('W', AccountNumber)+1, len(AccountNumber)-charindex('W',AccountNumber)) as int)
from Sales.Customer

/*
Koriste�i tabele Person.Person, Person.PersonPhone, Person.PhoneNumberType i Person.Password 
kreirati upit kojim �e se dati informacija da li PasswordHash sadr�i bar jedan +. Ako sadr�i u 
koloni status_hash dati poruku "da", ina�e ostaviti prazn0. Upit treba da sadr�i kolone 
Person.Person.PersonType, Person.PersonPhone.PhoneNumber, Person.PhoneNumberType.Name, Person.Password.PasswordHash.
*/
use AdventureWorks2014
go

select pper.PersonType, ppp.PhoneNumber, ppnt.Name, ppas.PasswordHash, 'da' status_hash
from Person.Password as ppas inner join Person.Person as pper
on  ppas.BusinessEntityID = pper.BusinessEntityID 
inner join Person.PersonPhone as ppp
on ppp.BusinessEntityID = pper.BusinessEntityID
inner join person.PhoneNumberType as ppnt
on   ppnt.PhoneNumberTypeID  = ppp.PhoneNumberTypeID 
where charindex('+', ppas.PasswordHash) > 0 
union
select pper.PersonType, ppp.PhoneNumber, ppnt.Name, ppas.PasswordHash, ' ' status_hash
from Person.Password as ppas inner join Person.Person pper
on ppas.BusinessEntityID = pper.BusinessEntityID 
inner join Person.PersonPhone as ppp
on ppp.BusinessEntityID = pper.BusinessEntityID
inner join person.PhoneNumberType as ppnt
on ppp.PhoneNumberTypeID = ppnt.PhoneNumberTypeID
where  charindex('+', ppas.PasswordHash) = 0 


/*
Koriste�i tabele HumanResources.Employee i HumanResources.EmployeeDepartmentHistory kreirati 
upit koji �e dati pregled ukupno ostaverenih bolovanja po departmentu, pri �emu �e se uzeti u 
obzir samo one osobe �iji nacionalni broj po�inje ciframa 10, 20, 80 ili 90.
*/

select hd.DepartmentID, sum(he.SickLeaveHours) as 'Ukupno Bolovanja', he.NationalIDNumber
from HumanResources.Employee as he inner join HumanResources.EmployeeDepartmentHistory hd
on he.BusinessEntityID = hd.BusinessEntityID
where he.NationalIDNumber like '10%'
group by hd.DepartmentID, he.NationalIDNumber
union 
select hd.DepartmentID, sum(he.SickLeaveHours) as 'Ukupno Bolovanja', he.NationalIDNumber
from HumanResources.Employee as he inner join HumanResources.EmployeeDepartmentHistory hd
on he.BusinessEntityID = hd.BusinessEntityID
where he.NationalIDNumber like '20%'
group by hd.DepartmentID, he.NationalIDNumber
union
select hd.DepartmentID, sum(he.SickLeaveHours) as 'Ukupno Bolovanja', he.NationalIDNumber
from HumanResources.Employee as he inner join HumanResources.EmployeeDepartmentHistory hd
on he.BusinessEntityID = hd.BusinessEntityID
where he.NationalIDNumber like '80%'
group by hd.DepartmentID, he.NationalIDNumber
union
select hd.DepartmentID, sum(he.SickLeaveHours) as 'Ukupno Bolovanja', he.NationalIDNumber
from HumanResources.Employee as he inner join HumanResources.EmployeeDepartmentHistory hd
on he.BusinessEntityID = hd.BusinessEntityID
where he.NationalIDNumber like '90%'
group by hd.DepartmentID, he.NationalIDNumber

/*
Koriste�i tabele Purchasing.PurchaseOrderHeader, Purchasing.Vendor, Purchasing.PurchaseOrderDetail i 
Purchasing.ShipMethod kreirati upit koji �e sadr�avati kolone VendorID, Name vendora, EmployeeID, 
ShipDate, ShipBase i UnitPrice, uz uslov da je UnitPrice ve�a od ShipBase.
*/

select poh.VendorID, pv.Name, poh.EmployeeID, poh.ShipDate, sm.ShipBase, pod.UnitPrice
from Purchasing.Vendor as pv inner join Purchasing.PurchaseOrderHeader as poh
on poh.VendorID = pv.BusinessEntityID
inner join Purchasing.ShipMethod as sm
on sm.ShipMethodID = poh.ShipMethodID
inner join Purchasing.PurchaseOrderDetail as pod
on pod.PurchaseOrderID = poh.PurchaseOrderID
where pod.UnitPrice > sm.ShipBase


/*
Koriste�i tabele Person.Person, Sales.PersonCreditCard i Person.Password kreirati upit koji �e 
da vrati polja BusinessEntityID, PersonType, CreditCardID i PasswordSalt.
*/

select pper.BusinessEntityID, pper.PersonType, spc.CreditCardID, ppas.PasswordSalt
from Person.Password as ppas inner join Person.Person as pper
on ppas.BusinessEntityID = pper.BusinessEntityID
inner join Sales.PersonCreditCard as spc
on pper.BusinessEntityID = spc.BusinessEntityID

/*
Koriste�i tabele  Production.ProductModelProductDescriptionCulture, Production.ProductModel i 
Production.Product kreirati upit koji �e vratiti polja CultureID, Name iz tabele Production.ProductModel, 
Name iz tabele Production.Product i Color, te prebrojani broj po koloni Color. 
Uslov je da se ne prikazuju upiti u kojima nije unijeta vrijednost za CatalogDescription iz tabele Production.ProductModel.
*/

select pmpd.CultureID, pm.Name, pp.Name, pp.Color, count(pp.ProductNumber) as Broj
from Production.Product as pp inner join Production.ProductModel as pm 
on pp.ProductModelID = pm.ProductModelID 
inner join Production.ProductModelProductDescriptionCulture as pmpd
on pm.ProductModelID = pmpd.ProductModelID
where pm.CatalogDescription is not null and pp.Color is not null
group by pmpd.CultureID, pm.Name, pp.Name, pp.Color

select CatalogDescription
from Production.ProductModel

/*
Koriste�i tabelu Production.Product kreirati upit koji �e prebrojati broj zapisa iza tabele po bojama. 
Navesti i broj zapisa u kojima nije unijeta vrijednost za boju i dati poruku "nije unijeta vrijednost".
*/

select Color, count(*)
from Production.Product
where Color = 'Black'
group by Color
union
select Color, count(*)
from Production.Product
where Color = 'Yellow'
group by Color
union
select Color, count(*)
from Production.Product
where Color = 'Blue'
group by Color
union
select Color, count(*)
from Production.Product
where Color = 'Red'
group by Color
union
select Color, count(*)
from Production.Product
where Color = 'Silver'
group by Color
union
select 'Nije unijeta vrijednost' as Color, count(*)
from Production.Product
where Color is null
group by Color
order by 2

/*
---------------------------------------------------------------------------------------------
	9_OBJEKTI
*/

/*
a) U okviru baze AdventureWorks kopirati tabele Sale.Store, Sales.Customer, Sales.SalesTerritoryHistory i 
Sales.SalesPerson u tabele istih naziva a koje �e biti u �emi vjezba. 
Nakon kopiranja u novim tabelama definirati iste PK i FK kojima su definirani odnosi me�u tabelama.
*/

create schema vjezba
go

select * 
into vjezba.Store
from Sales.Store

select* 
into vjezba.Customer
from sales.Customer

select*
into vjezba.SalesTerritoryHistory
from Sales.SalesTerritoryHistory

select* 
into vjezba.SalesPerson
from Sales.SalesPerson

alter table vjezba.Store
add constraint pk_Store primary key (BusinessEntityID)

alter table vjezba.SalesTerritoryHistory
add constraint pk_SalesTerritoryHistory primary key (BusinessEntityID, TerritoryID, StartDate)

alter table vjezba.Customer
add constraint pk_Customer primary key (CustomerID)

alter table vjezba.SalesPerson
add constraint pk_SalesPerson primary key (BusinessEntityID)

alter table vjezba.Store
add constraint fk_Store_SalesPerson_SalesPersonID foreign key (SalesPersonID) references vjezba.SalesPerson(BusinessEntityID)

alter table vjezba.Customer
add constraint fk_Customer_Store_StoreID foreign key (StoreID) references vjezba.Store (BusinessEntityID)

alter table vjezba.SalesTerritoryHistory
add constraint fk_SalesTerritoryHistory_SalesPerson_BusinessEntityID foreign key (BusinessEntityID) 
references vjezba.SalesPerson (BusinessEntityID)

/*
b) Definirati sljede�a ograni�enja (prva dva samo za tabele Customer i SalesPerson): 
	1. ModifiedDate kolone -					defaultna vrijednost je aktivni datum
	2. rowguid -								slu�ajno generisani niz znakova
	3. SalesQuota u tabeli SalesPerson -		defaultna vrijednost 0.00
												zabrana unosa vrijednost manje od 0.00
	4. EndDate u tabeli SalesTerritoryHistory - zabrana unosa starijeg datuma od StartDate
--constraint
ModifiedDate, rowguid
*/


alter table vjezba.Customer
add constraint DF_ModifiedDate_c default (getdate()) for ModifiedDate

alter table vjezba.SalesPerson
add constraint DF_rowguid_c default (newid()) for rowguid

alter table vjezba.SalesPerson
add constraint DF_SalesQuota_c default (0.00) for SalesQuota

alter table vjezba.SalesPerson
add constraint DF_SalesQuota check (SalesQuota>=0.00)

alter table vjezba.SalesTerritoryHistory
add constraint DF_EndDate_c check (EndDate >= StartDate)

/*
c) Dodati tabele u dijagram
*/


/*
U tabeli Customer:
a) dodati stalno pohranjenu kolonu godina koja �e preuzimati godinu iz kolone ModifiedDate
b) ograni�iti du�inu kolone rowguid na 10 znakova, a zatim postaviti defaultnu vrijednost na 10 slu�ajno generisanih znakova
c) obrisati PK tabele, a zatim definirati kolonu istog naziva koja �e biti identity sa po�etnom vrijedno��u 1 i inkrementom 2
d) izvr�iti insert podataka iz tabele Sales.Customer
e) kreirati upit za prikaz zapisa u kojima je StoreID ve�i od 500, a zatim pokrenuti upit sa uklju�enim vremenom i planom izvr�avanja
f) nad kolonom StoreID kreirati nonclustered indeks, a zatim pokrenuti upit sa uklju�enim vremenom i planom izvr�avanja
g) kreirati upit za prikaz zapisa u kojima je TerritoryID ve�i od 1, a zatim pokrenuti upit sa uklju�enim vremenom i planom izvr�avanja
h) nad kolonom TerritoryID kreirati nonclustered indeks, a zatim pokrenuti upit sa uklju�enim vremenom i planom izvr�avanja
*/
--a
alter table vjezba.Customer
add godina as year(ModifiedDate)

alter table vjezba.Customer
drop constraint DF_rowguid

--b
alter table vjezba.Customer
alter column rowguid char(40)

alter table vjezba.Customer
add constraint DF_rowguid check (len (rowguid) = 10)

--c
alter table vjezba.Customer
drop constraint pk_Customer

alter table vjezba.Customer
drop column Customer

alter table vjezba.Customer
add CustomerID int identity(1,2)

alter table vjezba.Customer
add CustomerID int constraint PK_Customer primary key identity (1,2)
--d

alter table vjezba.Customer
add godina as year (ModifiedDate)

alter table vjezba.Customer
drop constraint DF_rowguid


--d
insert into vjezba.Customer
select PersonID, StoreID, TerritoryID, AccountNumber, left (rowguid,10)
from Sales.Customer

/*
e) kreirati upit za prikaz zapisa u kojima je StoreID ve�i od 500, 
   a zatim pokrenuti upit sa uklju�enim vremenom i planom izvr�avanja
f) nad kolonom StoreID kreirati nonclustered indeks, a zatim pokrenuti upit sa uklju�enim vremenom i planom izvr�avanja
g) kreirati upit za prikaz zapisa u kojima je TerritoryID ve�i od 1, a zatim 
   pokrenuti upit sa uklju�enim vremenom i planom izvr�avanja
h) nad kolonom TerritoryID kreirati nonclustered indeks, a zatim pokrenuti upit sa uklju�enim vremenom i planom izvr�avanja
*/

set statistics time on
select StoreID
from vjezba.Customer
where StoreID>500
set statistics time off

--f

create nonclustered index indeks_store
on vjezba.Customer(StoreID)

set statistics time on
select StoreID
from vjezba.Customer
where StoreID>500
set statistics time off

drop index indeks_store on vjezba.Customer

--g
set statistics time on
select * 
from vjezba.Customer
where TerritoryID>1
set statistics time off

--h

create nonclustered index indeks_ter
on vjezba.Customer(TerritoryID)

set statistics time on
select * 
from vjezba.Customer
where TerritoryID>1
set statistics time off

drop index indeks_ter on vjezba.Customer

/*
parse - provjera sintakse
compile - optimizer za kreiranje optimalnog plana izvr�enja
CPU time - vrijeme zauze�a procesora
elapsed time - zbir parse i compile
razlika CPU i elapsed - vrijeme �ekanja da CPU obradi upit ili
						vrijeme izvr�avanja IO operacija
ponavljanjem upita elapsed time se smanjuje (dolazi do 0 nakon dovoljnog broja ponavljanja) jer je server zapamtio compile postavke i ne obavlja parse
*/

/*
northwind
Koriste�i tabele Order Details i Products kreirati upit kojim �e se dati prikaz naziva proizvoda, 
jedini�ne cijene i koli�ine uz uslov da se prika�u samo oni proizvodi koji po�inju slovima A ili C. 
Uklju�iti prikaz vremena i plana izvr�avanja.
*/

use NORTHWND

set statistics time on
select p.ProductName, od.UnitPrice, od.Quantity
from [Order Details] as od inner join Products as p
on od.ProductID = p.ProductID
where left (p.ProductName, 1) = 'A' or left (p.ProductName, 1) = 'C'
order by 1 asc
set statistics time off


/*
northwind
Koriste�i tabele Order i Customers kreirati upit kojim �e se dati prikaz naziva kompanije, 
po�tanskog broja, datuma narud�be i datuma isporuke uz uslov da se prika�u samo oni proizvodi 
za koje je razlika OrderDate i ShippedDate pozitivna. Uklju�iti prikaz vremena i plana izvr�avanja.
*/

set statistics time on
select c.CompanyName, c.PostalCode, o.OrderDate, o.ShippedDate 
from Customers  as c inner join Orders as o
on c.CustomerID = o.CustomerID
where day(o.OrderDate) - day(o.ShippedDate)  > 0
set statistics time off

/*----------------------------------------------------------------------------------------------------
	10_POGLEDI
*/

/*
Koriste�i tabele Employees, EmployeeTerritories, Territories i Region baze Northwind kreirati 
pogled view_Employee koji �e sadr�avati prezime i ime uposlenika kao polje ime i prezime, 
teritoriju i regiju koju pokrivaju. Uslov je da su stariji od 30 godina i pokrivaju terirotiju Western.
*/

create view view_Employees as

select e.FirstName + ' ' + e.LastName as 'Ime i prezime', t.TerritoryDescription, r.RegionDescription
from Employees as e inner join EmployeeTerritories as et 
on e.EmployeeID = et.EmployeeID
inner join Territories as t
on t.TerritoryID = et.TerritoryID
inner join Region as r
on r.RegionID = t.RegionID
where year(getdate()) - year(e.BirthDate) > 30 and r.RegionDescription = 'Western'
go

drop view view_Employees

select *
from view_Employees


/*
Koriste�i tabele Employee, Order Details i Orders baze Northwind kreirati pogled view_Employee2 
koji �e sadr�avati ime uposlenika i ukupnu vrijednost svih narud�bi koje je taj 
uposlenik napravio u 1996. godini ako je ukupna vrijednost ve�a od 50000, pri �emu �e se 
rezultati sortirati uzlaznim redoslijedom prema polju ime.
*/

create view view_Employee2 as

select e.FirstName, round(sum(od.UnitPrice*(od.UnitPrice-od.Discount) * od.Quantity),2) as 'Suma'
from Employees as e inner join Orders as o
on e.EmployeeID = o.EmployeeID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
where year(o.OrderDate) = 1996
group by e.FirstName
having sum(od.UnitPrice*(od.UnitPrice-od.Discount)  * od.Quantity) > 50000
go

select*
from view_Employee2

drop view view_Employee2


/*
Koriste�i tabele Orders i Order Details kreirati pogled koji �e sadr�avati polja: 
Orders.EmployeeID, [Order Details].ProductID i suma po UnitPrice.
*/

create view ood as 

select o.EmployeeID, od.ProductID, round(sum(od.UnitPrice),2) as 'Suma'
from Orders as o inner join [Order Details] as od 
on od.OrderID = o.OrderID
group by o.EmployeeID, od.ProductID
go

select*
from ood
drop view ood

/*
Koriste�i prethodno kreirani pogled izvr�iti ukupno sumiranje po uposlenicima. Sortirati po ID uposlenika.
*/

select EmployeeID, sum(Suma)
from ood
group by EmployeeID
order by 1 asc


/*
Koriste�i tabele Categories, Products i Suppliers kreirati pogled koji �e sadr�avati polja: 
CategoryName, ProductName i CompanyName. 
*/

create view cps as

select c.CategoryName, p.ProductName, s.CompanyName
from Categories as c inner join Products as p
on p.CategoryID = c.CategoryID
inner join Suppliers as s
on p.SupplierID = s.SupplierID
go

/*
Koriste�i prethodno kreirani pogled prebrojati broj proizvoda po kompanijama. Sortirati po nazivu kompanije.
*/

select CompanyName, count(*) as 'Broj proizvoda'
from cps
group by CompanyName
order by 1

/*
Koriste�i prethodno kreirani pogled prebrojati broj proizvoda po kategorijama. Sortirati po nazivu kompanije.
*/

select CategoryName, count(*) as 'Broj proizvoda'
from cps
group by CategoryName
order by 1


/*
Koriste�i bazu Northwind kreirati pogled view_supp_ship koji �e sadr�avati polja: 
Suppliers.CompanyName, Suppliers.City i Shippers.CompanyName. 
*/

create view view_supp_ship as

select s.CompanyName, s.City, sh.CompanyName as 'prevoznik'
from Suppliers as s inner join Products as p
on p.SupplierID = s.SupplierID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Shippers as sh
on o.ShipVia = sh.ShipperID
go


/*
Koriste�i pogled view_supp_ship kreirati upit kojim �e se prebrojati broj kompanija po prevoznicima.
*/

select prevoznik, count(CompanyName) as 'Broj kompanija'
from view_supp_ship
group by prevoznik


/*
Koriste�i pogled view_supp_ship kreirati upit kojim �e se prebrojati broj prevoznika po kompanijama. 
Uslov je da se prika�u one kompanije koje su imale ili ukupan broj prevoza manji 
od 30 ili ve�i od 150. Upit treba da sadr�i naziv kompanije, prebrojani broj prevoza i napomenu 
"nizak promet" za kompanije ispod 30 prevoza, odnosno, "visok promet" za kompanije preko 150 prevoza. 
Sortirati prema vrijednosti ukupnog broja prevoza.
*/
use NORTHWND
GO
select CompanyName, count(prevoznik) as 'Broj prevonika', 'nizak promet' as Napomena
from view_supp_ship
group by CompanyName
having count(prevoznik) <30
union
select CompanyName, count(prevoznik) as 'Broj prevonika', 'visok promet' as Napomena
from view_supp_ship
group by CompanyName
having count(prevoznik) > 150
order by 2 asc

/*
Koriste�i tabele Products i Order Details kreirati pogled view_prod_price koji �e sadr�avati 
naziv proizvoda i sve cijene po kojima se prodavao. 
*/

create view view_prod_price as

select p.ProductName, od.UnitPrice
from Products as p inner join [Order Details] as od
on p.ProductID = od.ProductID
go

/*
Koriste�i pogled view_prod_price dati pregled srednjih vrijednosti cijena proizvoda.
*/

select ProductName, avg(UnitPrice)
from view_prod_price
group by ProductName

/*
Koriste�i tabele Orders i Order Details kreirati pogled view_ord_quan koji �e sadr�avati 
ID uposlenika i vrijednosti koli�ina bez ponavljanja koje je isporu�io pojedini uposlenik.
*/

use NORTHWND
GO

create view view_ord_quan as

select distinct o.EmployeeID, od.Quantity
from Orders as o inner join [Order Details] as od
on od.OrderID = o.OrderID
go

/*
Koriste�i pogled view_ord_quan dati pregled srednjih vrijednosti koli�ina po uposlenicima proizvoda.
*/

select EmployeeID, avg(Quantity) as srednja
from view_ord_quan
group by EmployeeID
order by 2

/*
Koriste�i tabele Categories, Products i Suppliers kreirati tabelu kat_prod_komp koja �e 
sadr�avati polja: CategoryName, ProductName i CompanyName. 
*/

select c.CategoryName, p.ProductName, s.CompanyName
into kat_prod_komp
from Categories as c inner join Products as p
on p.CategoryID = c.CategoryID
inner join Suppliers as s
on s.SupplierID = p.SupplierID

/*
Koriste�i tabele Orders i Customers kreirati pogled view_ord_cust koji �e sadr�avati 
ID uposlenika, Customers.CompanyName i Customers.City.
*/

create view view_ord_cust as

select o.EmployeeID, c.CompanyName, c.City
from Customers as c inner join Orders as o
on o.CustomerID = c.CustomerID
go

/*
Koriste�i pogled view_ord_cust kreirati upit kojim �e se prebrojati sa koliko 
razli�itih kupaca je uposlenik ostvario saradnju.
*/

select EmployeeID, count(CompanyName) as 'Broj kupaca'
from view_ord_cust
group by EmployeeID

/*-------------------------------------------------------------------------------------------------
	11_PROCEDURE
*/

/*
Kreirati tabele UposlenikZDK i UposlenikHNK koje �e formirati pogled view_part_UposlenikKantoni. 
Obje tabele �e sadr�avati polja UposlenikID, NacionalniID, LoginID, RadnoMjesto i Kanton. 
Sva polja su obavezan unos. Tabela UposlenikZDK �e se ozna�iti brojem 1, a tabela UposlenikHNK brojem 2.
*/

use radna
go
create table UposlenikZDK
(
	UposlenikID int not null,
	NacionalniID nvarchar(15) not null,
	LoginID nvarchar(50) not null,
	RadnoMjesto nvarchar(256) not null,
	Kanton SMALLINT NOT NULL CONSTRAINT CK_Kanton_K1 CHECK (Kanton = 1),
	constraint pk_UposlenikZDK primary key (UposlenikID, Kanton)
)
create table UposlenikHNK
(
	UposlenikID int not null,
	NacionalniID nvarchar(15) not null,
	LoginID nvarchar(50) not null,
	RadnoMjesto nvarchar(256) not null,
	Kanton SMALLINT NOT NULL CONSTRAINT CK_Kanton_K2 CHECK (Kanton = 2),
	constraint pk_UposlenikHNK primary key (UposlenikID, Kanton)
)


/*
Kreirati dijeljeni pogled (partitioned view) view_part_UposlenikKantoni koji �e podatke koji se 
unose u njega distribuirati u tabele UposlenikZDK i UposlenikHNK. 
Nakon kreiranja u pogled ubaciti 4 podatka, po dva za svaku od tabela. 
(Tabela UposlenikZDK ima oznaku 1, a UposlenikHNK oznaku 2).
*/

create view view_part_UposlenikKantoni as

select UposlenikID, Kanton, NacionalniID, LoginID, RadnoMjesto
from UposlenikZDK 
union all
select UposlenikID, Kanton, NacionalniID, LoginID, RadnoMjesto
from UposlenikHNK
go

INSERT INTO view_part_UposlenikKantoni 
VALUES(100,1,'zdk1', 'ze1', 'doma�in_zdk1')

INSERT INTO view_part_UposlenikKantoni
VALUES(101,1,'zdk2', 'ze2', 'doma�in_zdk2')

INSERT INTO view_part_UposlenikKantoni
VALUES(10,2,'hnk1', 'mo1', 'doma�in_hnk1')

INSERT INTO view_part_UposlenikKantoni
VALUES(11,2,'hnk2', 'mo2', 'doma�in_hnk2')

/*
Kreirati tabele Kvartal1 i Kvatal2 koje �e formirati pogled view_part_ProdajaKvartali. 
Obje tabele �e sadr�avati polja ProdajaID, NazivKupca, Kvartal. Sva polja su obavezan unos. 
Tabela Kvartal1 �e se ozna�iti brojem 1, a tabela Kvartal2 brojem 2.
Kreirati dijeljeni pogled (partitioned view) view_part_ProdajaKvartali koji �e podatke koji se 
unose u njega distribuirati u tabele Kvartal1 i Kvartal2.
Nakon kreiranja u pogled ubaciti 4 podatka, po dva za svaku od tabela. (Tabela Kvartal1 ima oznaku 1, a Kvartal2 oznaku 2).
*/

create table Kvartal1
(
	ProdajaID int not null,
	NazivKupca nvarchar(50) not null,
	Kvartal smallint constraint ck_Kvartal1 check (Kvartal=1),
	constraint pk_Kvartal1 primary key (ProdajaID, Kvartal)
)
create table Kvartal2
(
	ProdajaID int not null,
	NazivKupca nvarchar(50) not null,
	Kvartal smallint constraint ck_Kvartal2 check (Kvartal=2),
	constraint pk_Kvartal2 primary key (ProdajaID, Kvartal)
)

create view view_part_ProdajaKvartali as

select ProdajaID, NazivKupca, Kvartal
from Kvartal1
union all
select ProdajaID, NazivKupca, Kvartal
from Kvartal2
go

insert into view_part_ProdajaKvartali
values ('110','Kupac1',1)
insert into view_part_ProdajaKvartali
values ('101','Kupac2',1)
insert into view_part_ProdajaKvartali
values ('10','Kupac11',2)
insert into view_part_ProdajaKvartali
values ('11','Kupac23',2)


/*
Kreirati proceduru nad tabelama HumanResources.Employee i Person.Person baze AdventureWorks2014 
kojom �e se dati prikaz polja BusinessEntityID, FirstName i LastName. Proceduru podesiti da se 
rezultati sortiraju po BusinessEntityID.
*/
use AdventureWorks2014
go
create procedure procedura1
as
begin
select he.BusinessEntityID, pp.FirstName, pp.LastName
from HumanResources.Employee as he inner join Person.Person as pp
on he.BusinessEntityID = pp.BusinessEntityID
order by 1 asc
end

execute procedura1
go

/*
Kreirati proceduru nad tabelama HumanResources.Employee i Person.Person kojom �e se definirati 
sljede�i ulazni parametri: EmployeeID, FirstName, LastName, Gender. 
Proceduru kreirati tako da je prilikom izvr�avanja mogu�e unijeti bilo koji broj parametara 
(mo�emo ostaviti bilo koje polje bez unijetog parametra), te da procedura daje rezultat ako je 
zadovoljena bilo koja od vrijednosti koje su navedene kao vrijednosti parametara.
Nakon kreiranja pokrenuti proceduru za sljede�e vrijednosti parametara:
1. EmployeeID = 20, 
2. LastName = Miller
3. LastName = Abercrombie, Gender = M 
*/

create procedure procedura2
(
	@EmployeeID int = null,
	@FirstName nvarchar(40) = null,
	@LastName nvarchar(40) = null,
	@Gender char(1) = null
)
as
begin
select he.BusinessEntityID, pp.FirstName, pp.LastName, he.Gender
from HumanResources.Employee as he inner join Person.Person as pp
on he.BusinessEntityID = pp.BusinessEntityID
where he.BusinessEntityID = @EmployeeID or
	  pp.FirstName = @FirstName or
	  pp.LastName = @LastName or
	  he.Gender = @Gender
end

execute procedura2 @EmployeeID = 20
execute procedura2 @LastName = 'Miller'
execute procedura2 @LastName = 'Abercrombie'
execute procedura2 @Gender = 'M'

/*
Proceduru HumanResources.proc_EmployeesParameters koja je kreirana nad tabelama HumanResources.Employee i 
Person.Person izmijeniti tako da je prilikom izvr�avanja mogu�e unijeti bilo koje vrijednosti 
za prva tri parametra (mo�emo ostaviti bilo koje od tih polja bez unijete vrijednosti), 
a da vrijednost �etvrtog parametra bude F, odnosno, izmijeniti tako da se dobija prikaz samo osoba �enskog pola.
Nakon izmjene pokrenuti proceduru za sljede�e vrijednosti parametara:
1. EmployeeID = 52, 
2. LastName = Miller
*/

alter procedure procedura2
(
	@EmployeeID int = null,
	@FirstName nvarchar(40) = null,
	@LastName nvarchar(40) = null,
	@Gender char(1) = 'F'
)
as
begin
select he.BusinessEntityID, pp.FirstName, pp.LastName, he.Gender
from HumanResources.Employee as he inner join Person.Person as pp
on he.BusinessEntityID = pp.BusinessEntityID
where he.BusinessEntityID = @EmployeeID or
	  pp.FirstName = @FirstName or
	  pp.LastName = @LastName or
	  he.Gender = @Gender
end

execute procedura2 @EmployeeID = 52
execute procedura2 @LastName = 'Miller'


/*
Koriste�i tabele Sales.SalesOrderHeader i Sales.SalesOrderDetail kreirati pogled view_promet 
koji �e se sastojati od kolona CustomerID, SalesOrderID, ProductID i proizvoda OrderQty i UnitPrice. 
*/
use AdventureWorks2014
go

create view view_promet
as
select soh.CustomerID, soh.SalesOrderID, sod.ProductID, sod.OrderQty*sod.UnitPrice as Proizvod
from Sales.SalesOrderHeader as soh inner join Sales.SalesOrderDetail as sod
on soh.SalesOrderID = sod.SalesOrderID



/*
Koriste�i pogled view_promet kreirati pogled view_promet_cust_ord koji ne�e sadr�avati 
kolonu ProductID i vr�it �e sumiranje kolone ukupno.
*/

/*
Nad pogledom view_promet_cust_ord kreirati proceduru kojom �e se definirati 
ulazni parametri: CustomerID, SalesOrderID i suma.
Proceduru kreirati tako da je prilikom izvr�avanja mogu�e unijeti bilo koji broj parametara 
(mo�emo ostaviti bilo koje polje bez unijetog parametra), te da procedura daje rezultat 
ako je zadovoljena bilo koja od vrijednosti koje su navedene kao vrijednosti parametara.
Nakon kreiranja pokrenuti proceduru za vrijednost parametara CustomerID = 11019.
Obrisati proceduru, a zatim postaviti uslov da procedura vra�a samo one zapise u kojima je 
suma manje od 100, pa ponovo pokrenuti za istu vrijednost parametra.
*/

alter procedure procedura3
(
	@CustomerID int = null,
	@SalesOrderID int = null,
	@suma money = null
)
as
begin
select CustomerID, SalesOrderID, suma
from view_promet_cust_ord
where (CustomerID = @CustomerID or
	  SalesOrderID = @SalesOrderID or
	  suma = @suma) and suma<100
end

execute procedura3 @CustomerID = 11019

/*-------------------------------------------------------------------------------------------------
	11_PROCEDURE_OKIDACI
*/

/*
Kreirati proceduru Narudzba nad tabelama Customers, Products, Order Details i Order baze 
Northwind kojom �e se definirati sljede�i ulazni parametri: ContactName, ProductName, UnitPrice, 
Quantity i Discount. Proceduru kreirati tako da je prilikom izvr�avanja mogu�e unijeti bilo koji 
broj parametara (mo�emo ostaviti bilo koji parametar bez unijete vrijednosti), 
te da procedura daje rezultat ako je unijeta vrijednost bilo kojeg parametra.
Nakon kreiranja pokrenuti proceduru za sljede�e vrijednosti parametara:
1. ContactName = Mario Pontes
2. Quantity = 10 ili Discount = 0.15
3. UnitPrice = 20
*/
use NORTHWND
go

create procedure narudzba
(	@ContactName nvarchar(100) = null,
	@ProductName nvarchar(150) = null,
	@UnitPrice money = null,
	@Quantity smallint = null,
	@Discount real = null
)
	
as	
begin 
select c.ContactName, p.ProductName, od.UnitPrice, od.Quantity, od.Discount
from Customers as c inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
inner join Products as p
on p.ProductID = od.ProductID
where c.ContactName = @ContactName or
	  p.ProductName = @ProductName or
	  od.UnitPrice = @UnitPrice or 
	  od.Quantity = @Quantity or
	  od.Discount = @Discount
end

execute narudzba @ContactName = 'Mario Pontes'
execute narudzba @Quantity = 10, @Discount = 0.15
execute narudzba @UnitPrice = 20

/*
Kreirati proceduru nad tabelama Production.Product, Production.ProductSubcategory, 
Production.ProductListPriceHistory, Purchasing.ProductVendor kojom �e se definirati parametri: 
p_name za naziv proizvoda, Color, ps_name za naziv potkategorije, ListPrice sa zaokru�ivanjem 
na dvije decimale, AverageLeadTime, MinOrderQty, MaxOrderQty i Razlika kao razliku maksimalne 
i minimalne naru�ene koli�ine. Dati odgovaraju�e nazive. Proceduru kreirati tako da je prilikom 
izvr�avanja mogu�e unijeti bilo koji broj parametara 
(mo�emo ostaviti bilo koje parametar bez unijete vrijednosti), te da procedura daje rezultat 
ako je unijeta vrijednost bilo kojeg parametra. Zapisi u proceduri trebaju biti sortirani 
po vrijednostima parametra ListPrice.
Nakon kreiranja pokrenuti proceduru za sljede�e vrijednosti parametara:
1. MaxOrderQty = 1000
2. Razlika = 350
3. Color = Red i naziv potkategorije = Helmets
*/
use AdventureWorks2014 
go
alter procedure awprocedura
(
	@p_name nvarchar(50) = null,
	@Color nvarchar(15) = null,
	@ps_name nvarchar(50) = null,
	@ListPrice money = null,
	@AverageLeadTime int = null,
	@MinOrderQty int = null,
	@MaxOrderQty int = null,
	@Razlika int = null
)
as
begin
select p.Name, p.Color, ps.Name, p.ListPrice, pv.AverageLeadTime, pv.MinOrderQty,
	   pv.MaxOrderQty, pv.MaxOrderQty - pv.MinOrderQty as Razlika
from Production.ProductSubcategory as ps inner join Production.Product as p
on ps.ProductSubcategoryID = p.ProductSubcategoryID
inner join Production.ProductListPriceHistory as plph
on plph.ProductID = p.ProductID
inner join Purchasing.ProductVendor as pv
on pv.ProductID = p.ProductID
where p.Name = @p_name or 
	  p.Color = @Color or  
	  ps.Name = @ps_name or 
	  p.ListPrice = @ListPrice or 
	  pv.AverageLeadTime = @AverageLeadTime or 
	  pv.MinOrderQty = @MinOrderQty or 
	  pv.MaxOrderQty = @MaxOrderQty or
	  pv.MaxOrderQty - pv.MinOrderQty = @Razlika
order by 4 asc
end



execute awprocedura @MaxOrderQty = 1000 --63
execute awprocedura @Razlika = 350 --4
execute awprocedura @Color = 'Red', @ps_name = 'Helmets' --9

/*
Izvr�iti izmjenu kreirane procedure tako da proslje�uje samo one zapise u kojima je razlika ve�a od 500.
Nakon kreiranja pokrenuti proceduru bez postavljanja vrijednosti za bilo koji parametar, 
a zatim za sljede�e vrijednosti parametara:
1. MinOrderQty = 100 
2. Color = Red
3. ps_name= Helmets
*/

alter procedure awprocedura
(
	@p_name nvarchar(50) = null,
	@Color nvarchar(15) = null,
	@ps_name nvarchar(50) = null,
	@ListPrice money = null,
	@AverageLeadTime int = null,
	@MinOrderQty int = null,
	@MaxOrderQty int = null,
	@Razlika int = null
)
as
begin
select p.Name, p.Color, ps.Name, p.ListPrice, pv.AverageLeadTime, pv.MinOrderQty,
	   pv.MaxOrderQty, pv.MaxOrderQty - pv.MinOrderQty as Razlika
from Production.ProductSubcategory as ps inner join Production.Product as p
on ps.ProductSubcategoryID = p.ProductSubcategoryID
inner join Production.ProductListPriceHistory as plph
on plph.ProductID = p.ProductID
inner join Purchasing.ProductVendor as pv
on pv.ProductID = p.ProductID
where (p.Name = @p_name or 
	  p.Color = @Color or  
	  ps.Name = @ps_name or 
	  p.ListPrice = @ListPrice or 
	  pv.AverageLeadTime = @AverageLeadTime or 
	  pv.MinOrderQty = @MinOrderQty or 
	  pv.MaxOrderQty = @MaxOrderQty or
	  pv.MaxOrderQty - pv.MinOrderQty = @Razlika) and
	  pv.MaxOrderQty - pv.MinOrderQty > 500
order by 4 asc
end



execute awprocedura @MinOrderQty = 100 --63
execute awprocedura @Color = 'Red' --0
execute awprocedura @ps_name = 'Helmets' --3


/*
Koriste�i tabelu Sales.Customer kreirati proceduru proc_account_number kojom �e se definirati 
parametar br_cif_account za pregled broja zapisa po broju cifara u koloni AccountNumber. 
Proceduru kreirati tako da je prilikom izvr�avanja mogu�e unijeti bilo koji broj parametara 
(mo�emo ostaviti bilo koje parametar bez unijete vrijednosti), te da procedura daje rezultat 
ako je unijeta vrijednost bilo kojeg parametra. Procedura treba da vrati broj cifara (1-, 2- cifreni) 
i ukupan broj zapisa po cifrenosti.
Nakon kreiranja zasebno pokrenuti proceduru za 1-, 2-, 3- i 5-cifrene brojeve.
*/


create view pomocniview as

select len(cast(substring(AccountNumber, charindex('W', AccountNumber)+1, 8) as int)) as cifre, count(*) as broji
from Sales.Customer
group by len(cast(substring(AccountNumber, charindex('W', AccountNumber)+1, 8) as int))
go


create procedure proc_account_number
(
	@br_cif_account varchar(10) = null
)
as
begin
select *
from pomocniview
where cifre = @br_cif_account
end

execute proc_account_number @br_cif_account = 5

/*
U bazi radna kreirati tabele ocjena (student_id int, predmet_id int i ocjena int) i 
ocjena_logovi (student_id, predmet_id, datum_pristupa datetime i opis char (15)).
*/

use radna
go

create table ocjena 
(
	student_id int,
	predmet_id int,
	ocjena int,
	--constraint pk_ocjena primary key (student_id, predmet_id)
)
create table ocjena_logovi
(
	student_id int,
	predmet_id int,
	datum_pristupa date,
	opis char(15)
	--constraint pk_ocjena primary key (student_id, predmet_id)
)
/*
Nad tabelom ocjena kreirati okida� ins_del_ocjena kojim �e se evidentirati datum i 
vrijeme izvr�enja insert, odnosno, delete akcije, te opis izvedene akcije.
*/

create trigger ins_del_ocjena
on ocjena
after insert, delete
as
begin
select i.student_id, i.predmet_id, getdate(), 'insert'
from inserted as i
union all
select d.student_id, d.predmet_id, GETDATE (), 'delete'
from	deleted as d
end

/*
Nad tabelom ocjena kreirati okida� update_ocjena kojim �e se evidentirati datum i 
vrijeme izvr�enja update akcije, te opis izvedene akcije.
*/

create trigger update_ocjena
on ocjena
for update 
as
begin
select u.student_id, u.predmet_id, getdate(), 'update'
from inserted as u
end

/*
U tabelu ocjena unijeti 5 zapisa. 
Iz tabele izbrisati zapis predmet_id = 11 i student_id = 1
*/

insert into ocjena
values ('1', '10', '9'),
	   ('2', '11', '6'),
	   ('3', '12', '5'),
	   ('4', '13', '10'),
	   ('5', '14', '8')

select * 
from ocjena

delete ocjena
where predmet_id = 11 and student_id = 1

/*
Izvr�iti update tabele ocjena tako �to �e se predmet_id = 10 postaviti na 20.
*/

update ocjena
set predmet_id=20
where predmet_id=10

/*-----------------------------------------------------------------------------------------------
	12_PROCEDURE_OKIDACI
*/

/*
U bazu radna iz baze AdventureWorks2014 �eme Production prekopirati tabele Product, 
WorkOrder i WorkOrderRouting. Zadr�ati iste nazive tabela. Tabele smjestiti u defaultnu �emu.
*/

create schema defaultna 

select * 
into defaultna.WorkOrderRouting
from AdventureWorks2014.Production.WorkOrderRouting

select * 
into defaultna.Product
from AdventureWorks2014.Production.Product

select *
into defaultna.WorkOrder
from AdventureWorks2014.Production.WorkOrder

/*
U kopiranim tabelama u bazi radna postaviti iste PK i potrebne FK kako bi se ostvarila veza izme�u tabela.
*/
alter authorization on database :: [radna] to sa

alter table defaultna.Product
add constraint pk_Product primary key (ProductID)

alter table defaultna.WorkOrder
add constraint pk_WorkOrder primary key (WorkOrderID)

alter table defaultna.WorkOrder
add constraint fk_WorkOrder_Product foreign key (ProductID) references defaultna.Product (ProductID)

alter table defaultna.WorkOrderRouting
add constraint pk_WorkOrderRouting_WorkOrder_Product primary key (WorkOrderID, ProductID, OperationSequence)

alter table defaultna.WorkOrderRouting
add constraint fk_WorkOrderRouting_WorkOrder foreign key (WorkOrderID) references defaultna.WorkOrder(WorkOrderID)

/*
a) U tabeli Product kreirati ograni�enje nad kolonom ListPrice kojim �e biti onemogu�en unos negativnog podatka.
b) U tabeli WorkOrder kreirati ograni�enje nad kolonom EndDate kojim �e se onemogu�iti unos podatka manjeg od StartDate.
*/

alter table defaultna.Product
add constraint ck_ListPrice check (ListPrice>=0)

alter table defaultna.WorkOrder
add constraint ck_EndDate check (EndDate>=StartDate)



/*
Kreirati proceduru koja �e izmijeniti podatke u koloni LocationID tabele WorkOrderRouting po sljede�em principu:
	10 -> A
	20 -> B
	30 -> C
	40 -> D
	45 -> E
	50 -> F
	60 -> G
*/

alter table defaultna.WorkOrderRouting
alter column LocationID char(2)

create procedure defizm
as
begin
update defaultna.WorkOrderRouting
set LocationID='A'
where LocationID = 10
update defaultna.WorkOrderRouting
set LocationID='B'
where LocationID = 20
update defaultna.WorkOrderRouting
set LocationID='C'
where LocationID = 30
update defaultna.WorkOrderRouting
set LocationID='D'
where LocationID = 40
update defaultna.WorkOrderRouting
set LocationID='E'
where LocationID = 50
update defaultna.WorkOrderRouting
set LocationID='F'
where LocationID = 60
end

execute defizm 

/*
Obrisati ograni�enje kojim se definisala veza izme�u tabela Product i WorkOrder.
*/

alter table defaultna.WorkOrder
drop constraint fk_WorkOrder_Product 

/*
Podaci u koloni ProductNumber imaju formu AB-1234. Neka slova ozna�avaju klasu podatka. 
Dati informaciju koliko razli�itih klasa postoji.
*/

select count(distinct left(ProductNumber,2)) as 'Razlicitih klasa'
from defaultna.Product


/*
a) U tabeli Product kreirati kolonu klasa u koju �e se smje�tati klase kolone ProductNumber 
pri �emu u kolonu ne�e biti mogu�e pohraniti vi�e od dva znaka.
b) Novoformiranu kolonu popuniti klasama iz kolone ProductNumber
*/

alter table defaultna.Product
add klasa char(2)

alter table defaultna.Product
add constraint ck_klasa check (len(klasa)<=2)

update defaultna.Product
set klasa = left(ProductNumber,2)

select klasa
from defaultna.Product

/*
Kreirati tabelu Cost u kojoj �e biti kolone WorkOrderID i PlannedCost tabele WorkOrderRouting. 
Nakon toga dodati izra�unatu (stalno pohranjenu) kolonu fening u kojoj �e biti vrijednost 
feninga iz kolone PlannedCost. Vrijednost feninga mora biti izra�ena kao cijeli broj (ne prihvata se oblik 0.20).
*/
use radna
go


select WorkOrderID, PlannedCost
into Cost
from AdventureWorks2014.Production.WorkOrderRouting

alter table Cost
add fening int 

alter table Cost
add constraint ck_fening check (fening=PlannedCost)

select * 
from Cost
/*
U tabeli Cost dodati novu kolonu klasa u kojoj �e biti oznaka 1 ako je vrijednost 
feninga manja od 50, odnosno, 2 ako je vrijednost feninga ve�a ili jednaka od 50.
*/

alter table Cost
add klasa int

create procedure procklasa
as
begin
update Cost
set klasa=1
where fening<50
update Cost
set klasa=2
where fening>=50
end
go

execute procklasa


/*
U tabeli Product se nalazi kolona ProductLine. Prebrojati broj pojavljivanja svake od 
vrijednosti iz ove kolone, a zatim dati informaciju koliko je klasa �iji je broj pojavljivanja 
manji, a koliko ve�i od srednje vrijednosti broja pojavljivanja.
*/

create view viewprebroj
as
select ProductLine, count(*) as 'ukupno'
from defaultna.Product
group by ProductLine
go

select 'manje', count(*)
from viewprebroj
where ukupno < (select avg(ukupno) from viewprebroj)
union 
select 've�e', count(*)
from viewprebroj
where ukupno > (select avg(ukupno) from viewprebroj)


/*
Napomena:
Na neki na�in sam prilikom pripreme imao situaciju da nad ProductID nije bio 
identity i mogao sam kreirati proceduru. S obzirom da se identity mo�e 
"otkloniti" samo kreiranjem nove kolone i insertom podataka u nju, zadatak 
je promijenjen na kolonu ReorderPoint.
*/


/*
Kreirati proceduru kojom �e se u tabeli Product za ReorderPoint koji su manji od 
100 izvr�iti uve�anje za unijetu vrijednost parametra povecanje.
*/

alter procedure procrp
(
	@povecanje smallint = null
)
as
begin
update defaultna.Product
set ReorderPoint = ReorderPoint + @povecanje 
where ReorderPoint < 100
end

execute procrp @povecanje = 30

select ReorderPoint
from defaultna.Product

/*
Kreirati proceduru kojom �e se u tabeli Product vr�iti brisanje zapisa prema unijetoj vrijednosti ProductSubcategoryID.
*/

alter procedure brisanjezap
(
	@brisanje int
)
as
begin
delete from defaultna.Product
where ProductSubcategoryID=@brisanje
end 

execute brisanjezap 1

/*
Kreirati proceduru kojom �e se u tabeli Product vr�iti izmjena postoje�eg u 
proizvoljni naziv boje. Npr. Black preimenovati u crna.
*/

alter procedure izmjenaboje
(
	@Color nvarchar(15) = null,
	@boja nvarchar(15) = null
)
as
begin
update defaultna.Product
set Color = @boja
where Color = @Color
end

execute izmjenaboje 'Black', 'Crna'

select Color
from defaultna.Product


/*-------------------------------------------------------------------------------------------------
	14_PRIMJERISPITA
*/

/*
a) Kreirati bazu podataka pod vlastitim brojem indeksa.
*/

create database muhamed16
go

use muhamed16
go
/*
Prilikom kreiranja tabela voditi ra�una o me�usobnom odnosu izme�u tabela.
b) Kreirati tabelu radnik koja �e imati sljede�u strukturu:
	radnikID, cjelobrojna varijabla, primarni klju�
	drzavaID, 15 unicode karaktera
	loginID, 30 unicode karaktera
	sati_god_odmora, cjelobrojna varijabla
	sati_bolovanja, cjelobrojna varijabla
*/

create table radnik
(
	radnikID int,
	drzavaID nvarchar(15),
	loginID nvarchar(30),
	sati_god_odmora int,
	sati_bolovanja int,
	constraint pk_radnik primary key (radnikID)
)


/*
c) Kreirati tabelu kupovina koja �e imati sljede�u strukturu:
	kupovinaID, cjelobrojna varijabla, primarni klju�
	status, cjelobrojna varijabla
	radnikID, cjelobrojna varijabla
	br_racuna, 15 unicode karaktera
	naziv_dobavljaca, 50 unicode karaktera
	kred_rejting, cjelobrojna varijabla
*/

create table kupovina
(
	kupovinaID int,
	status int,
	radnikID int,
	br_racuna nvarchar(15),
	naziv_dobavljaca nvarchar(50),
	kred_rejting int,
	constraint pk_kupovina primary key(kupovinaID),
	constraint fk_kupovina_radnik foreign key(radnikID) references radnik (radnikID)
)

/*
d) Kreirati tabelu prodaja koja �e imati sljede�u strukturu:
	prodavacID, cjelobrojna varijabla, primarni klju�
	prod_kvota, nov�ana varijabla
	bonus, nov�ana varijabla
	proslogod_prodaja, nov�ana varijabla
	naziv_terit, 50 unicode karaktera
*/

create table prodaja
(
	prodavacID int,
	prod_kvota money,
	bonus money,
	proslogod_prodaja money,
	naziv_terit nvarchar(50),
	constraint pk_prodaja primary key(prodavacID),
	constraint fk_prodaja_radnik foreign key (prodavacID) references radnik (radnikID)
)

--2. Import podataka
/*
a) Iz tabela humanresources.employee baze AdventureWorks2014 u tabelu radnik importovati podatke po sljede�em pravilu:
	BusinessEntityID -> radnikID
	NationalIDNumber -> drzavaID
	LoginID -> loginID
	VacationHours -> sati_god_odmora
	SickLeaveHours -> sati_bolovanja
*/

insert into radnik
(radnikID, drzavaID, loginID, sati_god_odmora, sati_bolovanja)
select BusinessEntityID, NationalIDNumber, LoginID, VacationHours, SickLeaveHours
from AdventureWorks2014.HumanResources.Employee

/*
b) Iz tabela purchasing.purchaseorderheader i purchasing.vendor baze AdventureWorks2014 u tabelu kupovina 
importovati podatke po sljede�em pravilu:
	PurchaseOrderID -> kupovinaID
	Status -> status
	EmployeeID -> radnikID
	AccountNumber -> br_racuna
	Name -> naziv_dobavljaca
	CreditRating -> kred_rejting
*/

insert into kupovina
(kupovinaID, status, radnikID, br_racuna, naziv_dobavljaca, kred_rejting)
select ppo.PurchaseOrderID, ppo.Status, ppo.EmployeeID, pv.AccountNumber, pv.Name, pv.CreditRating
from AdventureWorks2014.Purchasing.PurchaseOrderHeader as ppo inner join AdventureWorks2014.Purchasing.Vendor as pv
on ppo.VendorID = pv.BusinessEntityID

/*
c) Iz tabela sales.salesperson i sales.salesterritory baze AdventureWorks2014 u tabelu prodaja importovati 
podatke po sljede�em pravilu:
	BusinessEntityID -> prodavacID
	SalesQuota -> prod_kvota
	Bonus -> bonus
	SalesLastYear -> proslogod_prodaja
	Name -> naziv_terit
*/
--napomena:
--SalesLastYear se uzima iz tabele SalesTerritory

insert into prodaja
(prodavacID, prod_kvota, bonus, proslogod_prodaja, naziv_terit)
select ssp.BusinessEntityID, ssp.SalesQuota, ssp.Bonus, sst.SalesLastYear, sst.Name
from AdventureWorks2014.Sales.SalesPerson as ssp inner join AdventureWorks2014.Sales.SalesTerritory as sst
on ssp.TerritoryID = sst.TerritoryID

--3.
/*
Iz tabela radnik i kupovina kreirati pogled view_drzavaID koji �e imati sljede�u strukturu: 
	- naziv dobavlja�a,
	- drzavaID
Uslov je da u pogledu budu samo oni zapisi �iji ID dr�ave po�inje ciframa u rasponu od 40 do 49, 
te da se kombinacije dobavlja�a i drzaveID ne ponavljaju.
*/

alter view view_drzavaID
as
select k.naziv_dobavljaca,r.drzavaID
from kupovina as k inner join radnik as r
on k.radnikID = r.radnikID
where left(r.drzavaID, 2) between 40 and 49


select*
from view_drzavaID

--4.
/*
Koriste�i tabele radnik i prodaja kreirati pogled view_klase_prihoda koji �e sadr�avati ID radnika, 
ID dr�ave, koli�nik pro�logodi�nje prodaje i prodajne kvote, te oznaku klase koje �e biti formirane prema pravilu: 
	- <10			- klasa 1 
	- >=10 i <20	- klasa 2 
	- >=20 i <30	- klasa 3
*/

create view view_klase_prihoda
as
select r.radnikID, r.drzavaID, p.proslogod_prodaja/p.prod_kvota as kolicnik, 1 as klasa 
from radnik as r inner join prodaja as p
on r.radnikID = p.prodavacID
where p.proslogod_prodaja/p.prod_kvota < 10
union
select r.radnikID, r.drzavaID, p.proslogod_prodaja/p.prod_kvota as kolicnik, 2 as klasa 
from radnik as r inner join prodaja as p
on r.radnikID = p.prodavacID
where p.proslogod_prodaja/p.prod_kvota >= 10 and p.proslogod_prodaja/p.prod_kvota<20
union
select r.radnikID, r.drzavaID, p.proslogod_prodaja/p.prod_kvota as kolicnik, 3 as klasa
from radnik as r inner join prodaja as p
on r.radnikID = p.prodavacID
where p.proslogod_prodaja/p.prod_kvota >= 20 and p.proslogod_prodaja/p.prod_kvota<30

select*
from view_klase_prihoda

--5.
/*
Koriste�i pogled view_klase_prihoda kreirati proceduru proc_klase_prihoda koja �e prebrojati broj klasa. 
Procedura treba da sadr�i naziv klase i ukupan broj pojavljivanja u pogledu view_klase_prihoda.
Sortirati prema broju pojavljivanja u opadaju�em redoslijedu.
*/

create procedure proc_klase_prihoda
as
begin
select klasa, count(klasa)
from view_klase_prihoda
group by klasa
order by 2 desc
end

execute proc_klase_prihoda

--6.
/*
Koriste�i tabele radnik i kupovina kreirati pogled view_kred_rejting koji �e sadr�avati kolone drzavaID, 
kreditni rejting i prebrojani broj pojavljivanja kreditnog rejtinga po ID dr�ave.
*/

create view view_kred_rejting
as
select r.drzavaID, k.kred_rejting, count(k.kred_rejting) as prebrojano
from radnik as r inner join kupovina as k
on r.radnikID = k.radnikID
group by r.drzavaID, k.kred_rejting

select *
from view_kred_rejting

--7.
/*
Koriste�i pogled view_kred_rejting kreirati proceduru proc_kred_rejting koja �e davati informaciju o 
najve�em prebrojanom broju pojavljivanja kreditnog rejtinga. Procedura treba da sadr�i oznaku 
kreditnog rejtinga i najve�i broj pojavljivanja za taj kreditni rejting. Proceduru pokrenuti 
za sve kreditne rejtinge (1, 2, 3, 4, 5). 
*/

create procedure proc_kred_rejting
(
	@kredrejting int = null
)
as
begin
select kred_rejting, max(prebrojano)
from view_kred_rejting
where kred_rejting = @kredrejting
group by kred_rejting
end

execute proc_kred_rejting 2
--8.
/*
Kreirati tabelu radnik_nova i u nju prebaciti sve zapise iz tabele radnik. Nakon toga, 
svim radnicima u tabeli radnik_nova �ije se ime u koloni loginID sastoji od 3 i manje slova, 
loginID promijeniti u slu�ajno generisani niz znakova.
*/

select *
into radnik_nova
from radnik

select loginID
from radnik_nova
where loginID not like 'adventure%'

update radnik_nova
set loginID = left(newid(), 30)
where len(loginID) - 1 - charindex ('\', loginID) <=3


--9
/*
a) Kreirati pogled view_sume koji �e sadr�avati sumu sati godi�njeg odmora i sumu sati bolovanja 
za radnike iz tabele radnik_nova kojima je loginID promijenjen u slu�ajno generisani niz znakova 
*/

alter view view_sume
as
select sum(sati_god_odmora) as sumagod, sum(sati_bolovanja) as sumabol
from radnik_nova
where loginID not like 'adventure%'
group by loginID


select sumagod, sumabol
from view_sume

/*
b) Izra�unati odnos (koli�nik) sume bolovanja i sume godi�njeg odmora. Ako je odnos ve�i od 0.5 
dati poruku 'Suma bolovanja je prevelika. Odnos iznosi: ______'. U suprotnom dati poruku 
'Odnos je prihvaljiv i iznosi: _____'
*/
select cast(1263 as real)/cast (1387 as real)


alter view view_provjera
as
select  cast(cast(sumabol as real)/cast(sumagod as int) as nvarchar) as odnos
from view_sume


select 'Suma bolovanja je prevelika. Odnos iznosi ' + odnos  as Poruka
from view_provjera
where odnos > 0.5
union

select 'Odnos je prihvatljiv i iznosi ' + odnos as Poruka
from view_provjera
where odnos <=0.5


--10.
/*
a) Kreirati backup baze na default lokaciju.
b) Obrisati bazu.
c) Napraviti restore baze.
*/

backup database muhamed16
to disk = 'muhamed16.bak'

use master

alter database muhamed16
set offline

drop database muhamed16	

restore database muhamed16
from disk = 'muhamed16.bak'
with replace

use AdventureWorks2014

/*
Koriste�i kolonu AccountNumber tabele Sales.Customer prebrojati broj zapisa prema broju cifara 
broj�anog dijela podatka iz ove kolone. Rezultat sortirati u rastu�em redoslijedu.
*/

use AdventureWorks2014

select AccountNumber
from Sales.Customer

select len(cast(substring(AccountNumber, 3, len(AccountNumber)-charindex('AW', AccountNumber)) as int)) as 'Broj cifara',
	    count(*)
from Sales.Customer
group by len(cast(substring(AccountNumber, 3, len(AccountNumber)-charindex('AW', AccountNumber)) as int))
order by 1 asc
	
select charindex('A', AccountNumber)
from Sales.Customer