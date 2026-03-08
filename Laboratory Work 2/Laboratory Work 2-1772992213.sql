CREATE TABLE [Клиенты] (
	[Код_клиента] int IDENTITY(1,1) NOT NULL,
	[Фамилия] nvarchar(50) NOT NULL,
	[Имя] nvarchar(50),
	[Отчество] nvarchar(50),
	[Паспорт] nvarchar(20) NOT NULL,
	[Дата_рождения] date,
	[Адрес] nvarchar(200),
	[Тел] nvarchar(20),
	PRIMARY KEY ([Код_клиента])
);

CREATE TABLE [Категории] (
	[Код_категории] int IDENTITY(1,1) NOT NULL,
	[Категория] nvarchar(100) NOT NULL,
	PRIMARY KEY ([Код_категории])
);

CREATE TABLE [Товары] (
	[Код_товара] int IDENTITY(1,1) NOT NULL,
	[Название] nvarchar(max) NOT NULL DEFAULT '100',
	[Цена] decimal(18,0) NOT NULL,
	[Описание] nvarchar(max),
	[Код_категории] int,
	PRIMARY KEY ([Код_товара])
);

CREATE TABLE [Заказы] (
	[Код_клиента] int IDENTITY(1,1) NOT NULL,
	[Код_товара] int IDENTITY(1,1) NOT NULL,
	[Дата] date NOT NULL,
	[Количество] int,
	[Отпускная_цена] decimal(18,0),
	PRIMARY KEY ([Код_клиента], [Код_товара], [Дата])
);



ALTER TABLE [Товары] ADD CONSTRAINT [Товары_fk4] FOREIGN KEY ([Код_категории]) REFERENCES [Категории]([Код_категории]);
ALTER TABLE [Заказы] ADD CONSTRAINT [Заказы_fk0] FOREIGN KEY ([Код_клиента]) REFERENCES [Клиенты]([Код_клиента]);

ALTER TABLE [Заказы] ADD CONSTRAINT [Заказы_fk1] FOREIGN KEY ([Код_товара]) REFERENCES [Товары]([Код_товара]);