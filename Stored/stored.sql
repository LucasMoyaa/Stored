CREATE TABLE Alunos ( --CRIAÇÃO DA TABELA ALUNOS FACULDADE
id_aluno       INT PRIMARY KEY, 
nome           VARCHAR(100), 
email          VARCHAR(100), 
curso_id       INT, 
FOREIGN KEY (curso_id) REFERENCES Cursos(id_curso) 
);

--INSERÇÃO DE CURSOS
CREATE PROCEDURE InserirCurso( @nome VARCHAR(100), @descricao TEXT, @duracao INT) AS BEGIN 
INSERT INTO Cursos (nome, descricao, duracao) 
VALUES (@nome, @descricao, @duracao); END;

--SELEÇÃO DE CURSOS 
CREATE PROCEDURE SelecionarCursos AS BEGIN SELECT * FROM Cursos; 
END;

--FUNÇÃO DO EMAIL ALUNO

CREATE FUNCTION GerarEmailAluno( @nome VARCHAR(100), @sobrenome VARCHAR(100)) 
RETURNS VARCHAR(100) AS BEGIN DECLARE @email VARCHAR(100); 
DECLARE @contador INT;

SET @contador = 1;
SET @email = LOWER(CONCAT(@nome, '.', @sobrenome, '@dominio.com'));

-- VERIFICAÇÃO SE JA EXISTE
WHILE EXISTS (SELECT 1 FROM Alunos WHERE email = @email)
BEGIN
    SET @contador = @contador + 1;
    SET @email = LOWER(CONCAT(@nome, '.', @sobrenome, @contador, '@dominio.com'));
END;

RETURN @email;
END;