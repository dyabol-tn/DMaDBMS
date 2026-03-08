CREATE TABLE [Модели] (
	[Код_модели] int IDENTITY(1,1) NOT NULL,
	[Название] nvarchar(50) NOT NULL,
	[Год_создания] date NOT NULL,
	[Двигатель] nvarchar(20) NOT NULL,
	[Тип_кузова] nvarchar(30) NOT NULL,
	[Дополнительная_комплектация] nvarchar(max),
	PRIMARY KEY ([Код_модели])
);

CREATE TABLE [Детали] (
	[Код_детали] int IDENTITY(1,1) NOT NULL,
	[Код_производителя] int NOT NULL,
	[Наименование] nvarchar(50) NOT NULL,
	[Стоимость] decimal(18,0),
	[Характеристики] nvarchar(max),
	PRIMARY KEY ([Код_детали])
);

CREATE TABLE [Автомобили] (
	[Код_автомобиля(VIN)] nvarchar(17) NOT NULL,
	[Код_модели] int NOT NULL,
	[Цвет] nvarchar(30) NOT NULL,
	[Наличие] bit NOT NULL,
	[Дата_выпуска] date NOT NULL,
	PRIMARY KEY ([Код_автомобиля(VIN)])
);

CREATE TABLE [Производители_деталей] (
	[Код_производителя] int IDENTITY(1,1) NOT NULL,
	[Парт_номер] nvarchar(max) NOT NULL DEFAULT '20',
	[Название] nvarchar(max) NOT NULL DEFAULT '50',
	[Страна] nvarchar(max) DEFAULT '50',
	PRIMARY KEY ([Код_производителя])
);

CREATE TABLE [Склады_деталей] (
	[Код_склада] int IDENTITY(1,1) NOT NULL,
	[Название] nvarchar(50) NOT NULL,
	[Особые_отметки] nvarchar(max),
	PRIMARY KEY ([Код_склада])
);

CREATE TABLE [Остатки_деталей] (
	[Код_остатка] int IDENTITY(1,1) NOT NULL,
	[Код_детали] int NOT NULL,
	[Код_склада] int NOT NULL,
	[Количество] int NOT NULL,
	PRIMARY KEY ([Код_остатка])
);

CREATE TABLE [Состав_автомобиля] (
	[Код_автомобиля(VIN)] nvarchar(17) NOT NULL,
	[Код_детали] int NOT NULL,
	[Использовано_деталей] int NOT NULL,
	PRIMARY KEY ([Код_автомобиля(VIN)], [Код_детали])
);


ALTER TABLE [Детали] ADD CONSTRAINT [Детали_fk1] FOREIGN KEY ([Код_производителя]) REFERENCES [Производители_деталей]([Код_производителя]);
ALTER TABLE [Автомобили] ADD CONSTRAINT [Автомобили_fk1] FOREIGN KEY ([Код_модели]) REFERENCES [Модели]([Код_модели]);


ALTER TABLE [Остатки_деталей] ADD CONSTRAINT [Остатки_деталей_fk1] FOREIGN KEY ([Код_детали]) REFERENCES [Детали]([Код_детали]);

ALTER TABLE [Остатки_деталей] ADD CONSTRAINT [Остатки_деталей_fk2] FOREIGN KEY ([Код_склада]) REFERENCES [Склады_деталей]([Код_склада]);
ALTER TABLE [Состав_автомобиля] ADD CONSTRAINT [Состав_автомобиля_fk0] FOREIGN KEY ([Код_автомобиля(VIN)]) REFERENCES [Автомобили]([Код_автомобиля(VIN)]);

ALTER TABLE [Состав_автомобиля] ADD CONSTRAINT [Состав_автомобиля_fk1] FOREIGN KEY ([Код_детали]) REFERENCES [Детали]([Код_детали]);