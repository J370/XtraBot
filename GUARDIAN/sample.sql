DROP Database Portfolio2;

Create Database Portfolio2
GO

Use Portfolio2 
GO

--/***************************************************************/
--/***           Delete tables before creating                 ***/
--/***************************************************************/

/*Table : dbo.Teacher */
if exists (select * from sysobjects 
  where id = object_id('dbo.Lecturer') and sysstat & 0xf = 3)
  drop table dbo.Lecturer
GO

/*Table : dbo.Student */
if exists (select * from sysobjects 
  where id = object_id('dbo.Student') and sysstat & 0xf = 3)
  drop table dbo.Student
GO

/*Table : dbo.Post */
if exists (select * from sysobjects 
  where id = object_id('dbo.Post') and sysstat & 0xf = 3)
  drop table dbo.Post
GO

/*Table : dbo.Reply */
if exists (select * from sysobjects 
  where id = object_id('dbo.Reply') and sysstat & 0xf = 3)
  drop table dbo.Reply
GO

/*Table : dbo.Module*/
if exists (select * from sysobjects 
  where id = object_id('dbo.Module') and sysstat & 0xf = 3)
  drop table dbo.Module
GO

/*Table : dbo.CourseModule*/
if exists (select * from sysobjects 
  where id = object_id('dbo.CourseModule') and sysstat & 0xf = 3)
  drop table dbo.CourseModule
GO

/*Table : dbo.Course*/
if exists (select * from sysobjects 
  where id = object_id('dbo.Course') and sysstat & 0xf = 3)
  drop table dbo.Course
GO

/*Table : dbo.School*/
if exists (select * from sysobjects 
  where id = object_id('dbo.School') and sysstat & 0xf = 3)
  drop table dbo.School
GO

/*Table : dbo.RequestEventTable*/
if exists (select * from sysobjects 
  where id = object_id('dbo.RequestEventTable') and sysstat & 0xf = 3)
  drop table dbo.RequestEventTable
GO

/*Table : dbo.VoteTable*/
if exists (select * from sysobjects 
  where id = object_id('dbo.VoteTable') and sysstat & 0xf = 3)
  drop table dbo.VoteTable
GO

/*Table : dbo.HostingEventTable*/
if exists (select * from sysobjects 
  where id = object_id('dbo.HostingEventTable') and sysstat & 0xf = 3)
  drop table dbo.HostingEventTable
GO


/*Table : dbo.AttendanceTable*/
if exists (select * from sysobjects 
  where id = object_id('dbo.AttendanceTable') and sysstat & 0xf = 3)
  drop table dbo.AttendanceTable
GO


/***************************************************************/
/***                     Creating tables                     ***/
/***************************************************************/

/*Table : dbo.School*/
CREATE TABLE dbo.School
(
  SchoolID              int IDENTITY(1,1),
  SchoolName            varchar(255)    NOT NULL,
  CONSTRAINT PK_School PRIMARY KEY NONCLUSTERED (SchoolID)
)
GO

/*Table : dbo.Lecturer*/
CREATE TABLE dbo.Lecturer
(
  LecturerID			int IDENTITY (1,1),
  [Name]			    varchar(50) 	NOT NULL,
  EmailAddr		    	varchar(50)  	NOT NULL,
  [Password]		    varchar(255)  	NOT NULL DEFAULT ('LecturerPassword'),
  [Description]			varchar(3000)	NULL,
  Photo					varchar(255) 	NULL,
  SchoolID              int             NULL,
  CONSTRAINT PK_Lecturer PRIMARY KEY NONCLUSTERED (LecturerID),
  CONSTRAINT FK_School4_School4 FOREIGN KEY (SchoolID) REFERENCES dbo.School (SchoolID)
)
GO


/*Table : dbo.Course*/
CREATE TABLE dbo.Course
(
  CourseID              int IDENTITY(1,1),
  CourseName            varchar(255)    NOT NULL,
  SchoolID              int             NOT NULL,
  CONSTRAINT PK_Course PRIMARY KEY NONCLUSTERED (CourseID),
  CONSTRAINT FK_School2_SchoolID2 FOREIGN KEY (SchoolID) REFERENCES dbo.School (SchoolID)
)
GO


