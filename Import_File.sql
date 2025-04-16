USE BankProject;
GO
BULK INSERT BankingData
FROM 'C:\Users\Dat Go\OneDrive\Documents\BankProjects\Banking_Dataset_Marketing_Targets\train.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '0x0a',
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ERRORFILE = 'C:\Users\Dat Go\OneDrive\Documents\BankProjects\BulkInsertErrors.txt'
);
