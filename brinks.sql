CREATE TABLE `brinks_spawn` (
  `coords_blips` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `coords_bag` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `brinks_spawn`
  ADD UNIQUE KEY `coords_blips` (`coords_blips`) USING HASH;
COMMIT;

