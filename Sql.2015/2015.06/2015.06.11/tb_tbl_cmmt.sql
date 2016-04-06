USE ggisql;

CREATE TABLE `tb_tbl_cmmt` (
  `cmmt_numb` int(11) NOT NULL AUTO_INCREMENT COMMENT '댓글번호',
  `board_dvs` varchar(30) NOT NULL COMMENT '구분',
  `info_numb` int(11) NOT NULL COMMENT '테이블상세정보 번호',
  `comment` varchar(200) DEFAULT NULL COMMENT '댓글내용',
  `rege_id` varchar(16) NOT NULL COMMENT '작성자',
  `rege_date` date NOT NULL COMMENT '작성일',
  PRIMARY KEY (`cmmt_numb`,`board_dvs`,`info_numb`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='댓글테이블';


INSERT INTO `tb_tbl_cmmt`(`cmmt_numb`,`board_dvs`,`info_numb`,`comment`,`rege_id`,`rege_date`) VALUES (1,'F0200',74,'11111111','AA','2015-06-09');
INSERT INTO `tb_tbl_cmmt`(`cmmt_numb`,`board_dvs`,`info_numb`,`comment`,`rege_id`,`rege_date`) VALUES (2,'F0200',74,'22222','BB','2015-06-09');