/*Table : dbo.Student */
CREATE TABLE dbo.Student
(
  StudentID 			int IDENTITY (1,1),
  [Name]				varchar(50) 	NOT NULL,
  CourseID				int          	NOT NULL,
  Photo					varchar(255) 	NULL,
  [Description]			varchar(3000) 	NULL,
  EmailAddr		    	varchar(50)  	NOT NULL,
  [Password]			varchar(255)  	NOT NULL DEFAULT ('StudentPassword'),
  SchoolID              int             NOT NULL,
  CONSTRAINT PK_Student PRIMARY KEY NONCLUSTERED (StudentID),
  CONSTRAINT FK_Course1_CourseID1 FOREIGN KEY (CourseID) REFERENCES dbo.Course (CourseID),
  CONSTRAINT FK_School5_SchoolID5 FOREIGN KEY (SchoolID) REFERENCES dbo.School (SchoolID)
)
GO


/*Table : dbo.Module*/
CREATE TABLE dbo.Module
(
  ModuleID   			int IDENTITY (1,1),
  ModuleName			varchar(255) 	NOT NULL,
  SchoolID              int             NOT NULL,
  CONSTRAINT PK_Module PRIMARY KEY NONCLUSTERED (ModuleID),
  CONSTRAINT FK_School_SchoolID FOREIGN KEY (SchoolID) REFERENCES dbo.School (SchoolID),

)
GO

/*Table : dbo.Post */
CREATE TABLE dbo.Post
(
  PostID 			    int IDENTITY (1,1),
  Title			    	varchar(255) 	NOT NULL,
  [Description]			varchar(5000) 	NULL,
  Photo			        varchar(255) 	NULL,
  DateCreated			datetime		NOT NULL DEFAULT (getdate()),
  StudentID             int             NULL, 
  LecturerID            int             NULL,
  ModuleID              int             NOT NULL,
  SchoolID              int             NOT NULL,
  Solved				int				Not NULL DEFAULT (0),
  CONSTRAINT PK_Post PRIMARY KEY NONCLUSTERED (PostID),
  CONSTRAINT FK_Student_StudentID FOREIGN KEY (StudentID) REFERENCES dbo.Student(StudentID),
  CONSTRAINT FK_Module_ModuleID FOREIGN KEY (ModuleID) REFERENCES dbo.Module(ModuleID),
  CONSTRAINT FK_School1_SchoolID1 FOREIGN KEY (SchoolID) REFERENCES dbo.School(SchoolID),
  CONSTRAINT FK_Lecturer_LecturerID9 FOREIGN KEY (LecturerID) REFERENCES dbo.Lecturer(LecturerID)
)
GO
CREATE TABLE dbo.CourseModule
(
	CourseID int Not Null,
	ModuleID int Not Null,
	ModuleName varchar(255) NOT NULL,
	CONSTRAINT PK_CourseModule Primary Key (CourseID,ModuleID),
	Constraint FK_Course_CourseID Foreign Key (CourseID) References dbo.Course(CourseID),
	Constraint FK_Module_ModuleID2 Foreign Key (ModuleID) References dbo.Module(ModuleID)

)
GO
/*Table : dbo.Reply */
CREATE TABLE dbo.Reply
(
  ReplyID 			    int IDENTITY (1,1),
  [Description]			varchar(5000) 	NULL,
  Picture			    varchar(255) 	NULL,
  DateCreated			datetime		NOT NULL DEFAULT (getdate()),
  PostID                int             NOT NULL,
  StudentID             int             NULL,
  LecturerID            int             NULL,
  CONSTRAINT PK_Reply PRIMARY KEY NONCLUSTERED (ReplyID),
  CONSTRAINT FK_Post_PostID FOREIGN KEY (PostID) REFERENCES dbo.Post(PostID),
  CONSTRAINT FK_Student9_StudentID9 FOREIGN KEY (StudentID) REFERENCES dbo.Student(StudentID)
)
GO



CREATE TABLE dbo.RequestEventTable
(
	RequestID int IDENTITY (1,1),
	StudentID int NULL, 
	LecturerID int NULL,
	ModuleID int Not Null,
	ModuleName varchar(255) NOT NULL,
	Title varchar(255) NOT NULL,
	[Description] varchar(5000) NULL,
	VoteNo int NOT NULL,
	DateCreated datetime NOT NULL DEFAULT (getdate())

	CONSTRAINT PK_RequestEventTable Primary Key (RequestID),
	Constraint FK_Student0_StudentID0 Foreign Key (StudentID) References dbo.Student(StudentID),
	Constraint FK_Lecturer0_LecturerID0 Foreign Key (LecturerID) References dbo.Lecturer(LecturerID),
	Constraint FK_Module_ModuleID0 Foreign Key (ModuleID) References dbo.Module(ModuleID),
)
GO



