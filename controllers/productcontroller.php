<?php
require_once __DIR__ . '/../config/Database.php';

/**
 * Product Controller
 * Handles complex product retrieval, image aggregation, and dynamic stock sorting.
 */
class ProductController {
    private $db;

    public function __construct() {
        $this->db = new Database();
    }

    /**
     * Retrieves products with their related image galleries in a SINGLE query.
     * Uses GROUP_CONCAT to prevent N+1 query problems.
     * Automatically pushes out-of-stock ('yok') items to the end of the array.
     * * @param string $categoryTable The dynamic table name for the category (e.g., 'kolye')
     * @return array Array of products with their aggregated images
     */
    public function getProductsWithGalleries($categoryTable) {
        $sql = "
            SELECT 
                u.*, 
                (
                    SELECT GROUP_CONCAT(Urun_Resim) 
                    FROM {$categoryTable}_resimler 
                    WHERE {$categoryTable}_resimler.Urun_Ad = u.Urun_Ad
                ) AS tum_resimler
            FROM {$categoryTable} u
            ORDER BY 
                CASE WHEN u.Urun_Stok = 'var' THEN 0 ELSE 1 END,
                u.Urun_Ad ASC
        ";

        return $this->db->TableOperations($sql);
    }
}
?>