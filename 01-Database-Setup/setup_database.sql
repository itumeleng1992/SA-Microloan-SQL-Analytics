-- ============================================================================
-- File: 01-Database-Setup/setup_database.sql
-- Description: Creates database, 3 tables, and sample South African loan data
-- ============================================================================

CREATE DATABASE SA_Microloan_DB;
GO

USE SA_Microloan_DB;
GO

-- 1. Create Applicants Table
CREATE TABLE Applicants (
    applicant_id INT PRIMARY KEY,
    province VARCHAR(50),
    employment_type VARCHAR(30),
    monthly_net_income DECIMAL(10, 2),
    existing_monthly_debt DECIMAL(10, 2)
);

-- 2. Create Loan Applications Table
CREATE TABLE Loan_Applications (
    application_id INT PRIMARY KEY,
    applicant_id INT FOREIGN KEY REFERENCES Applicants(applicant_id),
    requested_amount DECIMAL(10, 2),
    highest_stage_reached VARCHAR(40),
    decision_status VARCHAR(30),
    turnaround_minutes DECIMAL(6, 2)
);

-- 3. Create Disbursed Loans Table
CREATE TABLE Loans_Disbursed (
    loan_id INT PRIMARY KEY,
    application_id INT FOREIGN KEY REFERENCES Loan_Applications(application_id),
    approved_amount DECIMAL(10, 2),
    repayment_status VARCHAR(25)
);

-- 4. Insert Sample Data
INSERT INTO Applicants VALUES
(1001, 'Gauteng',       'Permanent',     18500.00, 4200.00),
(1002, 'Western Cape',  'Permanent',     24000.00, 5100.00),
(1003, 'KwaZulu-Natal', 'Contract',      11500.00, 4800.00),
(1004, 'Gauteng',       'Self-Employed', 14000.00, 6900.00),
(1005, 'Eastern Cape',  'Permanent',      9800.00, 2100.00),
(1006, 'Gauteng',       'Permanent',     31000.00, 7500.00),
(1007, 'Limpopo',       'Contract',       8500.00, 3900.00),
(1008, 'Western Cape',  'Self-Employed', 16200.00, 3400.00),
(1009, 'KwaZulu-Natal', 'Permanent',     15000.00, 6200.00),
(1010, 'Mpumalanga',    'Permanent',     13200.00, 2800.00);

INSERT INTO Loan_Applications VALUES
(5001, 1001, 4500.00, '4_Decisioned',    'Auto_Approved',        8.50),
(5002, 1002, 6000.00, '4_Decisioned',    'Auto_Approved',        6.20),
(5003, 1003, 3000.00, '4_Decisioned',    'Compliance_Approved', 42.00),
(5004, 1004, 5000.00, '4_Decisioned',    'Declined',            11.40),
(5005, 1005, 2500.00, '2_Biometric_KYC', 'Abandoned',            NULL),
(5006, 1006, 8000.00, '4_Decisioned',    'Auto_Approved',        7.10),
(5007, 1007, 2000.00, '3_Open_Banking',  'Abandoned',            NULL),
(5008, 1008, 4000.00, '4_Decisioned',    'Compliance_Approved', 38.50),
(5009, 1009, 3500.00, '4_Decisioned',    'Auto_Approved',       12.30),
(5010, 1010, 3000.00, '4_Decisioned',    'Auto_Approved',        9.40);

INSERT INTO Loans_Disbursed VALUES
(9001, 5001, 4500.00, 'Paid_In_Full'),
(9002, 5002, 6000.00, 'Current'),
(9003, 5003, 2500.00, 'Arrears_30_Days'),
(9004, 5006, 8000.00, 'Paid_In_Full'),
(9005, 5008, 3500.00, 'Current'),
(9006, 5009, 3500.00, 'Defaulted'),
(9007, 5010, 3000.00, 'Paid_In_Full');
GO
