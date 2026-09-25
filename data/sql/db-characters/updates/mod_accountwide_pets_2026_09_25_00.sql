-- Every companion pet learned by a character on the account. Same table as mod-accountwide, so an
-- existing install keeps its data.
CREATE TABLE IF NOT EXISTS `accountwide_pets` (
    `account_id`    INT UNSIGNED NOT NULL,
    `spell`         INT UNSIGNED NOT NULL,
    PRIMARY KEY (`account_id`, `spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
