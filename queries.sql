
	-- Nível Baixo (Foco em SELECT, WHERE e ORDER BY)

-- Listagem de Clientes: Recupere o nome completo (Fname e Lname) e o telefone de todos os clientes, ordenados alfabeticamente pelo nome.
SELECT
CONCAT(Fname, ' ', Lname) as Nome, 
Telephone as Telefone
from Clients
order by Nome asc; 


-- Filtro de Especialidade: Quais são os nomes e telefones de todos os mecânicos cuja especialidade seja "Motores"?
SELECT
Name as Nome, 
Telephone as Telefone
from Mechanics
where 
Specialty = 'Motores';


-- Status de Veículos: Liste a placa e o modelo de todos os veículos que pertencem ao cliente com o idClient = 1.
SELECT
Model as Modelo,
Plate as Placa
from Vehicles
WHERE
idVehicleClient = 1;



-- Ordens Recentes: Recupere todas as Ordens de Serviço (OS) que foram emitidas após o dia 10 de fevereiro de 2026.
SELECT
SO.idOrder as ID_Pedido,
SO.IssueDate as Data_Entrada,
SO.Status as Status,
M.Name as Mecânico
FROM ServiceOrder SO
INNER JOIN Mechanics M on M.idMechanic = SO.idOrderMechanic 
where IssueDate >= '2026-02-10';



-- Peças Caras: Liste todas as peças que custam mais de R$ 100,00, mostrando o nome e o valor.

select
Description as Peça,
PartValue as Preço
from Parts
where 
PartValue >= 100;




	-- Nível Médio (Foco em JOINs e Agregações Simples)

-- Dono do Carro: Gere um relatório com o Modelo do Veículo, a Placa e o Nome Completo do seu respectivo proprietário.
SELECT
CONCAT(C.Fname, ' ',C.Lname) as Cliente,
V.Model as Modelo_carro,
V.Plate as Placa_carro
FROM Clients C
INNER JOIN Vehicles V on V.idVehicleClient = C.idClient
order by Cliente asc;


-- Resumo por Status: Quantas Ordens de Serviço existem para cada Status (ex: quantos "Em conserto", quantos "Finalizados")?
SELECT
Status as Status,
COUNT(Status) as Total
from ServiceOrder
group by Status;


-- Mão de Obra e Peças: Liste o ID da Ordem de Serviço, a descrição do serviço realizado e a descrição da peça utilizada naquela linha da OS.
SELECT 
SO.idOrder AS Numero_OrdemServiço,
SR.Description AS Serviço,
P.Description AS Peça
FROM ServiceOrder SO 
LEFT JOIN OrderItems OI ON SO.idOrder = OI.idOIOrder
LEFT JOIN ServiceReference SR ON OI.idOIService = SR.idService
LEFT JOIN Parts P ON OI.idOIPart = P.idPart;


-- Produtividade Simples: Qual é o valor total já faturado (soma de TotalValue) por cada mecânico? Mostre o nome do mecânico e o total.
select
M.idMechanic as id_Mecânico,
M.Name as Nome,
M.Specialty as Especialidade,
COUNT(SO.idOrder) as Serviços,
COALESCE(SUM(SO.TotalValue), 0) as Faturamento
from Mechanics M
LEFT JOIN ServiceOrder SO on M.idMechanic = SO.idOrderMechanic
Group by id_Mecânico, Nome
Order by Faturamento desc;


-- Serviços mais Procurados: Quais são os 3 serviços (ServiceReference) mais realizados na oficina até agora?
SELECT
SR.Description as Serviço,
SR.LaborValue as Valor,
COUNT(OI.idOIService) as Recorrência
from ServiceReference SR
INNER JOIN OrderItems OI on SR.idService = OI.idOIService
Group by Serviço, Valor
limit 3;


	-- Nível Alto (Foco em Complexidade, Filtros Agrupados e Lógica de Negócio)

-- Faturamento por Cliente: Liste os nomes dos clientes e o valor total que cada um já gastou na oficina (apenas para aqueles que gastaram mais de R$ 500,00 no total).
SELECT 
SO.idOrder AS Ordem_ID,
SO.TotalValue AS Valor_Total_Pago,
COALESCE(SUM(P.PartValue), 0) AS Custo_Total_Peças,
(SO.TotalValue - COALESCE(SUM(P.PartValue), 0)) AS Margem
FROM ServiceOrder SO
LEFT JOIN OrderItems OI ON SO.idOrder = OI.idOIOrder
LEFT JOIN Parts P ON OI.idOIPart = P.idPart
GROUP BY 
SO.idOrder, SO.TotalValue
ORDER BY 
Margem DESC;


-- Mecânicos Ociosos ou Atarefados: Liste todos os mecânicos e a quantidade de ordens de serviço que eles possuem com status "Em conserto" ou "Para avaliar".
SELECT
M.Name as Mecânico,
M.Specialty as Especialidade, 
SO.IssueDate as DataEntrada,  
SO.Status as Status
from Mechanics M
INNER JOIN ServiceOrder SO on M.idMechanic = SO.idOrderMechanic
WHERE
SO.Status = 'Em conserto' or SO.Status = 'Para avaliar';


-- Gere um relatório que mostre o Nome do Cliente e o Modelo do Carro de todas as ordens que custaram mais de R$ 500,00, ordenando do mais caro para o mais barato.
SELECT
CONCAT(C.Fname, ' ', C.Lname) as Cliente, 
V.Model as Modelo_Veículo,
V.Plate as Placa_Veículo, 
SUM(SO.TotalValue) as Valor_Gasto
FROM Clients C
INNER JOIN Vehicles V on V.idVehicleClient = C.idClient 
INNER JOIN ServiceOrder SO on SO.idOrderVehicle = V.idVehicle
Group by Cliente, Modelo_Veículo, Placa_Veículo
HAVING Valor_Gasto >= 500
ORDER BY Valor_Gasto desc;




