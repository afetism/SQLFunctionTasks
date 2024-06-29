--1. M�?yy?n Publisher t?r?find?n �ap olunmu? minimum
--s?hif?li kitablar?n siyah?s?n? �?xaran funksiya yaz?n
--Publisherl?rin ad?n? qaytaran funksiya yaz?n. N
--parameter olaraq g�nd?rilir.
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


--4. M�?yy?n iki tarix aral???nda kitab g�t�rm�?
--Studentl?rin ad v? soyad?n? list ??klind? qaytaran
--funksiya yaz?n.
--siyah?s?n? qaytaran funksiya yaz?n.
--Publisherl?r haqq?nda informasiya qaytaran funksiya
--yaz?n.
--g�t�r�lm�? kitablar?n?n say? haqq?nda informasiya ver?n
--funksiya yaz?n
--g�t�r�lm�? (ortaq - h?m onlar h?m bunlar) kitablar?n
--listini qaytaran funksiya yaz?n.
--yaz?n
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











    




