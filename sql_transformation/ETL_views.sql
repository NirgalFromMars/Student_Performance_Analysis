SELECT TOP 10 * FROM Student_Performance;

-- corregimos la columna Performance_Index ya que no ha interpretado el punto "." al importarla como float
UPDATE Student_Performance
SET Performance_Index = Performance_Index / 10.0;

-- consultar tipos de datos de cada columna
EXEC sp_help 'Student_Performance';

-- EXPLORACION
-- buscar valores nulos
SELECT 
    SUM(CASE WHEN Hours_Studied IS NULL THEN 1 ELSE 0 END) AS Null_Hours_Studied,
    SUM(CASE WHEN Previous_Scores IS NULL THEN 1 ELSE 0 END) AS Null_Previous_Scores,
    SUM(CASE WHEN Extracurricular_Activities IS NULL THEN 1 ELSE 0 END) AS Null_Activities,
    SUM(CASE WHEN Sleep_Hours IS NULL THEN 1 ELSE 0 END) AS Null_Sleep_Hours,
    SUM(CASE WHEN Sample_Question_Papers_Practiced IS NULL THEN 1 ELSE 0 END) AS Null_Questions_Practiced,
    SUM(CASE WHEN Performance_Index IS NULL THEN 1 ELSE 0 END) AS Null_Performance_Index
FROM Student_Performance;

-- buscar valores atípicos
SELECT 
    MIN(Hours_Studied) AS Min_Hours,
    MAX(Hours_Studied) AS Max_Hours,
    AVG(Hours_Studied) AS Avg_Hours,
    
    MIN(Sleep_Hours) AS Min_Sleep,
    MAX(Sleep_Hours) AS Max_Sleep,
    AVG(Sleep_Hours) AS Avg_Sleep,
    
    MIN(Previous_Scores) AS Min_Prev,
    MAX(Previous_Scores) AS Max_Prev,
    AVG(Previous_Scores) AS Avg_Prev,

	MIN(Sample_Question_Papers_Practiced) AS Min_Questions,
    MAX(Sample_Question_Papers_Practiced) AS Max_Questions,
    AVG(Sample_Question_Papers_Practiced) AS Avg_Questions,

	MIN(Performance_Index) AS Min_Index,
    MAX(Performance_Index) AS Max_Index,
    AVG(Performance_Index) AS Avg_Index
FROM Student_Performance;


-- creamos una vista con los datos float de Performance_Level corregidos, los de Extracurricular_Activities como etiquetas, añadiendo
-- una columna categórica sobre el Performance_Level (>80 High, >60 Medium y <60 Low) y varias columnas categorizadas a partir de las
-- variables numéricas de algunos campos
CREATE VIEW vw_StudentPerformance_Base AS
SELECT
    Hours_Studied,
	-- Categorización de horas de estudio
    CASE 
        WHEN Hours_Studied < 1 THEN '0–1h'
        WHEN Hours_Studied < 3 THEN '1–3h'
        WHEN Hours_Studied < 5 THEN '3–5h'
        ELSE '5h+'
    END AS Study_Bracket,
    Previous_Scores,
	-- Categorización de nota previa
    CASE 
        WHEN Previous_Scores < 50 THEN '<50'
        WHEN Previous_Scores < 70 THEN '50–69'
        WHEN Previous_Scores < 85 THEN '70–84'
        ELSE '85+'
    END AS Prev_Score_Bracket,
    Extracurricular_Activities,
    CASE 
        WHEN Extracurricular_Activities = 1 THEN 'Yes'
        ELSE 'No'
    END AS Extracurricular_Label,
    Sleep_Hours,
	CASE 
        WHEN Sleep_Hours < 4 THEN '<4h'
        WHEN Sleep_Hours < 6 THEN '4–6h'
        WHEN Sleep_Hours < 8 THEN '6–8h'
        ELSE '8h+'
    END AS Sleep_Bracket,
    Sample_Question_Papers_Practiced,
    Performance_Index,
    
    -- Clasificación simple del rendimiento (se pueden ajustar los rangos)
    CASE 
        WHEN Performance_Index >= 85 THEN 'High'
        WHEN Performance_Index >= 60 THEN 'Medium'
        ELSE 'Low'
    END AS Performance_Level
FROM Student_Performance;

SELECT TOP 10 * FROM vw_StudentPerformance_Base



-- creamos una 2ª vista con un resumen agrupado, muestra la distribución de estudiantes por combinaciones de hábitos y notas previas
CREATE VIEW vw_StudentPerformance_Categorized AS
WITH Categorized AS (
    SELECT 
        -- Categorización de horas de estudio
        CASE 
            WHEN Hours_Studied < 1 THEN '0–1h'
            WHEN Hours_Studied < 3 THEN '1–3h'
            WHEN Hours_Studied < 5 THEN '3–5h'
            ELSE '5h+'
        END AS Study_Bracket,

        -- Categorización de horas de sueño
        CASE 
            WHEN Sleep_Hours < 4 THEN '<4h'
            WHEN Sleep_Hours < 6 THEN '4–6h'
            WHEN Sleep_Hours < 8 THEN '6–8h'
            ELSE '8h+'
        END AS Sleep_Bracket,

        -- Categorización de nota previa
        CASE 
            WHEN Previous_Scores < 50 THEN '<50'
            WHEN Previous_Scores < 70 THEN '50–69'
            WHEN Previous_Scores < 85 THEN '70–84'
            ELSE '85+'
        END AS Prev_Score_Bracket
    FROM Student_Performance
)
-- Ejemplo: distribución por cada categoría individual
SELECT 
    Study_Bracket,
    Sleep_Bracket,
    Prev_Score_Bracket,
    COUNT(*) AS Count_Students
FROM Categorized
GROUP BY 
    Study_Bracket, Sleep_Bracket, Prev_Score_Bracket

SELECT TOP 10 * FROM vw_StudentPerformance_Categorized