# Regex Basics Training for SOC Analysts and Engineers

Welcome to the **Regex Basics Training** repository! This training is designed to introduce SOC analysts and engineers to the fundamentals of Regular Expressions (Regex) and how they can be leveraged in cybersecurity operations for log analysis, alert tuning, and incident response.

---

## **Overview**

### **What is Regex?**
Regular Expressions (Regex) are patterns used to search, match, and manipulate text. Think of them as powerful search filters that allow you to extract specific data from logs, emails, and files.

### **Why Regex in Cybersecurity?**
- **Log Analysis:** Identify suspicious patterns in logs.
- **Alert Tuning:** Refine SIEM rules to reduce false positives.
- **Incident Response:** Extract IOCs (Indicators of Compromise) from raw data.

---

## **How to Use This Repository**

### **1. Prerequisites**
- Ensure you have **PowerShell** installed on your system.
- Have a Microsoft Teams **Attendance Report** (CSV format) downloaded.

---

### **2. Generate Practice Files**

Run the provided script to generate practice files for your team:

```powershell
cd scripts
.\generate_regex_practice.ps1
```

The script will prompt you to select the attendance CSV or automatically detect it from your Downloads folder.

It will create a zip file in your Downloads folder named **RegexPractice.zip**, containing individual text files for each team member with name variations for regex practice.

---

### **3. Hands-On Activity**
- **Distribute the Zip File:** Share RegexPractice.zip with all participants.
- Open Their Files: Each team member will locate their .txt file (named after them) and practice crafting regex patterns to match all variations inside.
- Reveal the Answer:
- At the bottom of each file is a Base64 encoded regex answer.

---
##  OPSEC Consideration
- When testing regex patterns, do not upload sensitive or internal data to third-party platforms like `regex101[.]com`. 
- Always sanitize data or use internal tools to ensure security protocols are maintained.

