SET IDENTITY_INSERT [dbo].[Host] ON
INSERT [dbo].[Host] ([CommandNumber], [Command]) VALUES (1, 'This is the first host command')
INSERT [dbo].[Host] ([CommandNumber], [Command]) VALUES (2, 'This is the second host command')
INSERT [dbo].[Host] ([CommandNumber], [Command]) VALUES (3, 'This is the third host command')
INSERT [dbo].[Host] ([CommandNumber], [Command]) VALUES (4, 'This is the fourth host command')
INSERT [dbo].[Host] ([CommandNumber], [Command]) VALUES (5, 'Thus is the fifth host command')
SET IDENTITY_INSERT [dbo].[Host] OFF


SET IDENTITY_INSERT [dbo].[Bin] ON
INSERT [dbo].[Bin] ([RequestNumber], [Request]) VALUES (1, 'This is the first bin request')
INSERT [dbo].[Bin] ([RequestNumber], [Request]) VALUES (2, 'This is the second bin request')
INSERT [dbo].[Bin] ([RequestNumber], [Request]) VALUES (3, 'This is the third bin request')
INSERT [dbo].[Bin] ([RequestNumber], [Request]) VALUES (4, 'This is the fourth bin request')
INSERT [dbo].[Bin] ([RequestNumber], [Request]) VALUES (5, 'Thus is the fifth bin request')
SET IDENTITY_INSERT [dbo].[Bin] OFF