CREATE TABLE dbo.VoteTable
(
	VoteID int IDENTITY (1,1),
	RequestID int NOT NULL,
	StudentID int NULL,
	LecturerID int NULL,


	CONSTRAINT PK_VoteTable Primary Key (VoteID),
	Constraint FK_Student_StudentID10 Foreign Key (StudentID) References dbo.Student(StudentID),
	Constraint FK_Lecturer0_LecturerID10 Foreign Key (LecturerID) References dbo.Lecturer(LecturerID),
	Constraint FK_RequestEventTable_RequestID Foreign Key (RequestID) References dbo.RequestEventTable(RequestID),
)
GO



CREATE TABLE dbo.HostingEventTable
(
	EventID int IDENTITY (1,1),
	StudentID int NULL,
	LecturerID int NULL,
	ModuleID int NULL,
	ModuleName varchar(255) NOT NULL,
	Title varchar(255) NOT NULL,
	[description] varchar(5000) NOT NULL,
	DateOfEvent datetime NOT NULL,
	DateOfPost			datetime		NOT NULL DEFAULT (getdate()),
	NumberOfAttendees int NOT NULL,


	CONSTRAINT PK_EventTable Primary Key (EventID),
	Constraint FK_Student_StudentID11 Foreign Key (StudentID) References dbo.Student(StudentID),
	Constraint FK_Lecturer0_LecturerID11 Foreign Key (LecturerID) References dbo.Lecturer(LecturerID),
	Constraint FK_Module_ModuleID11 Foreign Key (ModuleID) References dbo.Module(ModuleID),
)
GO

CREATE TABLE dbo.AttendanceTable
(
	AttendanceID int IDENTITY(1,1),
	StudentID int NULL, 
	LecturerID int NULL,
	EventID int NOT NULL,

	CONSTRAINT PK_AttendanceTable Primary Key (AttendanceID),
	Constraint FK_Student_StudentID12 Foreign Key (StudentID) References dbo.Student(StudentID),
	Constraint FK_Lecturer0_LecturerID12 Foreign Key (LecturerID) References dbo.Lecturer(LecturerID),
	Constraint FK_HostingEventTable_EventID Foreign Key (EventID) References dbo.HostingEventTable(EventID),

)
GO



/***************************************************************/
/***                Populate Sample Data                     ***/
/***************************************************************/


SET IDENTITY_INSERT [dbo].[School] ON 
INSERT [dbo].[School] ([SchoolID], [SchoolName]) VALUES (1, 'Information & Digital Technology')
INSERT [dbo].[School] ([SchoolID], [SchoolName]) VALUES (2, 'Applied Sciences')
INSERT [dbo].[School] ([SchoolID], [SchoolName]) VALUES (3, 'Built Environment')
INSERT [dbo].[School] ([SchoolID], [SchoolName]) VALUES (4, 'Business Management')
INSERT [dbo].[School] ([SchoolID], [SchoolName]) VALUES (5, 'Engineering')
INSERT [dbo].[School] ([SchoolID], [SchoolName]) VALUES (6, 'Health Sciences')
INSERT [dbo].[School] ([SchoolID], [SchoolName]) VALUES (7, 'Humanities')
SET IDENTITY_INSERT [dbo].[School] OFF

SET IDENTITY_INSERT [dbo].[Course] ON
INSERT [dbo].[Course] ([CourseID], [CourseName], [SchoolID]) VALUES (1, 'Information Technology', 1)
INSERT [dbo].[Course] ([CourseID], [CourseName], [SchoolID]) VALUES (2, 'Financial Informatics', 1)
INSERT [dbo].[Course] ([CourseID], [CourseName], [SchoolID]) VALUES (3, 'Information Security & Forensics', 1)
INSERT [dbo].[Course] ([CourseID], [CourseName], [SchoolID]) VALUES (4, 'Multi-Media & Animations', 1)
INSERT [dbo].[Course] ([CourseID], [CourseName], [SchoolID]) VALUES (5, 'Common ICT Programme', 1)
SET IDENTITY_INSERT [dbo].[Course] OFF



