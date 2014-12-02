DROP TABLE IF EXISTS line_memo;
CREATE TABLE line_memo(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(64),
	msg VARCHAR(255),
	msg_time TIMESTAMP
);

INSERT INTO line_memo(name, msg) VALUES('정호영', '여러분 안녕하세요');
INSERT INTO line_memo(name, msg) VALUES('임은주', '안녕들하십니까');
INSERT INTO line_memo(name, msg) VALUES('김용', '용이산다');
