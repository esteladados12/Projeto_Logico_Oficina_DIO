CREATE DATABASE Oficina;
USE Oficina;

-- Criar tabela Clientes
CREATE TABLE Clients(
idClient INT AUTO_INCREMENT primary key,
Fname VARCHAR (15),
Lname VARCHAR (30),
CPF CHAR (11),
Telephone CHAR (11) not null unique,
Address VARCHAR (255)
);

desc Clients;

-- Criar tabela Veículos
CREATE TABLE Vehicles(
idVehicle INT AUTO_INCREMENT primary key,
idVehicleClient INT,
Model VARCHAR(45) not null,
Plate CHAR (8) not null unique,
CONSTRAINT fk_vehicle_client foreign key (idVehicleClient) REFERENCES Clients(idClient)
);

desc Vehicles;


-- Criar tabela Equipe_Mecânicos
CREATE TABLE Mechanics(
idMechanic INT AUTO_INCREMENT primary key,
Name VARCHAR (45) not null,
Address VARCHAR (255),
Telephone CHAR (11) not null,
Specialty VARCHAR (45)
);

desc Mechanics;


-- Criar tabela Ordem de Serviço
CREATE TABLE ServiceOrder(
idOrder INT AUTO_INCREMENT primary key,
idOrderVehicle INT,
IssueDate DATE not null,
TotalValue FLOAT not null,
Status ENUM('Para avaliar', 'Aguardando peças', 'Em conserto', 'Finalizado') default 'Para avaliar',
FinishDate DATE, 
CONSTRAINT fk_order_vehicle FOREIGN KEY (idOrderVehicle) references Vehicles (idVehicle)
);

desc ServiceOrder;


-- Criar tabela Serviços
CREATE TABLE ServiceReference(
idService INT AUTO_INCREMENT primary key, 
Description VARCHAR(255) not null,
LaborValue FLOAT not null
);

desc ServiceReference;


-- Criar tabela Peças
CREATE TABLE OrderItems(
idOIOrder INT,
idOIService INT not null,
idOIPart INT,
Quantity INT default 1,
PRIMARY KEY (idOIOrder, idOIService),
CONSTRAINT fk_items_order foreign key (idOIOrder) REFERENCES ServiceOrder (idOrder),
CONSTRAINT fk_items_service foreign key (idOIService) REFERENCES ServiceReference (idService)
); 

desc OrderItems;

ALTER TABLE ServiceOrder 
ADD COLUMN idOrderMechanic INT,
ADD CONSTRAINT fk_order_mechanic FOREIGN KEY (idOrderMechanic) REFERENCES Mechanics(idMechanic);
