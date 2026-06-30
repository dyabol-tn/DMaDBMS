CREATE TABLE [Справочник_валют] (
	[Код_валюты] int IDENTITY(1,1) NOT NULL,
	[Сокращение] nvarchar(3) NOT NULL UNIQUE,
	[Полное_название] nvarchar(50) NOT NULL,
	PRIMARY KEY ([Код_валюты])
);
CREATE TABLE [Члены_семьи] (
	[Код_члена_семьи] int IDENTITY(1,1) NOT NULL,
	[Имя] nvarchar(30) NOT NULL,
	[Дополнительная_информация] nvarchar(max),
	PRIMARY KEY ([Код_члена_семьи])
);
CREATE TABLE [Остатки_наличных] (
	[Код_остатка] int IDENTITY(1,1) NOT NULL,
	[Код_валюты] int NOT NULL,
	[Количество_остатка] decimal(18,0) NOT NULL,
	PRIMARY KEY ([Код_остатка])
);
CREATE TABLE [Операции] (
	[Код_операции] int IDENTITY(1,1) NOT NULL,
	[Код_члена_семьи] int NOT NULL,
	[Код_направления] int NOT NULL,
	[Код_валюты] int NOT NULL,
	[Дата] date NOT NULL,
	[Описание] nvarchar(max) NOT NULL,
	[Признак_использования_нала] bit NOT NULL,
	[Сумма_полученных/израсходованных] decimal(18,0) NOT NULL,
	PRIMARY KEY ([Код_операции])
);
CREATE TABLE [Конвертация_валют] (
	[Код_конвертации] int IDENTITY(1,1) NOT NULL,
	[Код_члена_семьи] int NOT NULL,
	[Дата] date NOT NULL,
	[Код_начальной_валюты] int NOT NULL,
	[Код_конечной_валюты] int NOT NULL,
	[Сумма_начальной] decimal(18,0) NOT NULL,
	[Сумма_конечной] decimal(18,0) NOT NULL,
	[Курс_конвертации] decimal(18,0) NOT NULL,
	PRIMARY KEY ([Код_конвертации])
);
CREATE TABLE [Направления] (
	[Код_направления] int IDENTITY(1,1) NOT NULL,
	[Название] nvarchar(50) NOT NULL,
	[Доход/расход] nvarchar(7) NOT NULL,
	[Код_родителя] int,
	PRIMARY KEY ([Код_направления])
);
ALTER TABLE [Остатки_наличных] ADD CONSTRAINT [Остатки_наличных_fk1] FOREIGN KEY ([Код_валюты]) REFERENCES [Справочник_валют]([Код_валюты]);
ALTER TABLE [Операции] ADD CONSTRAINT [Операции_fk1] FOREIGN KEY ([Код_члена_семьи]) REFERENCES [Члены_семьи]([Код_члена_семьи]);
ALTER TABLE [Операции] ADD CONSTRAINT [Операции_fk2] FOREIGN KEY ([Код_направления]) REFERENCES [Направления]([Код_направления]);
ALTER TABLE [Операции] ADD CONSTRAINT [Операции_fk3] FOREIGN KEY ([Код_валюты]) REFERENCES [Справочник_валют]([Код_валюты]);
ALTER TABLE [Конвертация_валют] ADD CONSTRAINT [Конвертация_валют_fk1] FOREIGN KEY ([Код_члена_семьи]) REFERENCES [Члены_семьи]([Код_члена_семьи]);
ALTER TABLE [Конвертация_валют] ADD CONSTRAINT [Конвертация_валют_fk3] FOREIGN KEY ([Код_начальной_валюты]) REFERENCES [Справочник_валют]([Код_валюты]);
ALTER TABLE [Конвертация_валют] ADD CONSTRAINT [Конвертация_валют_fk4] FOREIGN KEY ([Код_конечной_валюты]) REFERENCES [Справочник_валют]([Код_валюты]);
ALTER TABLE [Направления] ADD CONSTRAINT [Направления_fk3] FOREIGN KEY ([Код_родителя]) REFERENCES [Направления]([Код_направления]);