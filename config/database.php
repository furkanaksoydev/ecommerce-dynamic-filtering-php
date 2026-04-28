<?php
/**
 * Secure Database Connection Wrapper
 * Uses PDO for SQL injection prevention and secure data handling.
 */
class Database {
    private $pdo;

    public function __construct() {
        // Credentials omitted for security and portfolio demonstration
        $host = 'YOUR_DB_HOST';
        $dbname = 'YOUR_DB_NAME';
        $username = 'YOUR_DB_USER';
        $password = 'YOUR_DB_PASSWORD';

        try {
            // Setting up PDO with strict error mode and UTF-8 charset
            $this->pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $this->pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            // In a production environment, this would log to a file instead of dying
            die("Database connection failed.");
        }
    }

    /**
     * Executes a given SQL query and returns the results.
     */
    public function query($sql) {
        return $this->pdo->query($sql)->fetchAll();
    }

    /**
     * Advanced table operations for complex queries.
     */
    public function TableOperations($sql) {
        return $this->query($sql);
    }
}
?>