SET IDENTITY_INSERT [dbo].[Lecturer] ON 
INSERT [dbo].[Lecturer] ([LecturerID], [Name], [EmailAddr], [Password], [Description],SchoolID) VALUES (1, 'Lohron', 'lecturernumba1@gmail.com', 'verygoodpassword', 'Hi i am a teacher',1)
INSERT [dbo].[Lecturer] ([LecturerID], [Name], [EmailAddr], [Password], [Description],SchoolID) VALUES (2, 'Supreme Leader Jun Wei', 'Lecturernumba2@gmail.com', 'verybadpassword', 'Hi i am a teacher',1)
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (16, 'Tremain Slisby', 'tslisby0@cafepress.com', 'PTzv7oNpC', 'in leo maecenas pulvinar lobortis est',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (17, 'Darryl Domenge', 'ddomenge1@cbsnews.com', 'Q7HBsG', 'ut rhoncus aliquet pulvinar sed',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (3, 'Sybille Mandrake', 'smandrake2@thetimes.co.uk', '5ZfekBR', 'in hac habitasse platea dictumst aliquam',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (4, 'Linnell Chetwin', 'lchetwin3@samsung.com', 'NNnERGRS', 'curae donec pharetra magna vestibulum aliquet ultrices erat tortor',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (5, 'Leigh Mathey', 'lmathey4@sina.com.cn', 'rCypGcu9', 'cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (6, 'Garwood Sadgrove', 'gsadgrove5@photobucket.com', '9UHXbRAIhO', 'sapien cum sociis natoque penatibus et magnis',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (7, 'Reg Itscovitz', 'ritscovitz6@ucoz.ru', '0KkkG8nHX', 'nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (8, 'Erhart Dewberry', 'edewberry7@nydailynews.com', 'bGxUjsrG', 'dapibus nulla suscipit ligula in lacus curabitur at',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (9, 'Angelica Sargeant', 'asargeant8@vkontakte.ru', 'IsCtKOShiL', 'felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (10, 'Orelia McIlmurray', 'omcilmurray9@senate.gov', 'lcW7SM', 'erat quisque erat eros viverra eget congue',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (11, 'Quill Harbach', 'qharbacha@npr.org', 'EacvhV', 'eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (12, 'Giralda Housaman', 'ghousamanb@wikispaces.com', 'OCPgOD87DA9', 'in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (13, 'Ara Thexton', 'athextonc@gizmodo.com', 'GdqEZH5oT2', 'sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (14, 'Jobie Edington', 'jedingtond@eepurl.com', 'kCWmTLX', 'molestie sed justo pellentesque viverra pede ac diam',1);
insert into Lecturer (LecturerID, Name, EmailAddr, Password, Description,SchoolID) values (15, 'Olivier Maybey', 'omaybeye@sciencedaily.com', 'O7OYTLpScz', 'montes nascetur ridiculus mus etiam vel',1);
SET IDENTITY_INSERT [dbo].[Lecturer] OFF

SET IDENTITY_INSERT [dbo].[Student] ON
INSERT [dbo].[Student] ([StudentID], [Name], [CourseID] , [EmailAddr], [Password], [Description],[SchoolID]) VALUES (1, 'Ang Soon Li', 1 , 'poopinmahbusiness@gmail.com', 'password','Hi I am a student.', 1)
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (21, 'Melicent Husset', 1, 'mhusset0@squidoo.com', 'e6BdPNlllw','Hi I am a student.', 1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password,  [Description],SchoolID) values (2, 'Kiri Rizzetti', 2, 'krizzetti1@hubpages.com', 'ZaUo8hz9p3V', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (3, 'Bertie Kinzett', 3, 'bkinzett2@nydailynews.com', 'uUrfI4aL', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (4, 'Daisey Kingzett', 4, 'dkingzett3@alibaba.com', 'lwJBrrwYIx', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (5, 'Costa Mandrey', 5, 'cmandrey4@theguardian.com', 'HMfvgVKnpc', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (6, 'Noby Speake', 1, 'nspeake5@ebay.co.uk', '7WGSpqgVn', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (7, 'Cherilynn Gaisford', 1, 'cgaisford6@sfgate.com', '8XNKm1rwFUG1', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (8, 'Elliott Satford', 2, 'esatford7@tmall.com', 'txf788UKj', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (9, 'Lizzy Buxy', 3, 'lbuxy8@weebly.com', 's68SSBNbho', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password,  [Description],SchoolID) values (10, 'Haskel Knipe', 3, 'hknipe9@surveymonkey.com', 'KUL6uZC', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password,  [Description],SchoolID) values (11, 'Wake Behan', 5, 'wbehana@mayoclinic.com', 'RLrnl4nMgysN', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (12, 'Eleanore Duham', 4, 'eduhamb@time.com', 'YugWzp00Z', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (13, 'Gallard Winchcombe', 2, 'gwinchcombec@diigo.com', 'HD9kfRpOUblW', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (14, 'Vonnie Kingaby', 3, 'vkingabyd@chronoengine.com', 'mjnm1f', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (15, 'Mollie McMechan', 1, 'mmcmechane@columbia.edu', 'qTQJ23xKw', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (16, 'Lynea Rumsey', 1, 'lrumseyf@miitbeian.gov.cn', 'D5aC0qaJJf0c', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (17, 'Dulci Goold', 1, 'dgooldg@abc.net.au', 'OIhDX2e', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password,  [Description],SchoolID) values (18, 'Danielle Drivers', 2, 'ddriversh@ovh.net', 'YvjOiJSYxr', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (19, 'Ivonne Huccaby', 5, 'ihuccabyi@state.tx.us', '9jaqg41f8N', 'Hi I am a student.',1);
insert into Student (StudentID, Name, CourseID, EmailAddr, Password, [Description], SchoolID) values (20, 'Zsa zsa Cliff', 4, 'zzsaj@apple.com', 'sHZ5r0pMAK', 'Hi I am a student.',1);
SET IDENTITY_INSERT [dbo].[Student] OFF 


SET IDENTITY_INSERT [dbo].[Module] ON 
Insert [dbo].[Module] ([ModuleID],[ModuleName],[SchoolID]) VALUES (1, 'Full Stack Development', 1 ) 
Insert [dbo].[Module] ([ModuleID],[ModuleName],[SchoolID]) VALUES (2, 'Portfolio2', 1 ) 
Insert [dbo].[Module] ([ModuleID],[ModuleName],[SchoolID]) VALUES (3, 'Fundamentals for IT Pro 3', 1 ) 
Insert [dbo].[Module] ([ModuleID],[ModuleName],[SchoolID]) VALUES (4, 'User Experience', 1 ) 
Insert [dbo].[Module] ([ModuleID],[ModuleName],[SchoolID]) VALUES (5, 'Technopreneurship', 1 ) 
Insert [dbo].[Module] ([ModuleID],[ModuleName],[SchoolID]) VALUES (6, 'Games Programming', 1) 
Insert [dbo].[Module] ([ModuleID],[ModuleName],[SchoolID]) VALUES (7, 'Data Structure and Algorithms',  1) 
SET IDENTITY_INSERT [dbo].[Module] OFF
 



INSERT dbo.CourseModule(ModuleID,CourseID, ModuleName) VALUES(1,1, 'Full Stack Development')
INSERT dbo.CourseModule(ModuleID,CourseID, ModuleName) VALUES(2,1,'Portfolio2')
INSERT dbo.CourseModule(ModuleID,CourseID, ModuleName) VALUES(3,1,'Fundamentals for IT Pro 3')
INSERT dbo.CourseModule(ModuleID,CourseID, ModuleName) VALUES(4,1, 'User Experience')
INSERT dbo.CourseModule(ModuleID,CourseID, ModuleName) VALUES(5,1, 'Technopreneurship')
INSERT dbo.CourseModule(ModuleID,CourseID, ModuleName) VALUES(6,1, 'Games Programming')
INSERT dbo.CourseModule(ModuleID,CourseID, ModuleName) VALUES(7,1, 'Data Structure and Algorithms')
SET IDENTITY_INSERT [dbo].Post ON 
insert into Post (PostID, Title, Description, Photo, DateCreated, StudentID, ModuleID, SchoolID, Solved) values (1, 'parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', null, '03/08/2019', 13, 6, 1, 0);
insert into Post (PostID, Title, Description, Photo, DateCreated, StudentID, ModuleID, SchoolID, Solved) values (2, 'vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.', null, '09/10/2019', 5, 4, 1,0);
insert into Post (PostID, Title, Description, Photo,  StudentID, ModuleID, SchoolID, Solved) values (3, 'convallis duis consequat dui nec nisi volutpat eleifend donec', 'Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', null, 4, 5, 1, 0);
insert into Post (PostID, Title, Description, Photo,  StudentID, ModuleID, SchoolID, Solved) values (4, 'id luctus nec molestie sed justo', 'Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.', null, 18, 4, 1, 0 );
insert into Post (PostID, Title, Description, Photo,  StudentID, ModuleID, SchoolID, Solved) values (5, 'eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat', 'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus.', null, 3, 6, 1, 0);
insert into Post (PostID, Title, Description, Photo,  StudentID, ModuleID, SchoolID, Solved) values (6, 'vulputate nonummy maecenas tincidunt lacus at', 'Aenean auctor gravida sem.', null, 4, 2, 1, 0);
insert into Post (PostID, Title, Description, Photo,  StudentID, ModuleID, SchoolID, Solved) values (7, 'elementum pellentesque quisque porta volutpat erat quisque erat eros viverra', 'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus.', null, 15, 4, 1, 0);
insert into Post (PostID, Title, Description, Photo,  StudentID, ModuleID, SchoolID, Solved) values (8, 'vulputate nonummy maecenas tincidunt lacus at velit vivamus', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', null, 18, 1, 1, 0);
insert into Post (PostID, Title, Description, Photo,  StudentID, ModuleID, SchoolID, Solved) values (9, 'tellus semper interdum mauris ullamcorper', 'Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', null, 19, 6, 1, 0);
insert into Post (PostID, Title, Description, Photo,  StudentID, ModuleID, SchoolID, Solved) values (10, 'ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', null, 12, 6, 1, 0);
SET IDENTITY_INSERT [dbo].Post OFF 
SET IDENTITY_INSERT [dbo].[Reply] ON 
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (1,1, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', null, 5);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (2,2, 'Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', null, 8);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (3,3, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', null, 2);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (4,4, 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', null, 4);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (5,5, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', null, 10);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (6,6, 'Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.', null, 4);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (7,7, 'Suspendisse accumsan tortor quis turpis. Sed ante.', null, 7);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (8,8, 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante.', null, 6);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (9,9, 'Duis consequat dui nec nisi volutpat eleifend.', null, 7);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (10,10, 'Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.', null, 8);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (11,11, 'Proin eu mi.', null, 5);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (12,12, 'Duis bibendum. Morbi non quam nec dui luctus rutrum.', null, 5);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (13, 13,'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.', null, 5);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (14, 14,'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', null, 5);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (15, 15,'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', null,  2);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (16, 16,'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', null, 9);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (17, 17,'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', null, 7);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (18,18, 'Nulla justo.', null, 6);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (19, 19,'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.', null, 2);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (20, 20,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.', null, 8);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (21, 1,'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', null, 8);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (22, 2,'Etiam faucibus cursus urna.', null, 6);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (23, 3,'Curabitur in libero ut massa volutpat convallis.', null, 4);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (24, 4,'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', null, 2);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (25, 5,'Cras pellentesque volutpat dui.', null, 7);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (26, 6,'Etiam vel augue. Vestibulum rutrum rutrum neque.', null, 9);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (27, 7,'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', null, 4);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (28, 8,'Proin at turpis a pede posuere nonummy. Integer non velit.', null, 6);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (29, 9,'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', null, 8);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (30, 10,'Etiam faucibus cursus urna.', null, 2);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (31, 11,'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', null, 5);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (32, 12,'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.', null, 3);
insert into Reply (ReplyID, StudentID, Description, Picture,  PostID) values (33, 13,'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', null, 2);
 
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (34,1, 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', null, 5);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (35,2, 'Nulla ut erat id mauris vulputate elementum. Nullam varius.', null, 3);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (36,3, 'Morbi non quam nec dui luctus rutrum. Nulla tellus.', null, 5);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (37,4, 'Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', null, 9);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (38,5, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst.', null, 3);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (39,6, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', null, 2);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (40,7, 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.', null, 4);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (41,8, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', null, 10);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (42,9, 'Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.', null, 1);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (43,10, 'In hac habitasse platea dictumst.', null, 2);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (44, 11,'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis.', null, 5);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (45, 12,'Morbi a ipsum.', null, 5);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (46, 13,'Integer ac leo.', null, 4);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (47, 14,'Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.', null, 6);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (48, 15,'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', null, 3);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (49, 1,'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.', null, 2);
insert into Reply (ReplyID, LecturerID, Description, Picture, PostID) values (50, 2,'Morbi quis tortor id nulla ultrices aliquet.', null, 1);
SET IDENTITY_INSERT [dbo].[Reply] OFF 

SET IDENTITY_INSERT [dbo].RequestEventTable ON 
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (1, null, 15, 1, 'Full Stack Development', 'sodales sed tincidunt eu felis fusce', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 2);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (2, 2, null, 3, 'Fundamentals for IT Pro 3', 'morbi sem mauris laoreet ut rhoncus aliquet', 'In congue. Etiam justo. Etiam pretium iaculis justo.', 0);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (3, null, 10, 6, 'Games Programming', 'habitasse platea dictumst etiam faucibus cursus urna', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.', 3);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (4, null, 6, 5, 'Technopreneurship', 'interdum mauris ullamcorper purus sit amet nulla quisque', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 4);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (5, 3, null, 7, 'Data Structure Algorithms', 'justo nec condimentum neque sapien placerat ante nulla', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 3);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (6, null, 4, 2, 'Portfolio2', 'nulla pede ullamcorper augue a suscipit', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 3);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (7, 13, null, 1, 'Full Stack Development', 'platea dictumst etiam faucibus cursus', null, 3);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (8, null, 14, 1, 'Full Stack Development', 'posuere felis sed lacus morbi sem mauris', null, 4);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (9, 12, null, 7, 'Data Structure Algorithms', 'mauris morbi non lectus', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 5);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (10, null, 12, 1, 'Full Stack Development', 'quam suspendisse potenti', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.

Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 4);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (11, null, 14, 2, 'Portfolio2', 'in hac habitasse platea dictumst aliquam augue quam', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 2);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (12, 5, null, 3, 'Fundamentals for IT Pro 3', 'nisl duis ac nibh fusce lacus purus', null, 1);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (13, 16, null, 1, 'Full Stack Development', 'nullam varius nulla facilisi cras non velit', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 2);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (14, null, 14, 5, 'Technopreneurship', 'dictumst maecenas ut massa quis augue luctus tincidunt', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 4);
insert into RequestEventTable (RequestID, StudentID, LecturerID, ModuleID, ModuleName, Title, [Description], VoteNo) values (15, 12, null, 2, 'Portfolio2', 'cras pellentesque volutpat', null, 0);
--Select * from Post
SET IDENTITY_INSERT [dbo].RequestEventTable OFF 

SET IDENTITY_INSERT [dbo].VoteTable ON 
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (1, 13, 15, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (2, 8, null, 5);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (3, 5, 19, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (4, 3, null, 6);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (5, 9, 16, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (6, 8, null, 12);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (7, 4, 1, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (8, 8, 4, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (9, 5, null, 14);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (10, 11, 7, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (11, 10, 4, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (12, 14, 16, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (13, 10, null, 8);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (14, 3, 14, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (15, 6, 9, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (16, 1, null, 13);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (17, 7, null, 7);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (18, 8, 8, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (19, 9, 5, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (20, 3, 4, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (21, 13, 17, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (22, 5, 2, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (23, 14, 9, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (24, 11, null, 6);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (25, 9, 15, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (26, 10, 11, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (27, 7, null, 9);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (28, 14, null, 13);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (29, 6, 18, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (30, 4, null, 10);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (31, 9, 6, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (32, 14, 4, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (33, 4, null, 15);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (34, 4, 12, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (35, 12,null, 2);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (36, 1, 17, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (37, 6, 4, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (38, 7, 17, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (39, 10, 20, null);
insert into VoteTable (VoteID, RequestID, StudentID, LecturerID) values (40, 9, null, 9);
SET IDENTITY_INSERT [dbo].VoteTable OFF 

SET IDENTITY_INSERT [dbo].HostingEventTable ON 
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (1, null, 8, 3, 'Fundamentals for IT Pro 3', 'nascetur ridiculus mus vivamus', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', '2021-02-04', '2019-04-18', 2);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (2, null, 4, 3, 'Fundamentals for IT Pro 3', 'in', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.', '2020-03-30', '2019-05-03', 3);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (3, 4, null, 7, 'Data Structure Algorithms', 'faucibus orci luctus et ultrices posuere cubilia', 'Etiam vel augue. Vestibulum rutrum rutrum neque.', '2019-04-21', '2018-10-20', 1);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (4, null, 3, 4, 'User Experience', 'lorem ipsum dolor sit amet consectetuer', 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '2020-11-14', '2019-10-09', 1);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (5, null, 15, 4, 'User Experience', 'mauris ullamcorper purus sit', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '2019-06-28', '2019-03-30', 5);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (6, 1, null, 2, 'Portfolio2', 'sit', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', '2021-02-24', '2019-09-02', 2);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (7, 8, null, 4, 'User Experience', 'integer ac neque', 'In blandit ultrices enim.', '2021-04-12', '2019-08-07', 2);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (8, 5, null, 5, 'Technopreneurship', 'nisl venenatis lacinia aenean sit amet justo', 'Donec dapibus. Duis at velit eu est congue elementum.', '2020-02-22', '2019-01-13', 2);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (9, null, 7, 7, 'Data Structure Algorithms', 'a', 'Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.', '2019-10-04', '2019-05-17', 1);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (10, null, 10, 1, 'Full Stack Development', 'porttitor lorem id ligula', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue.', '2020-03-30', '2018-12-06', 2);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (11, null, 9, 7, 'Data Structure Algorithms', 'nunc purus phasellus', 'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '2019-05-22', '2019-01-07', 4);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (12, 12, null, 6,'Games Programming' , 'lacinia eget tincidunt eget tempus', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.', '2020-06-09', '2018-12-17', 4);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (13, null, 4, 1,'Full Stack Development' , 'vehicula consequat morbi a', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna.', '2020-09-26', '2018-12-23', 3);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (14, null, 1, 1, 'Full Stack Development', 'sed justo pellentesque viverra pede ac diam', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl.', '2019-07-17', '2019-07-07', 1);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (15, 1, null, 3, 'Fundamentals for IT Pro 3', 'at nibh', 'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.', '2020-05-27', '2019-05-16', 1);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (16, null, 6, 7, 'Data Structure Algorithms', 'phasellus sit amet', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.', '2019-01-22', '2019-10-08', 5);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (17, null, 7, 1, 'Full Stack Development', 'sed justo pellentesque viverra', 'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', '2019-06-25', '2018-12-17', 1);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (18,null, 11, 3, 'Fundamentals for IT Pro 3', 'pharetra magna ac consequat metus', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', '2019-08-14', '2019-07-15', 1);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (19, 4, null, 6, 'Games Programming', 'metus aenean fermentum donec ut', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.', '2021-03-24', '2019-12-16', 5);
insert into HostingEventTable (EventID, StudentID, LecturerID, ModuleID, ModuleName, Title, [description], DateOfEvent, DateOfPost, NumberOfAttendees) values (20, null, 4, 6, 'Games Programming', 'erat fermentum justo nec', 'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', '2019-11-11', '2019-07-25', 4);
SET IDENTITY_INSERT [dbo].HostingEventTable OFF 

SET IDENTITY_INSERT [dbo].AttendanceTable ON 
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (1, null, 6, 8);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (2, 18, null, 15);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (3, 15, null, 5);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (4, 7, null, 20);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (5, 18, null, 12);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (6, 4, null, 19);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (7, 9, null, 13);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (8, 6, null, 5);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (9, 10, null, 5);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (10, 14, null, 10);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (11, 3, null, 13);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (12, null, 11, 19);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (13, null, 9, 19);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (14, 13, null, 7);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (15, 12, null, 2);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (16, 16, null, 3);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (17, 15, null, 2);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (18, 20, null, 1);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (19, 17, null, 16);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (20, null, 7, 19);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (21, 3, null, 12);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (22, 5, null, 19);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (23, 7, null, 6);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (24, 15, null, 16);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (25, null, 5, 11);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (26, null, 13, 12);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (27, 9, null, 14);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (28, 13, null, 10);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (29, 20, null, 8);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (30, 3, null, 2);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (31, null, 11, 16);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (32, 16, null, 17);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (33, 4, null, 11);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (34, 5, null, 7);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (35, 5, null, 20);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (36, 6, null, 5);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (37, null, 15, 11);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (38, 5, null, 6);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (39, 10, null, 1);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (40, 6, null, 11);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (41, 19, null, 9);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (42, 16, null, 20);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (43, 12, null, 13);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (44, 18, null, 4);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (45, null, 9, 16);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (46, 9, null, 18);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (47, 2, null, 5);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (48, 2, null, 16);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (49, 18, null, 20);
insert into AttendanceTable (AttendanceID, StudentID, LecturerID, EventID) values (50, null, 13, 12);
SET IDENTITY_INSERT [dbo].AttendanceTable OFF 

Select * from VoteTable

Select * from RequestEventTable where RequestID=8 


