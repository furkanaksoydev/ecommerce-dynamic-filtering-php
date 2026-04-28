<h1 align="center">⚙️ E-Commerce & SaaS Backend Architecture</h1>

<p align="center">
  <img src="https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white" />
  <img src="https://img.shields.io/badge/MySQL-00000F?style=for-the-badge&logo=mysql&logoColor=white" />
  <img src="https://img.shields.io/badge/Architecture-MVC%20Ready-success?style=for-the-badge" />
</p>

### 📌 About This Showcase
This repository contains the core backend logic and database architectural approach for custom-built, high-performance platforms (E-Commerce and Restaurant SaaS). It demonstrates how I handle complex database relationships, query optimization, and data structuring without relying on CMS templates (like WordPress).

> **⚠️ Note:** This is a partial repository for portfolio demonstration purposes only. Full application source code and security credentials are kept private.

### 🧠 Core Engineering Principles Demonstrated

#### 1. Advanced SQL Queries (`ProductController.php`)
- **Subquery & Aggregation:** Utilizes `GROUP_CONCAT` inside subqueries to fetch a product and its entire image gallery in a single database hit, significantly reducing server load.
- **Dynamic Sorting:** Implements `CASE WHEN` logic in the `ORDER BY` clause to automatically push out-of-stock items to the bottom of the list dynamically.

#### 2. N+1 Query Problem Avoidance (`MenuController.php`)
- **Data Structuring in PHP:** Instead of querying the database recursively for every category in a loop (which crashes performance), the system fetches all categories and products in exactly two queries. It then efficiently groups the data into a multidimensional array in PHP memory.

#### 3. Secure Database Abstraction (`Database.php`)
- **PDO Implementation:** Utilizes PHP Data Objects (PDO) for secure, SQL-injection-resistant database interactions.

---
<p align="center">
  <i>Copyright &copy; 2026 Furkan. All Rights Reserved.</i><br>
</p>
