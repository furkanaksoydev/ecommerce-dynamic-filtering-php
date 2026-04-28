-- ==============================================================================
-- RESTAURANT MENU ARCHITECTURE (Kaptan Döner & Tantuni)
-- Engine: InnoDB | Charset: utf8mb4_unicode_ci
-- Demonstrates One-to-Many relationship (Category -> Products) and indexing.
-- ==============================================================================

-- --------------------------------------------------------
-- 1. CATEGORIES TABLE (`kategoriler`)
-- Manages menu categories dynamically with SVG icon support.
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `kategoriler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Kategori Adı (Örn: Tantuni)',
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'URL ve ID yapısı için (Örn: tantuni)',
  `description` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Kategori Açıklaması',
  `icon_svg` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SVG ikon kodu',
  `sort_order` int(11) DEFAULT '0' COMMENT 'Sıralama sırası',
  `status` tinyint(1) DEFAULT '1' COMMENT '1: Aktif, 0: Pasif',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_slug` (`slug`),
  KEY `idx_status_sort` (`status`, `sort_order`) -- Composite index for fast frontend fetching
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- 2. PRODUCTS TABLE (`urunler`)
-- Manages individual menu items linked to categories.
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `urunler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL COMMENT 'Hangi kategoriye ait olduğu (Foreign Key)',
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Ürün adı',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Kısa açıklama',
  `description2` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Kısa Açıklama 2',
  `price` decimal(10,2) NOT NULL COMMENT 'Fiyat (Örn: 140.00)',
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'default.jpg' COMMENT 'Resim yolu',
  `sort_order` int(11) DEFAULT '0' COMMENT 'Kategori içi sıralama',
  `status` tinyint(1) DEFAULT '1' COMMENT '1: Aktif, 0: Pasif',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`), -- Crucial for grouping logic in PHP (MenuController)
  KEY `idx_status_sort` (`status`, `sort_order`),
  -- Strict Relational Integrity: If a category is deleted, its products are removed automatically.
  CONSTRAINT `fk_urun_kategori` FOREIGN KEY (`category_id`) REFERENCES `kategoriler` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==============================================================================
-- ARCHITECTURAL HIGHLIGHTS:
-- * DEFAULT 'default.jpg' ensures UI does not break when an image is missing.
-- * utf8mb4_unicode_ci collation used for full Unicode support (including emojis).
-- * FOREIGN KEY constraints maintain database integrity without requiring extra PHP code.
-- ==============================================================================