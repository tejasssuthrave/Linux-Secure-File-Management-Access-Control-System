# Linux Secure File Management & Access Control System

## 📌 Project Overview

This project demonstrates a Linux-based secure file management system designed to simulate real-world enterprise server administration practices. The system enforces role-based access control (RBAC), advanced file permissions, Access Control Lists (ACL), automated file validation, and file lifecycle management.

The objective of this project is to strengthen practical knowledge of Linux file handling, permissions, user management, and automation.

---

## 🚀 Key Features

✔ Role-Based Access Control (RBAC)  
✔ Secure Directory Structure  
✔ Linux File Permissions & Ownership  
✔ Access Control Lists (ACL)  
✔ Automated File Validation (Shell Script)  
✔ Cron-Based Automation  
✔ File Lifecycle Management  
✔ Permission Troubleshooting  

---

## 🏗 System Architecture

**Workflow:**

Users → Incoming Directory → Validation Script → Approved Directory → Archive System

- **Editors** upload files  
- **Root/System** validates files  
- **Viewers** access approved files  

---

## 📂 Directory Structure

```
/project_storage
    /incoming     → File upload zone
    /approved     → Validated secure storage
    /archive      → Archived files
    /logs         → System logs
```

---

## 🛠 Technologies & Linux Concepts Used

- Linux File Permissions (`chmod`)
- File Ownership (`chown`)
- User & Group Management (`useradd`, `groupadd`)
- Access Control Lists (`setfacl`, `getfacl`)
- Shell Scripting (Bash)
- Cron Job Automation
- File Handling (`mv`, `rm`, `find`)

---

## ⚙️ Setup & Configuration

### 1️⃣ Create Project Directories

```bash
sudo mkdir -p /project_storage/{incoming,approved,archive,logs}
```

---

### 2️⃣ Create Users & Groups

```bash
sudo groupadd editors
sudo groupadd viewers

sudo useradd editor1
sudo useradd viewer1
```

Assign groups:

```bash
sudo usermod -aG editors editor1
sudo usermod -aG viewers viewer1
```

---

### 3️⃣ Configure Permissions

Incoming Directory:

```bash
sudo chown root:editors /project_storage/incoming
sudo chmod 770 /project_storage/incoming
```

Approved Directory:

```bash
sudo chown root:viewers /project_storage/approved
sudo chmod 750 /project_storage/approved
```

Archive Directory:

```bash
sudo chmod 700 /project_storage/archive
```

---

### 4️⃣ Apply ACL Rules

```bash
sudo setfacl -m u:editor1:rwx /project_storage/incoming
sudo setfacl -m u:viewer1:rx /project_storage/approved
```

Verify:

```bash
getfacl /project_storage/incoming
```

---

## 📜 File Validation Script

**Location:** `/usr/local/bin/validate.sh`

```bash
#!/bin/bash

for file in /project_storage/incoming/*; do

    if [[ "$file" == *.tar.gz ]]; then
        mv "$file" /project_storage/approved/
    else
        rm "$file"
    fi

done
```

Make executable:

```bash
chmod 755 /usr/local/bin/validate.sh
```

---

## ⏱ Automation (Cron Jobs)

Run validation every 5 minutes:

```bash
*/5 * * * * /usr/local/bin/validate.sh
```

Auto archive files older than 7 days:

```bash
0 0 * * * find /project_storage/approved -mtime +7 -exec mv {} /project_storage/archive \;
```

---

## ✅ Testing Procedure

1. Login as **editor1**
2. Upload files to `/incoming`
3. Run validation script (or wait for cron)
4. Verify valid files move to `/approved`
5. Verify invalid files are removed
6. Login as **viewer1** and test read-only access

---

## 🎯 Learning Outcomes

This project strengthened practical skills in:

✅ Linux file permissions & ownership  
✅ Role-based access control  
✅ Access Control Lists (ACL)  
✅ Shell scripting & automation  
✅ Cron job scheduling  
✅ Secure file handling practices  
✅ Linux permission troubleshooting  

---

## 📌 Conclusion

This project simulates real-world Linux administration tasks involving secure file storage, permission enforcement, automation, and system design. It reflects core competencies required for Linux Administration, DevOps, Cloud, and Security roles.

---
