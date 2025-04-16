DELETE FROM BankingData
WHERE age IS NULL OR job IS NULL OR y IS NULL;
UPDATE BankingData
SET job = TRIM(REPLACE(job, '"', '')),
    marital = TRIM(REPLACE(marital, '"', '')),
    education = TRIM(REPLACE(education, '"', '')),
    contact = TRIM(REPLACE(contact, '"', '')),
    month = TRIM(REPLACE(month, '"', '')),
    poutcome = TRIM(REPLACE(poutcome, '"', '')),
    y = TRIM(REPLACE(y, '"', ''));
SELECT TOP 10 * 
FROM 
	BankingData;
SELECT 
	COUNT(*) AS TotalRows FROM BankingData;