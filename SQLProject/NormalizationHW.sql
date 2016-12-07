--14.4 Describe the concept of functional dependency.
--Ans: the concept is to descrie the relationship between attributes in a relation

--14.10 The second normal form (2NF) is realized by removing partial dependencies from 1NF relations. Briefly describe
--the term “partial dependency.”
/*Ans: the partial dependency means some of the attribute dependent on the non-primary-key.
		for example: Teaching(teacherId(pk), CourseId(pk), courseName)		
		CourseId -> courseName 
		the CourseId -> courseName is depend on the subset of the primary key, so it's partial dependency
		to bring this table into 2nd normal form, we break the table into two tables, and now we have the following tables
		Teachering(teacherId(pk),CourseId(pk))
		Course(CourseId(pk),courseName)
note: a table that is in a 1NF and contains only a single primary key is automatically in 2nd normal form
*/

/*14.11 Describe the concept of transitive dependency and describe how this concept relates to 3NF. Provide an example
to illustrate your answer.
By transitive functional dependency, we mean we have the following relationships in the table: A is
functionally dependent on B, and B is functionally dependent on C. in this case, C is transitively dependent on A via B
B -> A
C -> B
C -> B -> A
TO bring a 2NF to 3 NF, we need to elimate the transitive functional dependency in the table.
EG: Book_Detail(BookId(pk),GenreId, Genre Type, Price)
in the table, [BookId] determines [GenreId], and [GenreId] determines [Genre Type], therefore [BookId] determines [Genre TYpe] via [GenreId]
and we have transitive functional dependency, and this structure does not satisfy third normal form
TO bring this table into 3rd normal form, we split the table into two as follows:
Book(BookId(pk), GenreId, Price)
Genre(GenreId(pk), Genre Type)
*/

/*
14.14 Examine the Patient Medication Form for the Wellmeadows Hospital case study (see Appendix B) shown in
Figure 14.18.
(a) Identify the functional dependencies represented by the attributes shown in the form in Figure 14.18. State
any assumptions that you make about the data and the attributes shown in this form.
(b) Describe and illustrate the process of normalizing the attributes shown in Figure 14.18 to produce a set of
well-designed 3NF relations.
(c) Identify the primary, alternate, and foreign keys in your 3NF relations.
Ans:
(a): Patient Number -> Full name, Ward number, Bed Number, Ward Name
	 Ward Number -> Ward Name
	 Ward Name -> Ward Number(maybe)
	 Drug Number -> Name, Description, Dosage, Method of Admin, Start Date, End Date


*/




