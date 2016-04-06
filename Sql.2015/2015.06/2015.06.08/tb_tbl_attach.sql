USE ggisql;

CREATE TABLE `tb_tbl_attach` (
  `info_numb` int(11) NOT NULL COMMENT '테이블상세정보 번호',
  `board_dvs` varchar(30) NOT NULL COMMENT '구분',
  `attach_numb` int(11) NOT NULL COMMENT '첨부파일순번',
  `extension` varchar(10) NOT NULL COMMENT '확장자',
  `file_name` varchar(100) NOT NULL COMMENT '파일명',
  `file_root` varchar(100) NOT NULL COMMENT '경로',
  `file_size` int(11) NOT NULL COMMENT '용량',
  PRIMARY KEY (`info_numb`,`board_dvs`,`attach_numb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='첨부파일테이블';


INSERT INTO `tb_tbl_attach`(`info_numb`,`board_dvs`,`attach_numb`,`extension`,`file_name`,`file_root`,`file_size`) VALUES (46,'F0200',1,'jpg','Chrysanthemum.jpg','C:\devGgi\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\portal\downfile',858);
