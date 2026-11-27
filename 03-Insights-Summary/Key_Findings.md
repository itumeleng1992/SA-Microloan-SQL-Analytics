# Executive Insights & Credit Policy Recommendations
**Project:** South African Microloan Funnel & Credit Risk Analysis  

---

## 1. Key Findings from SQL Analysis
* **70% Total Approval Rate:** 50% of applicants were `Auto_Approved` and 20% were `Compliance_Approved`, while funnel abandonment dropped to **20%** (close to our <18% target).
* **SLA Bottleneck in Compliance Queue:** Automated approvals averaged **8.70 minutes** (well inside the 15-minute target), whereas applications routed to the manual Compliance Queue averaged **40.25 minutes**.
* **High DTI Drives Early Arrears:** Every disbursed loan currently in `Arrears_30_Days` or `Defaulted` status came from an applicant with a **Debt-to-Income (DTI) ratio above 41%**.

## 2. Actionable Business Recommendations
1. **Tighten Automated DTI Cap (NCA Rule):** Set the automated approval threshold at **DTI ≤ 40%** so higher-risk applicants receive smaller counter-offers rather than full loan amounts.
2. **Automate Secondary KYC Checks:** Review why 20% of applications fell into the manual Compliance Queue (e.g., selfie lighting retries) to reduce the 40.25-minute manual review bottleneck.
3. **Targeted Drop-Off Reminders:** Trigger automated SMS/WhatsApp reminders for applicants who pause at `2_Biometric_KYC` or `3_Open_Banking`.
