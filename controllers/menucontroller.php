<?php
require_once __DIR__ . '/../config/Database.php';

/**
 * Menu Controller
 * Handles fetching and grouping large datasets to optimize server load.
 */
class MenuController {
    private $db;

    public function __construct() {
        $this->db = new Database();
    }

    /**
     * Fetches all categories and products in exactly 2 queries,
     * then structures them in PHP memory for optimal frontend rendering.
     * * @return array Grouped multidimensional array of menu items
     */
    public function getGroupedMenu() {
        // Fetch active categories sorted by order
        $categories = $this->db->query("SELECT * FROM kategoriler WHERE status = 1 ORDER BY sort_order ASC");

        // Fetch active products sorted by order
        $all_products = $this->db->query("SELECT * FROM urunler WHERE status = 1 ORDER BY sort_order ASC");

        // Group products by category ID to prevent recursive DB calls in the View
        $grouped_products = [];
        foreach ($all_products as $product) {
            $grouped_products[$product['category_id']][] = $product;
        }

        return [
            'categories' => $categories,
            'grouped_products' => $grouped_products
        ];
    }
}
?>