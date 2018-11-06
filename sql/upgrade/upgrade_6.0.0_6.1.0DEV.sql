-- This script upgrades table structure, data, and privileges
-- from/to the exact version numbers specified in the filename.

--
-- First execute a check whether this upgrade should apply. The check
-- below should fail if this upgrade has already been applied, but
-- keep everything unchanged if not.
--

-- @UPGRADE-CHECK@
INSERT INTO `configuration` (`name`, `value`) VALUES ('data_source', '0');
DELETE FROM `configuration` WHERE `name` = 'data_source';

--
-- Create additional structures
--
ALTER TABLE `configuration`
  ADD COLUMN `category` varchar(32) NOT NULL DEFAULT 'Uncategorized' COMMENT 'Option category of the configuration variable' AFTER `public`;

--
-- Add/remove sample/initial contents
--
INSERT INTO `configuration` (`name`, `value`, `type`, `public`, `category` `description`) VALUES
('data_source', '0', 'int', '0', 'Misc', 'Source of data. Choices: 0 = all local, 1 = configuration data external, 2 = configuration and live data external'),
('update_judging_seconds', '0', 'int', '0', 'Judging', 'Post updates to a judging every X seconds. Set to 0 to update after each judging_run.');
