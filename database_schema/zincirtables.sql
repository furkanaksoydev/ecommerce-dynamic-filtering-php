-- ==============================================================================
-- E-Commerce Core Database Schema Showcase
-- Engine: InnoDB | Charset: utf8mb4
-- Demonstrates relational data modeling for categories, products, and media.
-- ==============================================================================

-- --------------------------------------------------------
-- 1. CATEGORIES TABLE
-- Stores dynamic product categories.
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bileklik_kategori` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Kategori_Ad` varchar(255) NOT NULL COMMENT 'Name of the category',
  `sort_order` int(11) DEFAULT '0' COMMENT 'UI display order',
  `status` tinyint(1) DEFAULT '1' COMMENT '1: Active, 0: Passive',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_kategori_ad` (`Kategori_Ad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- 2. PRODUCTS TABLE
-- Main product registry.
-- Note: In this architecture, products are linked to categories.
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bileklik` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Urun_Ad` varchar(255) NOT NULL,
  `Urun_Kategori` varchar(255) NOT NULL,
  `Urun_Fiyat` decimal(10,2) NOT NULL COMMENT 'Decimal format for currency accuracy',
  `Urun_Stok` enum('var','yok') NOT NULL DEFAULT 'var' COMMENT 'Stock availability status',
  `Urun_Link` varchar(500) DEFAULT NULL COMMENT 'External purchasing link (e.g., Shopier)',
  PRIMARY KEY (`id`),
  KEY `idx_urun_ad` (`Urun_Ad`), -- Indexed for faster JOINs and subqueries
  KEY `idx_urun_stok` (`Urun_Stok`) -- Indexed for sorting algorithms
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- 3. PRODUCT IMAGES (MEDIA GALLERY)
-- Stores multiple images for a single product (One-to-Many Relationship).
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bileklik_resimler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Urun_Ad` varchar(255) NOT NULL COMMENT 'Foreign Key equivalent referencing products table',
  `Urun_Resim` varchar(500) NOT NULL COMMENT 'Cloudinary or local image URL',
  PRIMARY KEY (`id`),
  KEY `idx_resim_urun_ad` (`Urun_Ad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ==============================================================================
-- ARCHITECTURAL NOTES:
-- * Used ENUM for boolean-like states (Stok: var/yok) to optimize storage.
-- * Indexes (KEY) are strategically placed on 'Urun_Ad' and 'Urun_Stok' to 
--   prevent full-table scans during the GROUP_CONCAT subqueries and frontend filtering.
-- * DECIMAL(10,2) is strictly used for prices to prevent floating-point math errors.
-- ==============================================================================