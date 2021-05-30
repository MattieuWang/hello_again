USE ip_database;

DROP TRIGGER IF EXISTS after_ip_update;
DROP TRIGGER IF EXISTS after_blacklist_update;

DELIMITER $$

CREATE TRIGGER after_ip_update
AFTER UPDATE
ON ip_lists FOR EACH ROW
BEGIN
    IF new.count > 100 THENf
        INSERT INTO blacklist(ip)
        VALUES(old.ip) ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;
    END IF;
END$$

DELIMITER ;
