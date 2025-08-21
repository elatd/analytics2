-- CreateTable
CREATE TABLE `user` (
    `user_id` VARCHAR(36) NOT NULL,
    `username` VARCHAR(255) NOT NULL,
    `password` VARCHAR(60) NOT NULL,
    `role` VARCHAR(50) NOT NULL,
    `logo_url` VARCHAR(2183) NULL,
    `display_name` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `user_user_id_key`(`user_id`),
    UNIQUE INDEX `user_username_key`(`username`),
    PRIMARY KEY (`user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `session` (
    `session_id` VARCHAR(36) NOT NULL,
    `website_id` VARCHAR(36) NOT NULL,
    `browser` VARCHAR(20) NULL,
    `os` VARCHAR(20) NULL,
    `device` VARCHAR(20) NULL,
    `screen` VARCHAR(11) NULL,
    `language` VARCHAR(35) NULL,
    `country` CHAR(2) NULL,
    `region` CHAR(20) NULL,
    `city` VARCHAR(50) NULL,
    `distinct_id` VARCHAR(50) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `session_session_id_key`(`session_id`),
    INDEX `session_created_at_idx`(`created_at`),
    INDEX `session_website_id_idx`(`website_id`),
    INDEX `session_website_id_created_at_idx`(`website_id`, `created_at`),
    INDEX `session_website_id_created_at_browser_idx`(`website_id`, `created_at`, `browser`),
    INDEX `session_website_id_created_at_os_idx`(`website_id`, `created_at`, `os`),
    INDEX `session_website_id_created_at_device_idx`(`website_id`, `created_at`, `device`),
    INDEX `session_website_id_created_at_screen_idx`(`website_id`, `created_at`, `screen`),
    INDEX `session_website_id_created_at_language_idx`(`website_id`, `created_at`, `language`),
    INDEX `session_website_id_created_at_country_idx`(`website_id`, `created_at`, `country`),
    INDEX `session_website_id_created_at_region_idx`(`website_id`, `created_at`, `region`),
    INDEX `session_website_id_created_at_city_idx`(`website_id`, `created_at`, `city`),
    PRIMARY KEY (`session_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `website` (
    `website_id` VARCHAR(36) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `domain` VARCHAR(500) NULL,
    `share_id` VARCHAR(50) NULL,
    `reset_at` TIMESTAMP(0) NULL,
    `user_id` VARCHAR(36) NULL,
    `team_id` VARCHAR(36) NULL,
    `created_by` VARCHAR(36) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `website_website_id_key`(`website_id`),
    UNIQUE INDEX `website_share_id_key`(`share_id`),
    INDEX `website_user_id_idx`(`user_id`),
    INDEX `website_team_id_idx`(`team_id`),
    INDEX `website_created_at_idx`(`created_at`),
    INDEX `website_share_id_idx`(`share_id`),
    INDEX `website_created_by_idx`(`created_by`),
    PRIMARY KEY (`website_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `website_event` (
    `event_id` VARCHAR(36) NOT NULL,
    `website_id` VARCHAR(36) NOT NULL,
    `session_id` VARCHAR(36) NOT NULL,
    `visit_id` VARCHAR(36) NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `url_path` VARCHAR(500) NOT NULL,
    `url_query` VARCHAR(500) NULL,
    `utm_source` VARCHAR(255) NULL,
    `utm_medium` VARCHAR(255) NULL,
    `utm_campaign` VARCHAR(255) NULL,
    `utm_content` VARCHAR(255) NULL,
    `utm_term` VARCHAR(255) NULL,
    `referrer_path` VARCHAR(500) NULL,
    `referrer_query` VARCHAR(500) NULL,
    `referrer_domain` VARCHAR(500) NULL,
    `page_title` VARCHAR(500) NULL,
    `gclid` VARCHAR(255) NULL,
    `fbclid` VARCHAR(255) NULL,
    `msclkid` VARCHAR(255) NULL,
    `ttclid` VARCHAR(255) NULL,
    `li_fat_id` VARCHAR(255) NULL,
    `twclid` VARCHAR(255) NULL,
    `event_type` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `event_name` VARCHAR(50) NULL,
    `tag` VARCHAR(50) NULL,
    `hostname` VARCHAR(100) NULL,

    INDEX `website_event_created_at_idx`(`created_at`),
    INDEX `website_event_session_id_idx`(`session_id`),
    INDEX `website_event_visit_id_idx`(`visit_id`),
    INDEX `website_event_website_id_idx`(`website_id`),
    INDEX `website_event_website_id_created_at_idx`(`website_id`, `created_at`),
    INDEX `website_event_website_id_created_at_url_path_idx`(`website_id`, `created_at`, `url_path`),
    INDEX `website_event_website_id_created_at_url_query_idx`(`website_id`, `created_at`, `url_query`),
    INDEX `website_event_website_id_created_at_referrer_domain_idx`(`website_id`, `created_at`, `referrer_domain`),
    INDEX `website_event_website_id_created_at_page_title_idx`(`website_id`, `created_at`, `page_title`),
    INDEX `website_event_website_id_created_at_event_name_idx`(`website_id`, `created_at`, `event_name`),
    INDEX `website_event_website_id_created_at_tag_idx`(`website_id`, `created_at`, `tag`),
    INDEX `website_event_website_id_session_id_created_at_idx`(`website_id`, `session_id`, `created_at`),
    INDEX `website_event_website_id_visit_id_created_at_idx`(`website_id`, `visit_id`, `created_at`),
    INDEX `website_event_website_id_created_at_hostname_idx`(`website_id`, `created_at`, `hostname`),
    PRIMARY KEY (`event_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `event_data` (
    `event_data_id` VARCHAR(36) NOT NULL,
    `website_id` VARCHAR(36) NOT NULL,
    `website_event_id` VARCHAR(36) NOT NULL,
    `data_key` VARCHAR(500) NOT NULL,
    `string_value` VARCHAR(500) NULL,
    `number_value` DECIMAL(19, 4) NULL,
    `date_value` TIMESTAMP(0) NULL,
    `data_type` INTEGER UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `event_data_created_at_idx`(`created_at`),
    INDEX `event_data_website_id_idx`(`website_id`),
    INDEX `event_data_website_event_id_idx`(`website_event_id`),
    INDEX `event_data_website_id_created_at_idx`(`website_id`, `created_at`),
    INDEX `event_data_website_id_created_at_data_key_idx`(`website_id`, `created_at`, `data_key`),
    PRIMARY KEY (`event_data_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `session_data` (
    `session_data_id` VARCHAR(36) NOT NULL,
    `website_id` VARCHAR(36) NOT NULL,
    `session_id` VARCHAR(36) NOT NULL,
    `data_key` VARCHAR(500) NOT NULL,
    `string_value` VARCHAR(500) NULL,
    `number_value` DECIMAL(19, 4) NULL,
    `date_value` TIMESTAMP(0) NULL,
    `data_type` INTEGER UNSIGNED NOT NULL,
    `distinct_id` VARCHAR(50) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `session_data_created_at_idx`(`created_at`),
    INDEX `session_data_website_id_idx`(`website_id`),
    INDEX `session_data_session_id_idx`(`session_id`),
    INDEX `session_data_session_id_created_at_idx`(`session_id`, `created_at`),
    INDEX `session_data_website_id_created_at_data_key_idx`(`website_id`, `created_at`, `data_key`),
    PRIMARY KEY (`session_data_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `team` (
    `team_id` VARCHAR(36) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `access_code` VARCHAR(50) NULL,
    `logo_url` VARCHAR(2183) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `team_team_id_key`(`team_id`),
    UNIQUE INDEX `team_access_code_key`(`access_code`),
    INDEX `team_access_code_idx`(`access_code`),
    PRIMARY KEY (`team_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `team_user` (
    `team_user_id` VARCHAR(36) NOT NULL,
    `team_id` VARCHAR(36) NOT NULL,
    `user_id` VARCHAR(36) NOT NULL,
    `role` VARCHAR(50) NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `team_user_team_user_id_key`(`team_user_id`),
    INDEX `team_user_team_id_idx`(`team_id`),
    INDEX `team_user_user_id_idx`(`user_id`),
    PRIMARY KEY (`team_user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `report` (
    `report_id` VARCHAR(36) NOT NULL,
    `user_id` VARCHAR(36) NOT NULL,
    `website_id` VARCHAR(36) NOT NULL,
    `type` VARCHAR(200) NOT NULL,
    `name` VARCHAR(200) NOT NULL,
    `description` VARCHAR(500) NOT NULL,
    `parameters` JSON NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `report_report_id_key`(`report_id`),
    INDEX `report_user_id_idx`(`user_id`),
    INDEX `report_website_id_idx`(`website_id`),
    INDEX `report_type_idx`(`type`),
    INDEX `report_name_idx`(`name`),
    PRIMARY KEY (`report_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `segment` (
    `segment_id` VARCHAR(36) NOT NULL,
    `website_id` VARCHAR(36) NOT NULL,
    `type` VARCHAR(200) NOT NULL,
    `name` VARCHAR(200) NOT NULL,
    `parameters` JSON NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `segment_segment_id_key`(`segment_id`),
    INDEX `segment_website_id_idx`(`website_id`),
    PRIMARY KEY (`segment_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `revenue` (
    `revenue_id` VARCHAR(36) NOT NULL,
    `website_id` VARCHAR(36) NOT NULL,
    `session_id` VARCHAR(36) NOT NULL,
    `event_id` VARCHAR(36) NOT NULL,
    `event_name` VARCHAR(50) NOT NULL,
    `currency` VARCHAR(100) NOT NULL,
    `revenue` DECIMAL(19, 4) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `revenue_revenue_id_key`(`revenue_id`),
    INDEX `revenue_website_id_idx`(`website_id`),
    INDEX `revenue_session_id_idx`(`session_id`),
    INDEX `revenue_website_id_created_at_idx`(`website_id`, `created_at`),
    INDEX `revenue_website_id_session_id_created_at_idx`(`website_id`, `session_id`, `created_at`),
    PRIMARY KEY (`revenue_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

