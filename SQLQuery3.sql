--1. Mü?yy?n Publisher t?r?find?n çap olunmu? minimum
--s?hif?li kitablar?n siyah?s?n? ç?xaran funksiya yaz?nCREATE FUNCTION dbo.GetPublisherofMinPagesBook(@id int)RETURNS TABLEASRETURN(SELECT *FROM BooksWHERE Pages = (SELECT MIN(Pages)               FROM BOOKS			   WHERE Books.Id_Press=@id))SELECT *FROM dbo.GetPublisherofMinPagesBook(2)--2. Orta s?hif? say? N-d?n çox s?hif? li kitab çap ed?n
--Publisherl?rin ad?n? qaytaran funksiya yaz?n. N
--parameter olaraq gönd?rilir.CREATE FUNCTION dbo.AvgCountPagesOfPress(@N int)RETURNS TABLEASRETURN(SELECT Press.NameFROM Press Join Books on Press.Id=Books.Id_PressGROUP BY Press.NameHAVING AVG(Books.Pages)>@N)--3. Mü?yy?n Publisher t?r?find?n çap edilmi? bütün kitab
--s?hif?l?rinin c?mini tapan v? qaytaran funksiya yaz?n.
CREATE FUNCTION dbo.GetSumofPagesBYPublisher(@id INT)
RETURNS TABLE 
AS
RETURN
(
SELECT SUM(Books.Pages) AS TotalPages
FROM Books 
WHERE Books.Id_Press=@id

)


--4. Mü?yy?n iki tarix aral???nda kitab götürmü?
--Studentl?rin ad v? soyad?n? list ??klind? qaytaran
--funksiya yaz?n.CREATE FUNCTION dbo.GetBetweenTwoDateofStudent(@Date1 Date ,@Date2 Date)RETURNS TABLEASRETURN(SELECT Students.FirstName,Students.LastNameFROM S_Cards JOIN Students ON S_Cards.Id_Student=Students.IdWhere S_Cards.DateOut Between @Date1 AND @Date2)--5. Mü?yy?n kitabla hal haz?rda i?l?y?n bütün t?l?b?l?rin
--siyah?s?n? qaytaran funksiya yaz?n.CREATE FUNCTION dbo.GetBookForStudents(@Id int)RETURNS TABLEASRETURN(SELECT *FROM S_Cards WHERE S_Cards.Id_Book=@Id AND S_Cards.DateIn is NULL)--6. Çap etdiyi bütün s?hif? c?mi N-d?n böyük olan
--Publisherl?r haqq?nda informasiya qaytaran funksiya
--yaz?n.CREATE FUNCTION dbo.SumCountPagesOfPress(@N int)RETURNS TABLEASRETURN(SELECT Press.Id, Press.NameFROM Press Join Books on Press.Id=Books.Id_PressGROUP BY Press.Id,Press.NameHAVING SUM(Books.Pages)>@N)--7.Studentl?r aras?nda ?n popular avtor v? onun
--götürülmü? kitablar?n?n say? haqq?nda informasiya ver?n
--funksiya yaz?nCREATE FUNCTION dbo.AuthorAndItsBooks()RETURNS TABLEASRETURN(Select Authors.FirstName AS PopularAuthor, Count(Distinct Books.Name) AS CountofBooksFrom Authors Join Books on Books.Id_Author=Authors.IdWhere Authors.Id=(Select TOP 1 Id_Author                  FROM Books				  GROUP BY Id_Author				  ORDER BY COUNT(Id_Author) DESC				  )GROUP BY Authors.FirstName)--8.Studentl?r v? Teacherl?r (h?r ikisi) t?r?find?n
--götürülmü? (ortaq - h?m onlar h?m bunlar) kitablar?n
--listini qaytaran funksiya yaz?n.CREATE FUNCTION dbo.GetBothtookBook()RETURNS TABLEASRETURN(Select Distinct Books.NameFROM Books JOIN S_Cards ON Books.Id=S_Cards.Id_Book           JOIN T_Cards ON Books.Id=T_Cards.Id_Book)--9. Kitab götürm?y?n t?l?b?l?rin say?n? qaytaran funksiya
--yaz?nCREATE FUNCTION dbo.GetNoBooksOfStudents()RETURNS INTASBEGIN  declare @count int ; SET  @count = (SELECT  Count(Students.Id)    FROM Students LEFT JOIN S_Cards ON Students.Id=S_Cards.Id_Student    WHERE S_Cards.Id IS NULL)  return @count;END--10.Kitabxanaç?lar v? onlar?n verdiyi kitablar?n say?n?
--qaytaran funksiya yaz?n.
CREATE FUNCTION dbo.GetLibAndTookBook()
RETURNS TABLE
AS
RETURN
(
SELECT Libs.FirstName,COUNT(Distinct T_Cards.Id)+COUNT(Distinct S_Cards.Id) AS TotalCount
FROM Libs 
LEFT JOIN T_Cards ON Libs.Id = T_Cards.Id_Lib
LEFT JOIN S_Cards ON Libs.Id = S_Cards.Id_Lib
GROUP BY 
Libs.FirstName
)











    




