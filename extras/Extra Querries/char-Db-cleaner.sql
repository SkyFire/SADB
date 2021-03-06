DELETE FROM `playeritems` WHERE `ownerguid` NOT IN (SELECT `guid` FROM `characters`);  
DELETE FROM `tutorials` WHERE `playerId` NOT IN (SELECT `guid` FROM `characters`);  
DELETE FROM `social_friends` WHERE `character_guid` NOT IN (SELECT `guid` FROM `characters`);  
DELETE FROM `social_ignores` WHERE `character_guid` NOT IN (SELECT `guid` FROM `characters`);  
DELETE FROM `questlog` WHERE `player_guid` NOT IN (SELECT `guid` FROM `characters`);  
DELETE FROM `corpses` WHERE `guid` NOT IN (SELECT `guid` FROM `characters`);  
DELETE FROM `mailbox` WHERE `player_guid` NOT IN (SELECT `guid` FROM `characters`);
DELETE FROM `characters` WHERE `acct` NOT IN (SELECT `acct` FROM `accounts`);
DELETE FROM `gm_tickets` WHERE `playerGuid` NOT IN (SELECT `guid` FROM `characters`);