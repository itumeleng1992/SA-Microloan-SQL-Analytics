-- ============================================================================
-- File: 02-Business-Queries/funnel_and_risk_queries.sql
-- Description: Business intelligence queries for funnel conversion, SLA & risk
-- ============================================================================

USE SA_Microloan_DB;
GO

-- ----------------------------------------------------------------------------
-- QUERY 1: Onboarding Funnel & Decision Breakdown
-- Business Question: How many applications were approved, declined, or abandoned?
-- ----------------------------------------------------------------------------
SELECT 
    decision_status,
    COUNT(*) AS total_applications,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Loan_Applications) AS DECIMAL(5,2)) AS percentage_share
FROM Loan_Applications
GROUP BY decision_status
ORDER BY total_applications DESC;


-- ----------------------------------------------------------------------------
-- QUERY 2: Turnaround Time (SLA Performance: < 15 Minutes Target)
-- Business Question: Are automated approvals meeting the 15-minute SLA vs. Compliance Queue?
-- ----------------------------------------------------------------------------
SELECT 
    decision_status,
    COUNT(*) AS application_count,
    CAST(AVG(turnaround_minutes) AS DECIMAL(6,2)) AS avg_turnaround_mins,
    CASE 
        WHEN AVG(turnaround_minutes) <= 15 THEN 'Meets <15m SLA'
        ELSE 'Breaches SLA (Manual Queue)'
    END AS sla_status
FROM Loan_Applications
WHERE turnaround_minutes IS NOT NULL
GROUP BY decision_status;


-- ----------------------------------------------------------------------------
-- QUERY 3: Credit Risk by Debt-to-Income (DTI) Ratio (NCA Affordability Check)
-- Business Question: Do applicants with higher existing debt have higher arrears/defaults?
-- ----------------------------------------------------------------------------
SELECT 
    a.applicant_id,
    a.province,
    a.employment_type,
    a.monthly_net_income,
    a.existing_monthly_debt,
    CAST((a.existing_monthly_debt / a.monthly_net_income) * 100 AS DECIMAL(5,2)) AS dti_percentage,
    l.approved_amount,
    l.repayment_status
FROM Applicants a
JOIN Loan_Applications app ON a.applicant_id = app.applicant_id
JOIN Loans_Disbursed l ON app.application_id = l.application_id
ORDER BY dti_percentage DESC;
GO
